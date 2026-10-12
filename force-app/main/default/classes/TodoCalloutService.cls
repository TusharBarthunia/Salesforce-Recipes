public with sharing class TodoCalloutService {
    public static void getTodo(Id accountId) {

        // Query the Account created by the caller
        Account acc = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        req.setMethod('GET');

        Http http = new Http();

        HttpResponse response = http.send(req);

        if (response.getStatusCode() == 200) {

            System.debug('Account: ' + acc.Name);
            System.debug('Todo Response: ' + response.getBody());

        } else {

            System.debug(
                'Callout failed. Status Code: ' +
                response.getStatusCode()
            );
        }
    }
}