public with sharing class SoslSearchDemo {

    /*
     * Scenario 1:
     * Search across multiple objects.
     */
    public static List<List<SObject>> searchAccountsAndContacts() {

        return [
            FIND 'Salesforce'
            IN ALL FIELDS
            RETURNING
                Account(Id, Name),
                Contact(Id, FirstName, LastName, Email)
        ];
    }


    /*
     * Scenario 2:
     * SOSL with WHERE clause.
     */
    public static List<List<SObject>> searchAccountsWithFilter() {

        return [
            FIND 'Salesforce'
            IN ALL FIELDS
            RETURNING
                Account(
                    Id,
                    Name
                    WHERE Industry = 'Technology'
                )
        ];
    }


    /*
     * Scenario 3:
     * SOSL with LIMIT clause.
     */
    public static List<List<SObject>> searchAccountsWithLimit() {

        return [
            FIND 'Salesforce'
            IN ALL FIELDS
            RETURNING
                Account(
                    Id,
                    Name
                    LIMIT 1
                )
        ];
    }


    /*
     * Scenario 4:
     * SOSL returning multiple objects with filters and limits.
     */
    public static List<List<SObject>> searchMultipleObjects() {

        return [
            FIND 'Salesforce'
            IN ALL FIELDS
            RETURNING
                Account(
                    Id,
                    Name
                    WHERE Industry = 'Technology'
                    LIMIT 5
                ),
                Contact(
                    Id,
                    FirstName,
                    LastName
                    LIMIT 5
                )
        ];
    }
}