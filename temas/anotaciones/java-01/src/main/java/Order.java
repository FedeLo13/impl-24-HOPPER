package main.java;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.Objects;

public class Order implements Comparable<Order> {
    private int orderId;
    private LocalDate date;
    private double amount;

    @CompareByDate
    private Comparator<Order> comparatorDate;

    @CompareByAmount
    private Comparator<Order> comparatorAmount;

    public Order(int orderId, LocalDate date, double amount) {
        this.orderId = orderId;
        this.date = date;
        this.amount = amount;
    }

    public LocalDate getDate() {
        return date;
    }

    public double getAmount() {
        return amount;
    }

    public int getOrderId() {
        return orderId;
    }

    public Comparator<Order> getComparatorDate() {
        return comparatorDate;
    }

    public Comparator<Order> getComparatorAmount() {
        return comparatorAmount;
    }

    @Override
    public int compareTo(Order other) {
        if (this.comparatorDate == null) {
            throw new IllegalStateException("Comparator not initialized");
        }
        return comparatorDate.compare(this, other);
    }

    public int compareToAmount(Order other) {
        if (this.comparatorAmount == null) {
            throw new IllegalStateException("Comparator not initialized");
        }
        return comparatorAmount.compare(this, other);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Order order = (Order) obj;
        return orderId == order.orderId &&
            Double.compare(order.amount, amount) == 0 &&
            Objects.equals(date, order.date);
    }


}
