package uca.iiss;

import java.util.ArrayList;
import java.util.List;

public class BankAccountSort {
    private List<BankAccount> accounts;

    public BankAccountSort(){
        this.accounts = new ArrayList<>();
    }
    public void addAccount(BankAccount b){
        accounts.add(b);
    }

    public BankAccount getSortedAccounts(int index){
        return accounts.get(index);
    }

    public void sort(){
        accounts.sort(BankAccount::compareTo);
    }

}
