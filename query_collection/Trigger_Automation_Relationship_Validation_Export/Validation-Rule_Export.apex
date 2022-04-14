/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* Anonymous Apex to extract all ValidationRules of a certain objectand mail it to a receipient 
*
* Executing Steps:
* * [Step 1:] replace "objectToBeQueried" with the name of the object you'd like to query
* * [Step 2:] replace "emailRecipients" variable with the correct receipient
*
* NOTE: Procedure will work with only for max. of 100 ValidationRules per object
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Heiko Krämer   <sfhcks@myforce.net>
* @created        2022-04-14
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/

// Config variables
String objectToBeQueried = 'Account'; // <-- PLACE OBJECT NAME HERE
String emailRecipients   = 'heiko.kraemer@dematic.com'; // <-- PLACE RECIPIENT(S) HERE

String validationRuleName;
String validationRuleDescription;
String validationRuleFormula;
String vaRuNameAndDesc = '';

// Retreive active ValidationRules from Org
List<Id> listOfValidationRuleIds = new List<Id>(); 

// Tooling API Call to receive IDs for all active ValidationRules
String toolingSOQL = '/services/data/v53.0/tooling/query/?q=Select+Id+From+ValidationRule+Where+Active+=+true+AND+EntityDefinitionId+=+' + '\'' + objectToBeQueried +'\'';
String baseURL     = URL.getSalesforceBaseUrl().toExternalForm();
String endpoint    = baseURL + toolingSOQL;

Http NewReq        = new Http();
HttpRequest hreq   = new HttpRequest();

hreq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
hreq.setTimeout(60000);
hreq.setEndpoint(endPoint);
hreq.setMethod('GET');
HttpResponse hresp = NewReq.send(hreq);

String body = hresp.getBody();
system.debug('ResponseBody' + body);


// Parse JSON response for IDs >> store IDs in List.
JSONParser parser = JSON.createParser(hresp.getBody());
while (parser.nextToken() != null) {
 if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
     (parser.getText() == 'Id')) {
         parser.nextToken();
         listOfValidationRuleIds.add(parser.getIdValue());
     }
}

// Loop through ValidationRule IDs and query all Metadata info via Tooling API
for (Id valId : listOfValidationRuleIds) {
 String valIdString = '\'' + valId + '\'';
 String toolingSOQL = '/services/data/v53.0/tooling/query/?q=Select+FullName+,+Metadata+From+ValidationRule+Where+Id+=+';
 String baseURL     = URL.getSalesforceBaseUrl().toExternalForm();
 String endpoint    = baseURL + toolingSOQL + valIdString;
 
 Http NewReq        = new Http();
 HttpRequest hreq   = new HttpRequest();
 
 hreq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
 hreq.setTimeout(60000);
 hreq.setEndpoint(endPoint);
 hreq.setMethod('GET');
 HttpResponse hresp = NewReq.send(hreq);
 
 String body = hresp.getBody();
 system.debug('ResponseBody' + body);
 system.debug('Length' + body.length());

 // Parse JSON response for ValidationRule name
JSONParser parser = JSON.createParser(hresp.getBody());
while (parser.nextToken() != null) {
 if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
     (parser.getText() == 'FullName')) {
         parser.nextToken();
         validationRuleName = parser.getText();
     }
}

// Extract description from metadata
validationRuleDescription = body.substringBetween('\"' + 'description' + '\"' + ':' + '\"','\"');
validationRuleFormula     = body.substringBetween('\"' + 'errorConditionFormula' + '\"' + ':' + '\"', '\"' + ',' + '\"' + 'errorDisplayField');

System.debug('Validation Rule FullName: ' + validationRuleName);
System.debug('Validation Rule Metadata: ' + validationRuleDescription);

vaRuNameAndDesc = vaRuNameAndDesc + 'Name: ' + validationRuleName  + '\n' 
                                  + 'Description: ' + validationRuleDescription + '\n' 
                                  + 'Formular: ' + validationRuleFormula + '\n' + '\n';
}
 
// Send ValidationRules to email receipient
Messaging.SingleEmailMessage message    = new Messaging.SingleEmailMessage();
message.toAddresses                     = new String[] { emailRecipients };
message.optOutPolicy                    = 'FILTER';
message.subject                         = objectToBeQueried + ' Validation Rules';
message.plainTextBody                   = vaRuNameAndDesc;
Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
Messaging.SendEmailResult[] results     = Messaging.sendEmail(messages);
 
if (results[0].success)
{
    System.debug('The email was sent successfully.');
} else
{
   System.debug('The email failed to send: ' + results[0].errors[0].message);
} 