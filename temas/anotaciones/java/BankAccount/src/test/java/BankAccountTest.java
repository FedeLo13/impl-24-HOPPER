import uca.iiss.BankAccount;
import java.time.LocalDate;
import org.junit.jupiter.api.*;
import uca.iiss.BankAccountSort;



import static org.junit.jupiter.api.Assertions.assertEquals;

public class BankAccountTest {

    private BankAccount a1, a2, a3;
    private BankAccountSort bankAccountSort;

    @BeforeEach
    public void setup(){

        a1 = new BankAccount("1");
        a1.setCreationDate(LocalDate.of(2022, 5, 1));

        a2 = new BankAccount("2");
        a2.setCreationDate(LocalDate.of(2022, 6, 1));

        a3 = new BankAccount("3");
        a3.setCreationDate(LocalDate.of(2022, 7, 1));
    }

    @Test
    public void BankAccountSortTest(){
        bankAccountSort = new BankAccountSort();

        bankAccountSort.addAccount(a2);
        bankAccountSort.addAccount(a1);
        bankAccountSort.addAccount(a3);

        bankAccountSort.sort();

        assertEquals("1", bankAccountSort.getSortedAccounts(0).getId());
        assertEquals("2", bankAccountSort.getSortedAccounts(1).getId());
        assertEquals("3", bankAccountSort.getSortedAccounts(2).getId());
    }
}
