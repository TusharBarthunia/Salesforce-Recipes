public with sharing class AccountControllerDatatable {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Industry, NumberOfEmployees FROM Account WITH USER_MODE LIMIT 50];
    }
}