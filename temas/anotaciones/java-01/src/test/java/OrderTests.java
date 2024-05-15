package main.java;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import main.java.DependencyInjector;
import main.java.Order;
import main.java.OrderByAmountComparator;
import main.java.OrderByDateComparator;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;
import java.util.Comparator;

class OrderTests {
    private Order order1, order2, order3;

    @BeforeEach
    void setUp() throws IllegalAccessException, InstantiationException {
        order1 = new Order(1, LocalDate.of(2022, 1, 1), 100.0);
        order2 = new Order(2, LocalDate.of(2022, 1, 1), 150.0);
        order3 = new Order(3, LocalDate.of(2021, 12, 31), 100.0);

        DependencyInjector.inject(order1);
        DependencyInjector.inject(order2);
        DependencyInjector.inject(order3);
    }

    @Test
    void testCompareByDate() {
        Comparator<Order> comp = order1.getComparatorDate();
        assertEquals(0, comp.compare(order1, order2));
        assertTrue(comp.compare(order1, order3) > 0);
        assertTrue(comp.compare(order3, order1) < 0);
    }

    @Test
    void testCompareByAmount() {
        Comparator<Order> comp = order1.getComparatorAmount();
        assertTrue(comp.compare(order1, order2) < 0);
        assertTrue(comp.compare(order2, order1) > 0);
        assertEquals(0, comp.compare(order1, order3));
    }

    @Test
    void testDependencyInjection() {
        // Verificar si los comparadores están correctamente inyectados
        assertNotNull(order1.getComparatorDate());
        assertNotNull(order1.getComparatorAmount());
        assertNotNull(order2.getComparatorDate());
        assertNotNull(order2.getComparatorAmount());
        assertInstanceOf(OrderByDateComparator.class, order1.getComparatorDate());
        assertInstanceOf(OrderByAmountComparator.class, order1.getComparatorAmount());
    }

    @Test
    void testEquality() {
        assertEquals(new Order(1, LocalDate.of(2022, 1, 1), 100.0), order1);
        assertNotEquals(order1, order2);
        assertNotEquals(order1, order3);
    }

    @Test
    void testUninitializedComparatorThrowsException() {
        // Crear una orden sin inyectar dependencias
        Order order3 = new Order(3, LocalDate.of(2023, 5, 3), 200);
        Exception exception = assertThrows(IllegalStateException.class, () -> order3.compareTo(order2));
        assertEquals("Comparator not initialized", exception.getMessage());
    }
}
