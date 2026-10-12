@IsTest
private class TodoCalloutServiceTest {

    @IsTest
    static void testTodoCallout() {

        // 1. Create Account
        Account acc = new Account(
            Name = 'Test Account'
        );

        insert acc;

        // 2. Register mock BEFORE startTest()
        Test.setMock(
            HttpCalloutMock.class,
            new TodoCalloutMock()
        );

        // 3. Start test context
        Test.startTest();
        /*  //if we put the Setmock line here then also the test class coverage will be 100%
        Test.setMock(
            HttpCalloutMock.class,
            new TodoCalloutMock()
        );
		*/
        // 4. Call future method
        TodoCalloutService.getTodo(acc.Id);

        // 5. stopTest() causes the future method to execute
        Test.stopTest();

        // Verify Account was created
        Account insertedAccount = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :acc.Id
        ];

        System.assertEquals(
            'Test Account',
            insertedAccount.Name
        );
    }


    /*
     * Mock response for the HTTP callout.
     */
    private class TodoCalloutMock implements HttpCalloutMock {

        public HttpResponse respond(HttpRequest req) {

            // Verify request details
            System.assertEquals(
                'GET',
                req.getMethod()
            );

            System.assertEquals(
                'https://jsonplaceholder.typicode.com/todos/1',
                req.getEndpoint()
            );

            // Create mock response
            HttpResponse response = new HttpResponse();

            response.setStatusCode(200);

            response.setHeader(
                'Content-Type',
                'application/json'
            );

            response.setBody(
                '{"userId":1,"id":1,"title":"delectus aut autem","completed":false}'
            );

            return response;
        }
    }
}