public with sharing class AccountControllerDatatable {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Industry, NumberOfEmployees FROM Account WITH USER_MODE LIMIT 50];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {

        return [
            SELECT Id, Name, Industry, Phone
            FROM Account
            ORDER BY Name
            LIMIT 20
        ];
    }
}