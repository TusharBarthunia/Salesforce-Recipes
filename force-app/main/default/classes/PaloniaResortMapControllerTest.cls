@IsTest
private class PaloniaResortMapControllerTest {
    @IsTest
    static void returnsGuestInterestsAndExperiences() {
        Guest__c guest = new Guest__c(
            Interest_1__c = 'Snorkeling',
            Interest_2__c = 'Spa & Wellness'
        );
        insert guest;

        Experience__c experience = new Experience__c(
            Name = 'Reef Discovery',
            Type__c = 'Snorkeling',
            Price__c = 85,
            Duration_Hours__c = 2,
            Activity_Level__c = 'Medium',
            Location__c = 'South Beach',
            Map_X__c = 35,
            Map_Y__c = 83
        );
        insert experience;

        Test.startTest();
        PaloniaResortMapController.ResortMapData result =
            PaloniaResortMapController.getMapData(guest.Id);
        Test.stopTest();

        System.assertEquals(
            new List<String>{ 'Snorkeling', 'Spa & Wellness' },
            result.interests
        );
        System.assertEquals(1, result.experiences.size());
        System.assertEquals(experience.Id, result.experiences[0].Id);
        System.assertEquals('Reef Discovery', result.experiences[0].Name);
    }

    @IsTest
    static void rejectsUnknownGuest() {
        Test.startTest();
        try {
            PaloniaResortMapController.getMapData(UserInfo.getUserId());
            System.assert(false, 'An unrelated record ID must not return map data.');
        } catch (AuraHandledException exceptionThrown) {
            System.assert(
                exceptionThrown.getMessage().contains('guest record could not be found')
            );
        }
        Test.stopTest();
    }
}
