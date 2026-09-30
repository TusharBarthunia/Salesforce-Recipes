public class HTTPCalloutService {
    
    private static final String TEXT_CONFIG = '#CONFIG'; 
    
    HTTP_Callout_Configuration__mdt calloutMetadata {get; set;}
    public String endpointURL {get; set;}
    public static String requestBody {get; set;}
    public Blob requestBodyAsBlob {get; set;}
    public String contentType {get; set;}
    public Dom.Document requestBodyAsDocument {get; set;}
    public Map<String, String> headerParametersMap {get; set;}
    public Map<String, String> urlParametersMap {get; set;}
    public List<String> endPointParameters {get; set;}
    
    public String requestCertificate {get; set;}
    public List<String> requestBodyParameters {get; set;}
    public Integer requestTimeout {get; set;}
    public Boolean isCompressedRequest {get; set;}
    public String requestMethod {get; set;}   
    
    static final String TYPE_URL_PARAMETERS = 'URL_PARAMETERS';
    static final String TYPE_HEADER_PARAMETERS = 'HEADER_PARAMETERS';
    HTTPRequest request {get; set;}
    
    public HTTPCalloutService() {
        initialize();
    }
    
    public HTTPCalloutService(String customMetadataName) {
        try {
            System.debug('RRRR >>> '+requestBody);
            calloutMetadata = CustomMetadataTypeSelector.getHTTPCalloutConfiguration(customMetadataName);
        } catch (Exception e) {
            // throw new HTTPCalloutFrameworkException(HTTPCalloutFrameworkException.CUSTOM_METADATA_NOT_FOUND);
        }
        initialize();
    }
    
    public HTTPCalloutService(String customMetadataName, List<String> dynamicRequestBodyParameters) {
        try {
            //System.debug('HHH 8.1.1 PP '+Limits.getHeapSize());
            System.debug('Inside Constructor'+dynamicRequestBodyParameters);
            calloutMetadata = CustomMetadataTypeSelector.getHTTPCalloutConfiguration(customMetadataName);
            //System.debug('Inside Constructor '+calloutMetadata);
        } catch (Exception e) {
            // throw new HTTPCalloutFrameworkException(HTTPCalloutFrameworkException.CUSTOM_METADATA_NOT_FOUND);
        }
        //System.debug('HHH 8.1.1 '+Limits.getHeapSize());
        System.debug('Length 1 '+dynamicRequestBodyParameters.size());
        
        this.requestBodyParameters = dynamicRequestBodyParameters == null ? new List<string>() : dynamicRequestBodyParameters;
        System.debug('HHH 8.1.2 '+Limits.getHeapSize());
        System.debug('Length 3 '+dynamicRequestBodyParameters.size());
        System.debug('Length 4 '+requestBodyParameters.size());
        // if(calloutMetadata.Bind_body_parameters_dynamically__c && requestBodyParameters.isEmpty()) {
        //     throw new HTTPCalloutFrameworkException(HTTPCalloutFrameworkException.CUSTOM_METADATA_NOT_FOUND);
        // }
        initialize();
    }
    
    public HTTPCalloutService(String customMetadataName, List<String> dynamicRequestBodyParameters, List<String> endPointParameters) {
        try {
            calloutMetadata = CustomMetadataTypeSelector.getHTTPCalloutConfiguration(customMetadataName);
        } catch (Exception e) {
            // throw new HTTPCalloutFrameworkException(HTTPCalloutFrameworkException.CUSTOM_METADATA_NOT_FOUND);
        }
        
        this.requestBodyParameters = dynamicRequestBodyParameters == null ? new List<string>() : dynamicRequestBodyParameters;
        this.endPointParameters = endPointParameters == null ? new List<String>() : endPointParameters;
        // if(calloutMetadata.Bind_body_parameters_dynamically__c && requestBodyParameters.isEmpty()) {
        //     throw new HTTPCalloutFrameworkException(HTTPCalloutFrameworkException.CUSTOM_METADATA_NOT_FOUND);    
        // }
        
        initialize();
    }
    
    public HTTPRequest getRequest() {
        formHTTPRequest();
        return request;
    }
    
    public HTTPResponse sendRequest() {
        formHTTPRequest();
        Http http = new Http();
        System.debug('@@Request '+request);
        System.debug('@@@@TT'+request.getEndPoint());
        return http.send(request);
    }
    
    public HTTPResponse sendRequest(HTTPRequest request) {
        Http http = new Http();
        //System.assert(false,request.getEndpoint());
        return http.send(request);
    }
    
    private void initialize() {
        system.debug('Inside Initializee');
        urlParametersMap = new Map<String, String>();
        headerParametersMap = new Map<String, String>();
        if(calloutMetadata != null) {
            endpointURL = '';
            // if(String.isNotBlank(calloutMetadata.Named_Credential__c)) {
            //     endpointURL = 'callout:' + calloutMetadata.Named_Credential__c + '/';
            // }
            // if(String.isNotBlank(calloutMetadata.Endpoint_URL__c)) {
            //     endpointURL += calloutMetadata.Endpoint_URL__c;
            // }
            // if(calloutMetadata.Dynamic_Enpoint__c) {
            //     endpointURL = String.format(endpointURL, endPointParameters);
            //     //endpointURL = String.format(calloutMetadata.EndpointURL__c, endPointParameters);
            // }   
             system.debug('endpointURL>>'+endpointURL);
            // requestMethod = calloutMetadata.Method__c;
            // contentType = calloutMetadata.Content_Type__c;
            // if(calloutMetadata.Body__c != null){
            //     requestBody=calloutMetadata.Body__c;
            // }
            //system.debug('requestBodyParameters>>'+requestBodyParameters.size());
             //system.debug('requestBody>>'+requestBody);
            
            // if(String.isNotBlank(requestBody) && calloutMetadata.Bind_body_parameters_dynamically__c) {
            //     for(Integer i=0; i<requestBodyParameters.size(); i++) {
            //         //System.debug('HHH 8.1 '+Limits.getHeapSize());
            //         //System.debug('requestBodyPara>>'+requestBodyParameters[i]);
            //         //System.debug('iiii '+i);
            //         system.debug('131 =>' + i + '131 =>' + requestBodyParameters[i]);
            //         requestBody = requestBody.replace('#' + i + '#', requestBodyParameters[i]);
            //         //System.debug('HHH 8.2 '+Limits.getHeapSize());
            //     }
            // }
            System.debug('requestBody >>'+requestBody);
            
            //requestBody = replaceConfigurationParameters(requestBody);
            // requestTimeout = Integer.valueOf(calloutMetadata.Timeout__c);
            // isCompressedRequest = calloutMetadata.IsCompressed__c;
            // requestCertificate = calloutMetadata.CertificateName__c;
            // setUrlOrHeaderParameters(TYPE_URL_PARAMETERS, calloutMetadata.URLParameters__c);
            // String headerParameters = replaceConfigurationParameters(calloutMetadata.HeaderParameters__c);
            // setUrlOrHeaderParameters(TYPE_HEADER_PARAMETERS, headerParameters);
        }
    }
    
    // private String replaceConfigurationParameters(String str) {
    //     if(String.isNotBlank(str) && str.contains(TEXT_CONFIG)) {
    //         List<CLOS_General_Configuration__mdt> configurations = [
    //             SELECT DeveloperName, Value__c
    //             FROM CLOS_General_Configuration__mdt
    //             WHERE Use_in_HTTPCalloutConfiguration__c = true
    //         ];
            
            
    //         for(CLOS_General_Configuration__mdt config : configurations) {
    //             str = str.replace(TEXT_CONFIG + '[' + config.DeveloperName + ']', config.Value__c);
                
    //         }
            
            
    //     }
        
    //     return str;
    // }
    
    private void setUrlOrHeaderParameters(String parameterType, String parameterInfo) {
        if(String.isNotBlank(parameterInfo)) {
            Map<String, String> parametersMap = new Map<String, String>();
            List<String> parameters = parameterInfo.split('\n');
            for(String urlParam : parameters) {
                
                List<String> keyValuePair = urlParam.trim().split(':');
                if(!keyValuePair.isEmpty()) {
                    if(keyValuePair.size() == 2) {
                        if(String.isNotBlank(keyValuePair[0]) && String.isNotBlank(keyValuePair[1])) {
                            parametersMap.put(keyValuePair[0], keyValuePair[1]);
                        }
                    } else if(
                        (keyValuePair.size() == 1) &&
                        (parameterType != TYPE_HEADER_PARAMETERS)
                    ) {
                        if(String.isNotBlank(keyValuePair[0])) {
                            parametersMap.put(keyValuePair[0], '');
                        }
                    }
                }
            }
            if(parameterType == TYPE_URL_PARAMETERS) {
                urlParametersMap.putAll(parametersMap);
            } else if(parameterType == TYPE_HEADER_PARAMETERS) {
                headerParametersMap.putAll(parametersMap);
            }
        }
    }
    
    private void appendURLParameters() {
        Set<String> urlParamKeys = urlParametersMap.keySet();
        
        if(!urlParamKeys.isEmpty()) {
            
            endpointURL += '?';
            for(String urlParamKey : urlParamKeys) {
                endpointURL += urlParamKey + '=' + urlParametersMap.get(urlParamKey) + '&';
            }
            endpointURL = endpointURL.substringBeforeLast('&');
            
        }
    }
    
    private void addHeaderParameters() {
        for(String key : headerParametersMap.keySet()) {
            request.setHeader(key, headerParametersMap.get(key));
        }
        //  System.assert(false,'{!$Credential.AuthorizationHeaderValue}');
        request.setHeader('Authorization', 'Basic {!$Credential.AuthorizationHeaderValue}');
        
    }
    
    public void formHTTPRequest() {
        request = new HTTPRequest();
        addHeaderParameters();
        system.debug('requestBody>>'+requestBody);
        // System.assert(false, request.getHeaders());
        if(String.isNotBlank(endpointURL)) {
            //endpointURL = endpointURL.substringBefore('?');
            appendURLParameters();
            request.setEndpoint(endpointURL);
        }
        //System.assert(false, request.getEndpoint());
        
        if(String.isNotBlank(requestMethod)) {
            request.setMethod(requestMethod);
        }
        if(String.isNotBlank(requestBody)) {
            request.setBody(requestBody);
        } else if((requestBodyAsBlob != null) ) {
            request.setBodyAsBlob(requestBodyAsBlob);
        } else if((requestBodyAsDocument != null) && String.isNotBlank(requestBodyAsDocument.toXmlString())) {
            request.setBodyDocument(requestBodyAsDocument);
        }
        if(requestTimeout!=null) {
            request.setTimeout(requestTimeout);
        }
        System.debug('Setting Certificate');
        //if(!Test.isRunningTest()){
            System.debug('Inside Test Runn');
            if(String.isNotBlank(requestCertificate)) {
                System.debug('Inside Certificate '+requestCertificate);
            	request.setClientCertificateName(requestCertificate);
              	System.debug('Outside Certificate');
        	}
        System.debug('Certificate set');
            
        //}
        
        if(isCompressedRequest!=null) {
            request.setCompressed(isCompressedRequest);
        }
        
        if(String.isBlank(contentType)) {
            
            request.setHeader('Content-Type', 'application/json');
        } 
        else {
            
            request.setHeader('Content-Type', contentType);
        }
        
    }
    
    public void setHeaderParameter(String key, String value) {
        if(String.isNotBlank(key) && String.isNotBlank(value)) {
            headerParametersMap.put(key, value);
        }
        
    }
    
    public void removeHeaderParameter(String key) {
        headerParametersMap.remove(key);
    } 
    
    public void setURLParameter(String key, String value) {
        if(String.isNotBlank(key) && String.isNotBlank(value)) {
            urlParametersMap.put(key, value);
        } else if(String.isNotBlank(key)) {
            urlParametersMap.put(key, value);
        }
    }
    
    public void removeURLParameter(String key) {
        urlParametersMap.remove(key);
    }
    
    // public static void createIntegrationLogs(Integer statusCode ,String response, String request, String integrationType,String applicationId,String applicantId, String logType, String errorTrace){
    //     CLOS_Integration_Logs__c intLogs = new CLOS_Integration_Logs__c();
    //     intLogs.JSON_Response__c = response;
    //     intLogs.JSON_Request__c = request;
    //     intLogs.Status_Code__c = statusCode;
    //     intLogs.Type__c = integrationType;
    //     if(!String.isEmpty(applicantId)){
    //         intLogs.Loan_Applicant__c=applicantId;
    //     }
    //     if(!String.isEmpty(applicationId)){
    //         intLogs.Loan_Application__c=applicationId;
    //     }
    //     if(!String.isEmpty(logType)){
    //         intLogs.Log_Type__c=logType;
    //     }
    //     if(!String.isEmpty(errorTrace)){
    //         intLogs.Error_Stack_Trace__c = errorTrace;
    //     }
       
    //     //intLogs.Loan_Application__c=applicationId;
    //    // system.debug('integration Log'+intLogs);
    //     insert intLogs;
    //    // system.debug('inserttttt>>>>'+intLogs);
    //    // System.debug('name: ' + intLogs.Name + ' ' + intLogs.Id + ' request:' + intLogs.JSON_Request__c + ' response:' + intLogs.JSON_Response__c);
    // }
    
    // public static void createIntegrationLogList(List<Map<String, String>> logWrapList){
    //     List<CLOS_Integration_Logs__c> logList = new List<CLOS_Integration_Logs__c>();
    //     for(Map<String, String> obj : logWrapList){
    //         CLOS_Integration_Logs__c intLogs = new CLOS_Integration_Logs__c();
    //         intLogs.JSON_Response__c = obj.get('responseBody');
    //         intLogs.JSON_Request__c = obj.get('requestBody');
    //         intLogs.Status_Code__c = Integer.ValueOf(obj.get('statusCode'));
    //         intLogs.Type__c = obj.get('apiType');
    //         if(!String.isEmpty(obj.get('applicantId'))){
    //             intLogs.Loan_Applicant__c=obj.get('applicantId');
    //         }
    //         if(!String.isEmpty(obj.get('applicationId'))){
    //             intLogs.Loan_Application__c=obj.get('applicationId');
    //         }
    //         if(!String.isEmpty(obj.get('logType'))){
    //             intLogs.Log_Type__c=obj.get('logType');
    //         }
    //         if(!String.isEmpty(obj.get('exceptionMessage'))){
    //             intLogs.Error_Stack_Trace__c = obj.get('exceptionMessage');
    //         }
    //         logList.add(intLogs);
    //     }
       
       
    //     //intLogs.Loan_Application__c=applicationId;
    //    // system.debug('integration Log'+intLogs);
    //     if(logList.size()>0){
    //         insert logList;
    //     }
        
    //    // system.debug('inserttttt>>>>'+intLogs);
    //    // System.debug('name: ' + intLogs.Name + ' ' + intLogs.Id + ' request:' + intLogs.JSON_Request__c + ' response:' + intLogs.JSON_Response__c);
    // }
    
    // public static void createIntegrationLogWithFilesList(List<Map<String, String>> logWrapList){
    //     List<CLOS_Integration_Logs__c> logList = new List<CLOS_Integration_Logs__c>();
    //     Map<String, String> docInfoIdWithRequestBodyMap = new Map<String, String>();
    //     for(Map<String, String> obj : logWrapList){
    //         docInfoIdWithRequestBodyMap.put(obj.get('docInfoId'), obj.get('requestBody'));
    //         CLOS_Integration_Logs__c intLogs = new CLOS_Integration_Logs__c();
    //         intLogs.JSON_Response__c = obj.get('responseBody');
    //         if(!String.isEmpty(obj.get('statusCode'))){
    //             intLogs.Status_Code__c = Integer.ValueOf(obj.get('statusCode'));
    //         }
    //         intLogs.Type__c = obj.get('apiType');
    //         if(!String.isEmpty(obj.get('applicantId'))){
    //             intLogs.Loan_Applicant__c=obj.get('applicantId');
    //         }
    //         if(!String.isEmpty(obj.get('applicationId'))){
    //             intLogs.Loan_Application__c=obj.get('applicationId');
    //         }
    //         if(!String.isEmpty(obj.get('logType'))){
    //             intLogs.Log_Type__c=obj.get('logType');
    //         }
    //         if(!String.isEmpty(obj.get('exceptionMessage'))){
    //             intLogs.Error_Stack_Trace__c = obj.get('exceptionMessage');
    //         }
    //         if(!String.isEmpty(obj.get('docInfoId'))){
    //             intLogs.Document_Info_Id__c = obj.get('docInfoId');
    //         }
    //         logList.add(intLogs);
    //     }

    //     if(logList.size()>0){
    //         insert logList;
    //         Map<String, String> docInfoIdWithLogMap = new Map<String, String>();
    //         for(CLOS_Integration_Logs__c log : [Select Id, Document_Info_Id__c from CLOS_Integration_Logs__c where Id in :logList]){
    //             docInfoIdWithLogMap.put(log.Document_Info_Id__c, log.Id);
    //         }
            
    //         List<ContentVersion> contentVersionsList = new List<ContentVersion>();
    //         for(String docInfoId : docInfoIdWithRequestBodyMap.keySet()){
    //             ContentVersion cv1 = new ContentVersion();
    //             String theName = 'DMS Request.txt';
    //             cv1.Title = theName;
    //             cv1.Document_Info_Id__c = docInfoId;
    //             cv1.PathOnClient = cv1.Title; // The files name, extension is very important here which will help the file in preview.
    //             cv1.VersionData = Blob.valueof(docInfoIdWithRequestBodyMap.get(docInfoId)); // converting your binary string to Blog//wrap.data
    //             contentVersionsList.add(cv1);
    //         }
            
    //         if(contentVersionsList.size()>0){
    //             insert contentVersionsList;
    //         }
            
    //         List<ContentDocumentLink> contentDocLinkList = new List<ContentDocumentLink>();
    //         for(ContentVersion conVer : [SELECT Id, ContentDocumentId, Document_Info_Id__c, ContentDocument.FileType, VersionData FROM ContentVersion WHERE Id in :contentVersionsList]){
    //             ContentDocumentLink conDL = new ContentDocumentLink();
    //             conDL.ContentDocumentId = conVer.ContentDocumentId;
    //             conDl.LinkedEntityId = docInfoIdWithLogMap.get(conVer.Document_Info_Id__c);
    //             conDL.ShareType = 'V';
    //             conDl.Visibility = 'AllUsers';
    //             contentDocLinkList.add(conDL);
    //             //insert conDl;
    //         }
            
    //         if(contentDocLinkList.size()>0){
    //             insert contentDocLinkList;
    //         }
    //     }
    // }
}