package uca.iiss;
import java.time.LocalDate;
import java.util.Comparator;

@CompareAnnotation(compare = BankAccountComparatorById.class)
public final class BankAccount implements Comparable<BankAccount>{
    private final String id;
    private LocalDate creationDate;
    private Comparator<BankAccount> comparator;

    public BankAccount(String number) {
        this.id = number;
        this.comparator = new BankAccountComparatorById();
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDate date) {
        this.creationDate = date;
    }

    public String getId() {
        return id;
    }

    public void setComparator(Comparator<BankAccount> cmp) {
        this.comparator = cmp;
    }

    @Override
    public int compareTo(BankAccount other) {
        if (this.equals(other))
            return 0;
        return comparator.compare(this, other);
    }

    @Override
    public boolean equals(Object other) {
        if (this == other)
            return true;
        if (!(other instanceof BankAccount))
            return false;
        BankAccount that = (BankAccount) other;
        return this.id.equals(that.getId());
    }

    @Override
    public String toString() {
        return id;
    }
}
