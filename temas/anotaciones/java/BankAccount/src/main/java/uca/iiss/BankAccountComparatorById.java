package uca.iiss;

import java.util.*;

public class BankAccountComparatorById implements Comparator<BankAccount> {
    @Override
    public int compare(BankAccount o1, BankAccount o2) {
        return o1.getId().compareTo(o2.getId());
    }
}