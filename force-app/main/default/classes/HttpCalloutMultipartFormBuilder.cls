public with sharing class HttpCalloutMultipartFormBuilder {
    private String boundary{get; set;}
    public String fileParam{get; set;}
    public Map<String, String> keyValuesMap{get; set;}

    public HttpCalloutMultipartFormBuilder() {
        boundary =  String.valueOf(DateTime.now().getTime());
        fileParam = 'file';
        keyValuesMap = new Map<String, String>();
    }

    public String getMultiPartFormContentType () {
        return 'multipart/form-data; boundary="' + boundary + '"';
    }

    public Blob createMultiPartFormDataBody (Map<String, Blob> mapFiles) {
        Blob blobBody = Blob.valueOf('');
        String content = '';
        String mergeBlobsAsHex;
                  
        for ( String k : keyValuesMap.keySet() ) {
            content += '--' + Boundary + '\r\n';
            content += 'Content-Disposition: form-data; name="' + k + '"\r\n';
            content += '\r\n';
            content += keyValuesMap.get(k) + '\r\n';
        }
        
         mergeBlobsAsHex = EncodingUtil.convertToHex(blobBody) 
                                    + EncodingUtil.convertToHex(Blob.valueOf(content));
         blobBody = EncodingUtil.convertFromHex(mergeBlobsAsHex);
        
        if (mapFiles != null) {            
            for (String fileName : mapFiles.keySet()) {
                content = '--' + boundary + '\r\n';
                content += 'Content-Disposition: form-data; name="' + fileParam + '"; filename="' + fileName + '"\r\n';
                content += 'Content-Type: application/pdf\r\n';
                content += '\r\n';
        
                mergeBlobsAsHex = EncodingUtil.convertToHex(blobBody) 
                                    + EncodingUtil.convertToHex(Blob.valueOf(content)) 
                                    + EncodingUtil.convertToHex(mapFiles.get(fileName));
                blobBody = EncodingUtil.convertFromHex(mergeBlobsAsHex);
            }
        }
        content = '\r\n';
        content += '--' + boundary + '--\r\n';
        
        mergeBlobsAsHex = EncodingUtil.convertToHex(blobBody) 
                            + EncodingUtil.convertToHex(Blob.valueOf(content));
        blobBody = EncodingUtil.convertFromHex(mergeBlobsAsHex);
        
        return blobBody;
    } 
}