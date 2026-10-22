public with sharing class PaloniaResortMapController {
    public class ResortMapData {
        @AuraEnabled
        public List<String> interests { get; set; }

        @AuraEnabled
        public List<Experience__c> experiences { get; set; }

        public ResortMapData(List<String> interests, List<Experience__c> experiences) {
            this.interests = interests;
            this.experiences = experiences;
        }
    }

    @AuraEnabled(cacheable=true)
    public static ResortMapData getMapData(Id guestId) {
        List<Guest__c> guests = [
            SELECT Interest_1__c, Interest_2__c, Interest_3__c
            FROM Guest__c
            WHERE Id = :guestId
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];

        if (guests.isEmpty()) {
            AuraHandledException exceptionThrown = new AuraHandledException(
                'The guest record could not be found or is not accessible.'
            );
            exceptionThrown.setMessage(
                'The guest record could not be found or is not accessible.'
            );
            throw exceptionThrown;
        }

        Guest__c guest = guests[0];
        List<String> interests = new List<String>();
        if (String.isNotBlank(guest.Interest_1__c)) {
            interests.add(guest.Interest_1__c);
        }
        if (String.isNotBlank(guest.Interest_2__c)) {
            interests.add(guest.Interest_2__c);
        }
        if (String.isNotBlank(guest.Interest_3__c)) {
            interests.add(guest.Interest_3__c);
        }

        List<Experience__c> experiences = [
            SELECT Id, Name, Type__c, Price__c, Duration_Hours__c,
                Activity_Level__c, Location__c, Map_X__c, Map_Y__c
            FROM Experience__c
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];

        return new ResortMapData(interests, experiences);
    }
}
