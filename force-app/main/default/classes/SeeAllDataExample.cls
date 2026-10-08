@IsTest(SeeAllData=true)
private class SeeAllDataExample {

    @IsTest
    static void testDeleteTrigger() {

        // Create a new Account in the test transaction
        Account testAccount = new Account(
            Name = 'Black1'
        );
        insert testAccount;

        // Query all Accounts whose name starts with "Test" incuding org data
        List<Account> testAccounts = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Black%'
        ];

        System.debug('@@Test Method 1 '+testAccounts.size());
        // Existing org data + newly inserted test data
        System.assert(
            testAccounts.size() > 0,
            'At least one Test Account should exist.'
        );

        // Delete all matching Accounts in the test transaction (including org data)
        delete testAccounts;

        // Query again after deletion
        testAccounts = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Black%'
        ];
        System.debug('@@Test Method 2 '+testAccounts.size());  //it will print 0 because all the records are deleted in the test transaction
        // All matching Accounts are deleted within this test transaction
        System.assertEquals(
            0,
            testAccounts.size(),
            'No Test Accounts should remain in the test transaction.'
        );
    }

    //after the test method is completed, all the records created in the test transaction will be rolled back and the org data will remain intact
}