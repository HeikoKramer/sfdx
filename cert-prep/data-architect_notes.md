# Salesforce Data Architect Notes
Notes I'm taking during my preparation for the [Salesforce Data Architect](https://trailhead.salesforce.com/en/credentials/dataarchitect) exam. <br> 
<br>
Resources used for my prep-works: 
* [Exam Guide](https://trailhead.salesforce.com/help?article=Salesforce-Certified-Data-Architect-Exam-Guide)
* [Trailmix](https://trailhead.salesforce.com/en/users/strailhead/trailmixes/architect-data-architecture-and-management)
* [DecodeSFCertifications YouTube Channel](https://youtu.be/Sw-iqjxdI7w)
* [Book: Salesforce Data Architecture and Management](https://www.packtpub.com/product/salesforce-data-architecture-and-management/9781801073240)
* [FocusOnForce Data Architect Certification Practice Exams](https://focusonforce.com/salesforce-data-architecture-and-management-designer-certification-practice-exams/)

## Data Modeling
### [Types of Salesforce Objects & Storage](https://youtu.be/Sw-iqjxdI7w?t=767)
It is important to understand 
* when you create a record, how much space it takes in the system
* what are the various ways of storing the data 
* what is the impact of this

#### [Data Storage](https://youtu.be/Sw-iqjxdI7w?t=835)
Salesforce Help: [Data and File Storage Allocations](https://help.salesforce.com/s/articleView?id=sf.overview_storage.htm&type=5) <br>
Storage is based on the **Salesforce edition** + the **number of licenses** purchased. <br>
Storage is divided into two categories – **file storage** and **data storage**. <br>
**File storage** includes
* files in attachments
* Files home
* Salesforce CRM Content
* Chatter files (including user photos)
* the Documents tab
* the custom File field on Knowledge articles
* Site.com assets

**Data storage** includes all standard and custom object **records**. <br>
The most Salesforce editions come with **10 GB of data storage** for their production environment. <br>
Exceptions are the **Developer (5MB)** and the **Personal (20MB)** editions. <br>
Additional license data storage allocation is not available for those two editions. <br>
The other editions get storage allocated per user license as following: <br>

**+ 20MB per License:**
* Contact Manager
* Group
* Professional
* Enterprise

<br>

**+ 120MB per License:**\*
* Performance
* Unlimited

\* *20 MB for Lightning Platform Starter user licenses* <br>

#### [Big Objects](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object.htm)
Description from developer.salesforce.com: <br>
*A big object stores and manages massive amounts of data on the Salesforce platform. <br>
You can archive data from other objects or bring massive datasets from outside systems into a big object to get a full view of your customers. <br>
Clients and external systems use a standard set of APIs to access big object data. <br>
A big object provides consistent performance, whether you have 1 million records, 100 million, or even 1 billion. <br>
This scale gives a big object its power and defines its features.*
<br>
Edition availability: <br>
* Enterprise
* Performance
* Unlimited
* Developer

Initial record capacity: **up to 1 million records** <br>
Additional record capacity and async SOQL query is available as an **add-on license**. <br>
<br>
**Types of Big Objects:** <br>
* **Standard Big Object**
  * defined by Salesforce
  * included in Salesforce products
    * *FieldHistoryArchive* is a standard big object
  * cannot be customized

<br>

* **Custom Big Object**
  * created to store information unique to your org
  * extends the platform functionality 
  * extends your Salesforce data model
  * used for auditing, tracking and to archive historical data

<br>

**Differences Between Big Objects and sObjects:**
|Big Objects|sObjects|
|:----------|:-------|
|Horizontally scalable distributed database|Relational database|
|Non-transactional database|Transactional database|
|Billions of records|Millions of records|

<br>

**Behaviors to ensure consitant and scalable experience:**
* Big Objects support only object and field permissions
  * no regular or standard sharing rules
* No triggers, flows, processes, or mobile app support
* When inserting an identical big object record, only a single record is created

<br>

**Considerations:**
* Big Objects support custom Lightning and Visualforce components
  * rather than standard UI elements home pages, detail pages, list views, …
* **100 big objects per org**
* limits for big object fields depend on the org’s edition (same as custom object)
* No Salesforce Connect external objects access in another org
* Big Objects don't support encryption
  * encrypted data from a standard / custom object is stored as clear text on B.O.

<br>

**Design with Resiliency in Mind** <br>
When working with big data and writing batches of records using APIs or Apex, you can experience a partial batch failure while some records are written and others aren’t. Because the database is highly responsive and consistent at scale, this type of behavior is expected. In these cases, simply retry until all records are written. <br>
<br>
**Big Object principles:**
* have a retry mechanism in place
  * retry the batch until you get a successful result from the API or Apex method
  * retry the entire batch
* Big Objects don’t support transactions
  * use asynchronous Apex
    *  the Queueable interface isolates DML operations on different sObject types
    *  the mixed DML error gets prevented
* use asynchronous Apex to write to a Big Object (must retry)
  * that way you are better equipped to handle database lifecycle events

<br>

**Big Object index notes:**
* a B.O. **requires an index** to be created
  * the index must consist of a **minimum of 1** and a **maximum of 5** fields
* all index fields must be marked **required**
* the **maximum combined length** of the index is **100 characters**
* index **can not be edited** once B.O. has been saved and deployed
* all index fields **require to contain value**


**Additional ressources:**
* [Define and Deploy Custom Big Objects](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object_define.htm)
* [Populate a Custom Big Object](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object_populate.htm) 
  * via **CSV** file or **Apex** code
* [Delete Data in a Custom Big Object](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object_delete.htm) 
  * via **Apex** or **SOAP**
* [Big Objects Queueable Example](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object_example_queueable.htm)
* [SOQL with Big Objects](https://developer.salesforce.com/docs/atlas.en-us.bigobjects.meta/bigobjects/big_object_querying.htm)
  * you can use `IN` only one time
  * you can use the range operations `<`, `>`, `<=`, or `>=` only on the last field
  * the `!=`, `LIKE`, `NOT IN`, `EXCLUDES`, and `INCLUDES` operators aren’t valid
  * aggregate functions aren’t valid
  * don’t use the Id field
    * including Id in a query returns only results that have an empty ID
  * query filter must list index fields in correct order
    * if F1, F2 and F3 are the index fields:
      * F1 – valid
      * F1, F2 – valid
      * F1, F2, F3 – valid
      * F1, F3 – invalid
      * F2, F3 – invalid

## Master Data Management (MDM)
### Monitoring Bulk Data Loads
The **[Bulk Data Load Jobs](https://help.salesforce.com/s/articleView?id=sf.monitoring_async_api_jobs.htm&type=5)** page in **setup** can be used to track in-progress/completed jobs. <br>
It can be accessed to view information such as
* type of operation
* number of records processed
* user who submitted the job

The **[Bulk API 2.0 Event Type](https://developer.salesforce.com/docs/atlas.en-us.234.0.object_reference.meta/object_reference/sforce_api_objects_eventlogfile_bulkapi2.htm)** in **Event Monitoring** can also be used to monitor the same information. <br>
An event log can be downloaded to visualize the information. <br>

### [Event Monitoring](https://trailhead.salesforce.com/en/content/learn/modules/event_monitoring/event_monitoring_intro)
Salesforce **Event Monitoring** is a product which requires additional licensing. <br>
It is sold as a bundle with other tools under the name [Salesforce Shield](https://developer.salesforce.com/docs/atlas.en-us.securityImplGuide.meta/securityImplGuide/salesforce_shield.htm). <br>
Event Monitoring provides tracking for around 50 types of events, including:

* Logins
* Logouts
* URI (web clicks in Salesforce Classic)
* Lightning (web clicks, performance, and errors in Lightning Experience and the Salesforce mobile app)
* Visualforce page loads
* Application programming interface (API) calls
* Apex executions
* Report exports

Event Logs can be queried via 
* the **Event Log File Browser** (connected Heroku App)
* SOQL (EventLogFile object)
* via the API ([Developer Documentation](https://developer.salesforce.com/docs/atlas.en-us.224.0.api.meta/api/sforce_api_objects_eventlogfile.htm))

### [Metadata Types](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_types_list.htm)
Metadata API enables you to access some entities and feature settings that you can customize in the user interface. <br>
Metadata type 
* names are case-sensitive 
  * specifying a type name with an invalid case results in a deployment error
* don’t always correspond directly to their related data types
  * the information might be accessible but not organized as expected

<br>

Examples for **Metadata Types**:
* [ApexClass](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_classes.htm)
  * Represents an Apex class. 
  * An Apex class is a template or blueprint from which Apex objects are created.
  * Classes consist of other classes, user-defined methods, variables, exception types, and static initialization code.
* [ApexTrigger](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_triggers.htm)
  * Represents an Apex trigger.
  * A trigger is Apex code that executes before or after specific data manipulation language (DML) events occur
    * such as before object records are inserted into the database, or after records have been deleted
* [Certificate](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_certificate.htm)
  * Represents a certificate used for digital signatures which verify that requests are coming from your org. 
  * Certificates are used for 
    * authenticated single sign-on with an external website
    * when using your org as an identity provider
  * This type extends the [MetadataWithContent](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_metadatawithcontent.htm) metadata type and inherits its content and fullName fields.
* [CustomLabel](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_customlabels.htm)
  * The CustomLabels metadata type allows you to create custom labels that can be localized for use in different languages, countries, and currencies.
* [CustomObject](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/customobject.htm)
  * Represents a custom object that stores data unique to your org or an external object that maps to data stored outside your org.
* [Flow](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_visual_workflow.htm)
  * Represents the metadata associated with a flow. 
  * With Flow, you can create an application that navigates users through a series of screens to query and update records in the database.
  * You can also execute logic and provide branching capability based on user input to build dynamic applications.
* [GlobalPicklistValue](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_globalpicklistvalue.htm)
  * Represents the definition of a value used in a global picklist. 
  * Custom picklist fields can inherit the picklist value set from a global picklist. 
  * This type extends the [Metadata](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/metadata.htm) metadata type and inherits its fullName field.
* [Layout](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/metadata.htm)
  * Represents the metadata associated with a page layout.
* [Metadata](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/metadata.htm)
  * This is the base class for all metadata types. 
  * You cannot edit this object. 
  * A component is an instance of a metadata type.

The Salesforce CLI uses the Metadata API to retrieve and deploy metadata type components. <br>

### [Custom Metadata Types](https://help.salesforce.com/s/articleView?id=sf.custommetadatatypes_overview.htm&type=5)
Intro from the [Get Started with Custom Metadata Types](https://trailhead.salesforce.com/en/content/learn/modules/custom_metadata_types_dec/cmt_overview?trail_id=configure-your-app-with-custom-metadata-types) Trailhead module: <br>
*A custom metadata type is an object that is used to define the structure for application metadata. The fields of custom metadata types, and the values in the fields, consist only of metadata. The records of custom metadata types are also metadata, not data. Using metadata is pretty handy because it can be imported into Salesforce, modified in the interface, and manipulated using the Metadata API. Instead of storing hard-coded data, custom metadata types let you configure apps by building reusable functionality that determines the behavior based on metadata. And you can do much of this customization work using declarative tools.* <br>
<br>
*When you deploy apps with custom metadata types, all of the records and fields are included in the package installation, so no additional steps are needed. You can deploy custom metadata types from a sandbox with change sets or packaged in managed packages.* <br>
<br>
*Unlike custom metadata types, when you deploy apps with custom objects and custom settings, the metadata for those objects (the header) gets deployed, but the records (definitions) are left behind. Whether you’re manually loading records or inserting records using an Apex script, adding records can be a time-consuming process.* <br> 
<br>
*Custom metadata types are customizable, deployable, packageable, and upgradeable application metadata. In many cases, custom metadata types have an advantage over custom settings and custom objects. They can make your application lifecycle management and compliance easier, faster, and more robust.* <br>
<br>

**Overall:**
* CMT can be deployed using
  * managed packages 
  * unmanaged packages
  * managed package extensions
* mappings can be used to create associations between objects
* Metadata API is used to create, edit, delete custom metadata records
* Apex can create and edit custom metadata records, but **not delete**
* CMT values can be used in formula fields

#### [What are Custom Metadata Types?](https://help.salesforce.com/s/articleView?id=custommetadatatypes_about.htm&type=5&language=en_US)
Custom metadata is customizable, deployable, packageable, and upgradeable application metadata. <br>
First, you create a Custom Metadata Type, which defines the form of the application metadata. <br>
Then you build reusable functionality that determines the behavior based on metadata of that type. <br>
<br>
Custom Metadata Types (CMT) can be created declaratively. <br>
Who install a package with a CMT can add own records to the metadata type. <br>
Custom Metadata is read by Salesforce and used to produce customized application behavior. <br>
Typical use cases: 

* Mappings
  * Create associations between different objects
    * such as assignments of cities, states or provinces to particular regions in a country
* Business rules
  * Combine configuration records with custom functionality
    * Use CMTs along with Apex to route payments to the correct endpoint
* Master data 
  * Create for example a definition of custom charges, like duties and VAT rates
* White lists
  * Manage lists, such as approved donors and pre-approved vendors
* Secrets
  * Store information, like API keys, in your protected custom metadata types

Custom metadata rows resemble custom object rows in structure. <br>
You create, edit, and delete custom metadata rows in Metadata API or in Setup. <br>
Because the **records are metadata**, you can migrate them using packages or Metadata API tools. <br>
<br>
Custom metadata types support most standard field types, including:

* Metadata Relationships
* Checkbox
* Date and Date/Time
* Email and Phone
* Number
* Percent
* Picklist
* Text and Text Area
* URL

<br>
Custom metadata types can be used directly from:

* Apex
* Flows
* Formula fields
* Process Builder
* Validation rules

#### [Custom Metadata in Formulas, Default Values, and Validation Rules](https://trailhead.salesforce.com/content/learn/modules/custom_metadata_types_dec/cmt_formulas)
*Custom metadata types can save you a lot of time, and if you pair them with other features, you can streamline your workflow processes even more. For example, formulas save time and work by automating calculations. Combined with custom metadata types, formulas eliminate the need for hardcoded values that you need to individually update.* <br>
<br>
CMD as pick list **default values**: <br>
You can use a **custom metadata record field** as the **default value of a picklist**. <br>
Put the appropriate **formula** into the **default value** input in the **picklist field settings:** <br>

![default-value](/cert-prep/images/cmt_default-value_01.png)

**NOTE:** Custom Metadata won't show up under **Select Field Type** in the **Formula Editor**. <br>
To refer to your CMD values, use the following syntax: <br>
`$CustomMetadata.CustomMetadataTypeAPIName.RecordAPIName.FieldAPIName` <br>
Use the correct suffixes. 
* For the custom metadata type, use `__mdt` 
* For fields, use `__c`
* Records do not require a suffix

CMD values in **validation rules**: <br> 
The **formula editor** of validation rules offers `$CustomMetadata` as a standard field type: <br> 
![validation-rule](/cert-prep/images/cmt_validation-rule_01.png)

So we can refer to metadata values in conditions like this: <br>

```
IF( 
 (ISPICKVAL( Support_Tier__c , "Silver") 
      && 
   ( Total_Spending__c <  
   $CustomMetadata.Support_Tier__mdt.Silver.Minimum_Spending__c 
   )
 )
```

We can refer to those values in multiple rules – and update them centrally if they change! <br> 

CMD values in **formulas**: <br>
CMD values are also accessible by default in the **formula field editor**. <br>
Their values can be used to display certain things, to perform calculations .. like any other value you'd use in a formula. <br>
Here the example formula from the Trailhead module: <br>

```
IF ( Total_Spending__c <  $CustomMetadata.Support_Tier__mdt.Bronze.Minimum_Spending__c,
     $CustomMetadata.Support_Tier__mdt.Bronze.Minimum_Spending__c - Total_Spending__c,
     IF ( Total_Spending__c <  $CustomMetadata.Support_Tier__mdt.Silver.Minimum_Spending__c,
          $CustomMetadata.Support_Tier__mdt.Silver.Minimum_Spending__c - Total_Spending__c,
          IF ( Total_Spending__c <  $CustomMetadata.Support_Tier__mdt.Gold.Minimum_Spending__c,
               $CustomMetadata.Support_Tier__mdt.Gold.Minimum_Spending__c - Total_Spending__c,
               0
          )
     )
)
```

Here our calculated value:

![formula](/cert-prep/images/cmt_formula_01.png)

Same major benefit: We could change the parameters for the calculation now centrally in the CMD record. <br>
That way we would update all the formulas using that parameter at once. <br>

**NOTE:** If you decide to package your custom metadata type, subscribers to the package can customize details, like price, while you still maintain the app logic! <br>

#### [Metadata Relationship Fields](https://trailhead.salesforce.com/en/content/learn/modules/custom_metadata_types_adv/cmt_md_relationships?trail_id=configure-your-app-with-custom-metadata-types)
Metadata relationship fields work like relationship fields for standard or custom objects. <br>
Because they are custom metadata types, they have the same benefits of application configuration data. <br>
<br>
Custom metadata types support three types of relationships:

* Relationship to another custom metadata type
* Relationship to an EntityDefinition (such as a custom or a standard object definition)
* Relationship to a FieldDefinition (for both custom and standard fields)

Add a new **Metadata Relationship** to you CMT: <br>
![formula](/cert-prep/images/cmt_relationship-field_01.png)

To relate it to an object, select **Entity Definition**: <br>
![formula](/cert-prep/images/cmt_relationship-field_02.png)

After that you can create **Field Definition** relationship fields: <br>
![formula](/cert-prep/images/cmt_relationship-field_03.png)

That field relation ship requires a **controlling field** – the entity definition relation ship field from the prior step: <br>
![formula](/cert-prep/images/cmt_relationship-field_04.png)

In the CMT record, you can now choose the object to relate to in the **Entity Definition** relationship field. <br>
This will grant you access to those object's field in the **Field Definition** relationship field. <br>
A **Custom Metadata Type** relationship field will grant you access to the CMT records available for the related type. <br>
![formula](/cert-prep/images/cmt_relationship-field_05.png)

Those relationships in our now created mapping records can be used to enhance functionality via Apex or Flow. <br>
![formula](/cert-prep/images/cmt_relationship-field_06.png)


### [Custom Settings](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_customsettings.htm)
tbd
