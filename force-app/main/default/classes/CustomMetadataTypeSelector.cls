public with sharing class CustomMetadataTypeSelector {
    public static HTTP_Callout_Configuration__mdt getHTTPCalloutConfiguration(String customMetadataName) {
        // return [
        //     SELECT Method__c, Dynamic_Enpoint__c,URLParameters__c, HeaderParameters__c, Endpoint_URL__c, Named_Credential__c, Content_Type__c,
        //         Body__c, Timeout__c, CertificateName__c, IsCompressed__c, Bind_body_parameters_dynamically__c
        //     FROM CLOS_HTTP_Callout_Configuration__mdt
        //     WHERE DeveloperName =:customMetadataName
        // ];

        return [
            SELECT Endpoint_URL__c
            FROM HTTP_Callout_Configuration__mdt
            WHERE DeveloperName =:customMetadataName
        ];
    }
    
    @AuraEnabled(cacheable=true)
    public static String getGeneralConfigByName(String developerName) {
    //   List<CLOS_General_Configuration__mdt> results = [
    //         SELECT Value__c
    //         FROM CLOS_General_Configuration__mdt
    //         WHERE DeveloperName =:developerName
    //     ];
        // return results.size() > 0 ? results[0].Value__c : null;
        return null;
     }
    
    // public static List<CLOS_General_Configuration__mdt> getGeneralConfigByNameSet(Set<String> developerName) {
    //   List<CLOS_General_Configuration__mdt> results = [
    //         SELECT Value__c, DeveloperName
    //         FROM CLOS_General_Configuration__mdt
    //         WHERE DeveloperName In:developerName
    //     ];
    //     return results;
    //  }
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /**public static StateCodeConfiguration__mdt getStateCodeByLabel(String label) {
      StateCodeConfiguration__mdt result = [
            SELECT StateCode__c FROM StateCodeConfiguration__mdt where Label =:label
        ];
        return result;
     }**/
 
}
