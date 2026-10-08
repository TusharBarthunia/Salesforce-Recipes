/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@IsTest
private with sharing class SoslSearchDemoTest {

    @TestSetup
    static void createTestData() {

        Account techAccount = new Account(
            Name = 'Salesforce Technology Account',
            Industry = 'Technology'
        );

        Account nonTechAccount = new Account(
            Name = 'Salesforce Finance Account',
            Industry = 'Finance'
        );

        insert new List<Account>{
            techAccount,
            nonTechAccount
        };

        insert new List<Contact>{
            new Contact(
                FirstName = 'John',
                LastName = 'Salesforce',
                Email = 'john@example.com',
                AccountId = techAccount.Id
            ),
            new Contact(
                FirstName = 'David',
                LastName = 'Salesforce',
                Email = 'david@example.com',
                AccountId = nonTechAccount.Id
            )
        };
    }


    /*
     * Scenario 1:
     * If Test.setFixedSearchResults() is NOT called,
     * SOSL returns an empty result in a test method.
     */
    @IsTest
    static void testSoslReturnsEmptyResultsByDefault() {

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchAccountsAndContacts();

        Test.stopTest();
        System.debug('Test Method 1 '+searchResults.size());
        System.debug('Test Method 1.1 '+searchResults[0].size());
        System.assertEquals(
            0,
            searchResults[0].size(),
            'Account SOSL result should be empty by default.'
        );

        System.assertEquals(
            0,
            searchResults[1].size(),
            'Contact SOSL result should be empty by default.'
        );
    }


    /*
     * Scenario 2:
     * Use Test.setFixedSearchResults() to provide
     * specific records for the SOSL query.
     */
    @IsTest
    static void testSoslWithFixedSearchResults() {

        Account accountRecord = [
            SELECT Id, Name
            FROM Account
            WHERE Name = 'Salesforce Technology Account'
            LIMIT 1
        ];

        Test.setFixedSearchResults(
            new List<Id>{
                accountRecord.Id
            }
        );

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchAccountsAndContacts();

        Test.stopTest();

        System.assertEquals(
            1,
            searchResults[0].size(),
            'The fixed Account should be returned.'
        );

        System.assertEquals(
            accountRecord.Id,
            searchResults[0][0].Id
        );
    }


    /*
     * Scenario 3:
     * WHERE clause is applied to the fixed search results.
     *
     * Both records are supplied as fixed results,
     * but only the Technology Account satisfies
     * the WHERE condition.
     */
    @IsTest
    static void testFixedResultsWithWhereClause() {

        List<Account> accounts = [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Name LIKE 'Salesforce%'
        ];

        List<Id> fixedSearchResults = new List<Id>();

        for (Account acc : accounts) {
            fixedSearchResults.add(acc.Id);
        }

        Test.setFixedSearchResults(fixedSearchResults);

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchAccountsWithFilter();

        Test.stopTest();

        System.assertEquals(
            1,
            searchResults[0].size(),
            'Only Technology Account should pass the WHERE filter.'
        );

        Account resultAccount =
            (Account) searchResults[0][0];

        System.assertEquals(
            'Technology',
            resultAccount.Industry
        );
    }


    /*
     * Scenario 4:
     * LIMIT clause is applied to the fixed search results.
     */
    @IsTest
    static void testFixedResultsWithLimit() {

        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Name LIKE 'Salesforce%'
        ];

        List<Id> fixedSearchResults = new List<Id>();

        for (Account acc : accounts) {
            fixedSearchResults.add(acc.Id);
        }

        Test.setFixedSearchResults(fixedSearchResults);

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchAccountsWithLimit();

        Test.stopTest();

        System.assertEquals(
            1,
            searchResults[0].size(),
            'LIMIT 1 should restrict the result to one record.'
        );
    }


    /*
     * Scenario 5:
     * Test.setFixedSearchResults() can be called multiple times
     * to provide different result sets for different SOSL queries.
     */
    @IsTest
    static void testMultipleFixedSearchResultSets() {

        Account accountRecord = [
            SELECT Id
            FROM Account
            WHERE Name = 'Salesforce Technology Account'
            LIMIT 1
        ];

        Contact contactRecord = [
            SELECT Id
            FROM Contact
            WHERE LastName = 'Salesforce'
            LIMIT 1
        ];

        /*
         * First SOSL query should return Account.
         */
        Test.setFixedSearchResults(
            new List<Id>{
                accountRecord.Id
            }
        );

        List<List<SObject>> firstSearch =
            SoslSearchDemo.searchAccountsAndContacts();

        System.assertEquals(
            1,
            firstSearch[0].size()
        );

        /*
         * Change the fixed result set.
         * Subsequent SOSL queries use this new set.
         */
        Test.setFixedSearchResults(
            new List<Id>{
                contactRecord.Id
            }
        );

        List<List<SObject>> secondSearch =
            SoslSearchDemo.searchAccountsAndContacts();

        System.assertEquals(
            1,
            secondSearch[1].size()
        );

        System.assertEquals(
            contactRecord.Id,
            secondSearch[1][0].Id
        );
    }


    /*
     * Scenario 6:
     * Fixed search results can contain records from
     * multiple objects.
     */
    @IsTest
    static void testMultipleObjectsWithFixedResults() {

        Account accountRecord = [
            SELECT Id
            FROM Account
            WHERE Name = 'Salesforce Technology Account'
            LIMIT 1
        ];

        Contact contactRecord = [
            SELECT Id
            FROM Contact
            WHERE LastName = 'Salesforce'
            LIMIT 1
        ];

        Test.setFixedSearchResults(
            new List<Id>{
                accountRecord.Id,
                contactRecord.Id
            }
        );

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchMultipleObjects();

        Test.stopTest();

        System.assertEquals(
            1,
            searchResults[0].size(),
            'Account should be returned.'
        );

        System.assertEquals(
            1,
            searchResults[1].size(),
            'Contact should be returned.'
        );
    }


    /*
     * Scenario 7:
     * Calling setFixedSearchResults with an empty list
     * makes subsequent SOSL queries return no records.
     */
    @IsTest
    static void testEmptyFixedSearchResults() {

        Test.setFixedSearchResults(
            new List<Id>()
        );

        Test.startTest();

        List<List<SObject>> searchResults =
            SoslSearchDemo.searchAccountsAndContacts();

        Test.stopTest();

        System.assertEquals(
            0,
            searchResults[0].size()
        );

        System.assertEquals(
            0,
            searchResults[1].size()
        );
    }
}