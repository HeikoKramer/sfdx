# Salesforce Data Architect Notes
Notes I'm taking during my preparation for the [Salesforce Data Architect](https://trailhead.salesforce.com/en/credentials/dataarchitect) exam. <br> 
<br>
Resources used for my prep-works: 
* [Exam Guide](https://trailhead.salesforce.com/help?article=Salesforce-Certified-Data-Architect-Exam-Guide)
* [Trailmix](https://trailhead.salesforce.com/en/users/strailhead/trailmixes/architect-data-architecture-and-management)
* [DecodeSFCertifications YouTube Channel](https://youtu.be/Sw-iqjxdI7w)
* [Book: Salesforce Data Architecture and Management](https://www.packtpub.com/product/salesforce-data-architecture-and-management/9781801073240)
* [FocusOnForce Data Architect Certification Practice Exams](https://focusonforce.com/salesforce-data-architecture-and-management-designer-certification-practice-exams/)

## Data Modeling / Database Design (25%)
Given a customer scenario, you should be able to:
* compare and contrast various techniques and considerations for designing a data model for the Customer 360 platform
  * (e.g. objects, fields & relationships, object features)
* recommend approaches and techniques to design a scalable data model that obeys the current security and sharing model
* compare and contrast various techniques, approaches and considerations for capturing and managing business and technical metadata 
  * (e.g. business dictionary, data lineage, taxonomy, data classification)
* compare and contrast the different reasons for implementing Big Objects vs Standard/Custom objects within a production instance
  * alongside the unique pros and cons of utilizing Big Objects in a Salesforce data model
* given a customer scenario, recommend approaches and techniques to avoid data skew 
  * (record locking, sharing calculation issues, and excessive child to parent relationships)

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

## Master Data Management (5%)
Given a customer scenario, you should be able to:
* compare and contrast the various techniques, approaches and considerations for implementing Master Data Management Solutions 
  * MDM implementation styles
  * harmonizing & consolidating data from multiple sources
  * establishing data survivorship rules 
  * thresholds & weights
  * leveraging external reference data for enrichment
  * Canonical modeling techniques
  * hierarchy management
* recommend and use techniques for establishing a "golden record" or "system of truth" for the customer domain in a Single Org
* recommend approaches and techniques for consolidating data attributes from multiple sources
  * discuss criteria and methodology for picking the winning attributes
* recommend appropriate approaches and techniques to capture and maintain customer reference & metadata
  * to preserve traceability and establish a common context for business rules 

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

#### Custom Metadata Types in SOQL
Custom Metadata records can be queried like any other Salesforce object. <br>
**NOTE:** Even though the suffix for the custom metadata type is **__mdt**, the suffix for the custom field stays as **__c**. <br>
Default fields of the CMD – like the *DeveloperName* – do not have any suffix. <br> 

```sql
SELECT DeveloperName, Minimum_Spending__c FROM Support_Tier__mdt
```

#### [Custom Metadata Types in Apex](https://trailhead.salesforce.com/content/learn/modules/custom_metadata_types_adv/cmt_develop?trail_id=configure-your-app-with-custom-metadata-types)
Records that affect the way an org behaves – such is the case with custom metadata types – **should be included in testing!** <br>
Custom metadata types are set up the same way as workflow and validation rules. <br>
Your Apex test classes can see custom metadata types and access their fields and records. <br>
<br>
Apex code can
* create, read, and update (but not delete) custom metadata records
  * as long as the metadata is subscriber-controlled 
  * and visible from within the code's namespace

You can edit records in memory but not upsert or delete them. <br>
Apex code can deploy custom metadata records, but not by using a data manipulation language (DML) operation. <br>
Use **Metadata.DeployContainer** to manage custom metadata components for deployment. <br>

#### Additional Custom Metadata Considerations and Resources 
Especially when distributed across multiple org, the question who can **access** and **change** custom metadata types becomes relevant. <br>
The [Protect Custom Metadata Types and Records](https://trailhead.salesforce.com/en/content/learn/modules/custom_metadata_types_adv/cmt_manageability?trail_id=configure-your-app-with-custom-metadata-types) Trailhead module provides a good overview on the topic. <br>
<br>
Useful document: [Custom Metadata Types Implementation Guide](http://resources.docs.salesforce.com/218/9/en-us/sfdc/pdf/custom_metadata_types_impl_guide.pdf)

### [Custom Settings](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_customsettings.htm)
*Custom settings are similar to custom objects. Application developers can create custom sets of data and associate custom data for an organization, profile, or specific user. All custom settings data is exposed in the application cache, which enables efficient access without the cost of repeated queries to the database. Formula fields, validation rules, flows, Apex, and SOAP API can then use this data.* <br>
<br>
There are two types of custom settings:
* List Custom Settings
  * provides a reusable set of static data that can be accessed across your organization
  * put frequently used data in a list custom setting to streamlines access to it
  * data in list settings does not vary with profile or user, but is available organization-wide
  * examples of list data:
    * two-letter state abbreviations
    * international dialing prefixes
    * catalog numbers for products
  * data is cached
  * access is low-cost and efficient
    * you don't have to use SOQL queries that count against your governor limits
* Hierarchy Custom Settings
  * uses a built-in hierarchical logic that lets you **personalize** settings for specific profiles or users
  * checks the organization, profile, and user settings for the current user and returns the most specific, or “lowest,” value

## Salesforce Data Management (25%)
Given a customer scenario, you should be able to
* recommend appropriate combination of Salesforce license types 
  * to effectively leverage standard and custom objects to meet business needs
* recommend techniques to ensure data is persisted in a consistent manner 
* describe techniques to represent a single view of the customer on the Salesforce platform, with multiple systems of interaction
* recommend a design to effectively consolidate and/or leverage data from multiple Salesforce instances

Generally interesting resources:
* [Common REGEX Validation](https://help.salesforce.com/s/articleView?id=000334073&type=1)

### [Translation Workbench](https://help.salesforce.com/s/articleView?id=sf.customize_wbench.htm&type=5)
Translation Workbench allows you to …

* specify languages for translation 
* assign translators
* manage your translations 

… through the workbench or bulk translation. <br>
<br>
Enabling Translation Workbench makes these changes to your Salesforce org:
* The **Manage Translation** systems permission is available in permission sets
* You must edit picklist values individually 
  * You can’t mass-edit existing picklist values, but you can still mass-add new values
* When picklist values are sorted alphabetically, the values are alphabetical by the org’s default language
* Reports have a Filter Language dropdown list in the Filters pane of the report builder 
  * for any filter criteria that use the starts with, contains, or does not contain operator
* Import files have a Language dropdown list, and all records and values within the import file must be in the selected language
* Web-to-Lead and Web-to-Case have a Language dropdown list before you generate the HTML

**Note:** If a customized component doesn’t have a translated value, the component uses the org’s default language. <br>
When you deactivate a language, all translations for that language are still available in Translation Workbench. <br>
However, users with that language selected see the org’s default language values. <br>

#### [Considerations for Managing Translations](https://help.salesforce.com/s/articleView?id=sf.workbench_best_practices.htm&type=5)
* Salesforce assumes that all customizations are entered in the Salesforce org’s default language
  * it's recommended that global administrators work together in the org’s default language
* Salesforce recommends the XML Localization Interchange File Format (.xlf) for translation files
* When creating a custom report type for translation into multiple languages via Translation Workbench
  * set your personal language to match your org’s default language
  * this ensures that translated words display in the correct language for translators
* users can customize reports or list views to use filter criteria values in their personal language
  * if they use the *starts with* or *contains* operators, advise them to choose the language of the filter criteria values they entered
* If you installed a managed package that includes translations
  * those translated values appear to users regardless of whether the language is active on the Translation Language Settings Setup page
  * To override delivered metadata translations, see [Override Translations in Second-Generation Managed Packages and Unlocked Packages](https://help.salesforce.com/s/articleView?id=sf.entering_translated_terms_in_packages.htm&type=5)
* Let translators know which languages they are responsible for translating
* Notify all translators when you add new translated components to your org 
  * for best results, have your translators check their translations frequently, and be sure to notify them when changes occur
* Periodically review outdated translations by exporting your translations 
  * use the *Outdated and Untranslated* export type or *Bilingual* export type 
    * to generate a list of all the translatable customizations and the associated Out of Date states 

There are additional [Considerations for Translating Flows](https://help.salesforce.com/s/articleView?id=sf.workbench_flow_considerations.htm&type=5).

### [Customer 360 Data Manager](https://help.salesforce.com/s/articleView?id=sf.c360_basics.htm&type=5)
**NOTE:** Feature is scheduled for retirement as of Summer ’22! <br>
*I'll anyhow list some key-infos here, as this could still be part of the cert when I'm taking it.* <br>
<br>
Purpose:
* integrate data among multiple Service Cloud orgs and Commerce Cloud 
* connect data across multiple orgs
  * case history, order history, and customer data across your enterprise 
* Customer 360 Data Manager assigns a **global profile** to each unique customer
  * to for example view a customer’s order history in Service Console without having to swivel to Commerce Cloud

Features:
Set match rules using individual Name fields:
* first name, last name, suffix 
* phone numbers
* email addresses
* postal addresses
* unique party identifiers such as loyalty numbers

Data encryption limitations:
* no Shield Platform encryption or customer-provided encryption support
* If you don’t want that encrypted Salesforce data visible, don’t include it in your data loads or mapped data

License limitations:
* Customer 360 Data Manager is provisioned with 10 user licenses
* Additional licenses can be purchased 

### [Experience Cloud User Licenses](https://help.salesforce.com/s/articleView?id=sf.users_license_types_communities.htm&type=5)
**Main Features:**

|Features|Customer Community|Customer Community Plus|Partner Community|Channel Account|External Apps|
|:-------|:-----------------|:----------------------|:----------------|:--------------|:------------|
|Accounts, Assets, Contacts, Orders, Price Books, Products, Tasks|y|y|y|y|read only|
|Leads, Campaigns, Opportunities, Quotes|n|n|y|y|n|
|Cases, Entitlements, Events, WO, WOLI|y|y|y|y|n|
|External Objects|y|y|y|y|y|
|Custom Objects|10|10|10|10|100|
|Events and Calendar|read only|y|y|y|n|
|Notes and Attachments|Exceptions apply|y|y|y|n|
|Reports|n|y|y|y|n|
|+ Extra Data Storage (member-based/login-based)|none|2MB/1MB|5MB/1MB|5MB/1MB|10MB/none|
|+ API Calls per day (member-based/login-based)|0|200/100|200/10|200/10|200/400|
<br>

**License Type Decision Diagram:** <br>

![license-types](/cert-prep/images/community-cloud_license-types.png)

#### [Channel Account Licenses](https://help.salesforce.com/s/articleView?id=sf.users_license_types_partner_based.htm&type=5)
*The Channel Account license is available for Experience Cloud sites and has the same permission and feature access as the Partner Community license. Unlike login or member-based licenses, Channel Account licenses are priced per partner account. Partners then open up access to users.* <br>
<br>
**Best Used For:**
Business-to-business sites and portals that calculate their usage based on number of partners instead of number of individual users. <br>
<br>
**What are partner-based licenses?** <br>
* external license
* gives you the power to buy a specific number of licenses for your partner accounts
* Each partner account with an assigned license is given up to 40 partner users 
* User licenses are pooled
  * making it less likely for partners to exceed user limits 
* Extra users, beyond the typical 40, can be purchased if necessary

<br>

**When do you use a partner-based license?** <br>
* when you want to give your partner users access to Experience Cloud sites
  * but aren’t sure how many users need access
* when you want to give your partners the power to manage their own users

### [Lightning Data](https://help.salesforce.com/s/articleView?id=sf.lightning_data_packages_use.htm&type=5)
**Lightning Data** is rather an App Exchange category than a concrete product. <br>
Salesforce describes it like this: <br>
*Lightning Data apps give customers next-level data quality, enabling them to create more intelligent processes built on better, more targeted data, which improves CRM user adoption and ROI. Best of all, seamless integration requires minimal ongoing maintenance, and makes data readily available on any device without IT involvement.* <br>
<br>
Yes, .. just a category: https://appexchange.salesforce.com/appxStore `?type=Data` <br>
<br>
Popular services:
* D&B Optimizer
  * Dun & Bradstreet Account and Lead Data for Salesforce
* Omnata for Salesforce
  * Connect Salesforce to your cloud data warehouse
  * integrate data from Snowflake, BigQuery & Rockset
* miEdge Prospector
  * brings insurance and risk insights into Salesforce

### [Duplicate Management](https://help.salesforce.com/s/articleView?id=sf.managing_duplicates_overview.htm&type=5)
Out of the box, Salesforce gives you tools for
* managing duplicates one at a time 
* managing duplicates across your org
* to track your progress in eliminating duplicates

#### [Duplicate Rules](https://salesforce.vidyard.com/watch/GOnlv-GJRRSrdeN-Kn0-JQ)
**Duplicate rules** determine how Salesforce handles duplicate records – identified by **matching rules**. <br>
Salesforce includes standard Duplicate Rules for the following objects:
* Accounts
* Contacts
* Leads

When duplicate rules are activated, sales reps are informed about potential duplicates when viewing or creating a record. <br>
They can than **merge** duplicate records into one record. <br>
An admin can set up a Duplicate Rule to **block** users from creating duplicate records. <br>
Duplicate rules can be set up to **bypass sharing rules** – so duplicates are detected, even if the user has by default no access to the other record. <br>
Users with a certain **role** or **profile** can be excluded to be affected by duplicate rules. <br>

##### [Duplicate Rules Considerations](https://help.salesforce.com/s/articleView?id=duplicate_rules_overview.htm&type=5&language=en_US)
**Number of Duplicate and Matching Rules**
* You can use up to **five active duplicate rules per object**
* You can add up to **three matching rules in each duplicate rule**
  * with **one active matching rule per object**

If you select the **report option** for identified duplicates and a user saves a duplicate record, the following happens: <br>
The saved record and the maximum number of duplicates are reassigned to a new or existing **duplicate record set**. <br>
For each matching rule run on a record, up to 100 duplicates can be reassigned to a duplicate record set. <br>
The saved record and each of its duplicates are listed as **duplicate record items** in the duplicate record set. <br>
If the duplicate rule looks for duplicates across objects (for example, contacts that duplicate leads), the duplicate record set includes duplicates on the other objects. <br>
If a duplicate lead is converted before the duplicate record set is created, the duplicate record set doesn’t include the converted lead. <br>
<br>
**NOTE:** If a user who updates a record doesn’t have access to one or more fields referenced in a matching rule, then the duplicate rule doesn’t work as expected! <br>
**NOTE:** Rules only run on edited records when the edited fields **are included** in the associated matching rule! <br>
**NOTE:** Global picklist values aren’t supported in duplicate rules! <br>
**NOTE:** Custom picklist fields aren’t supported in matching rules used in cross-object duplicate rules! <br>
**NOTE:** Rules only compare new records with records already in Salesforce – bulk load data is not compared in itself! <br>
**NOTE:** The Translation Workbench doesn’t support the customizable alert text in duplicate rules. <br>
<br>
**Conditions under which duplicate rules don’t run:**
* Records are created using Quick Create or Community Self-Registration
* Leads are converted to accounts or contacts, and Use Apex Lead Convert isn’t enabled
* Records are restored with the Undelete button
* Records are added using Lightning Sync or Einstein Activity Capture
* Records are manually merged
* A Self-Service user creates records, and the rules include conditions based on the User object
* Duplicate rule conditions are set for lookup relationship fields and records but no value for these fields has been saved
<br>
**In the following situations, no alert is shown and users can’t save records:**
* Records are added using the data import tools
* A person account is converted to a business account and the business account matches an other account
* Records are added or edited using Salesforce APIs

#### [Matching Rules](https://salesforce.vidyard.com/watch/PdYJPLbTqiI-kCXlWrr32w)
**Matching Rules** identify duplicate records for
* Accounts
* Contacts
* Leads

A matching rule contains **fields** and **criterias**:
![matching-rules](/cert-prep/images/matching-rules.png)

Matching rules identify **similar** strings, by comparing them with the **exact** or **fuzzy** matching method:
![similar-matching-rule](/cert-prep/images/matching-rules_similar.png)

Choose between **exact** and **fuzzy** matching method. <br>
By default **blank fields** are not matched – but can be selected to be part of the **matching criteria**. <br>
The **filter logic** can be adjusted. <br> 
![matching-rules_setup](/cert-prep/images/matching-rules_setup.png)

##### [Matching Rules Considerations](https://help.salesforce.com/s/articleView?id=sf.matching_rules_considerations.htm&type=5)
**Limits:** 
* Up to five matching rules can be activated or deactivated at a time
* Up to five active matching rules are allowed per object
* Up to 25 total active matching rules are allowed
* Up to 100 total matching rules are allowed (both active and inactive)
* Only one lookup relationship field is allowed per matching rule

#### [Duplicate Record Sets](https://help.salesforce.com/s/articleView?id=sf.duplicate_management_duplicate_record_sets.htm&type=5)
A duplicate record set is a list of items identified as duplicates. It’s created when a duplicate rule or job runs. <br>
Let your Lightning Experience users merge duplicates by granting them access to duplicate record sets. <br>

#### [Duplicate Error Logs](https://help.salesforce.com/s/articleView?id=sf.duplicate_management_duplicate_error_log.htm&type=5)
The **Duplicate Error Logs** section in **Setup** provides you a list view with all errors linked to standard de-duplication. <br>

#### [Merging Duplicate Contacts](https://help.salesforce.com/s/articleView?id=sf.contacts_considerations_for_merging_duplicates.htm&type=5)
**Primary Account**
* **Lightning Experience**: You can merge contacts that have different primary accounts
* **Salesforce Classic**: You can merge only contacts that have the same primary account 

**NOTE:** You contacts associated with a portal user can only be merged with an other portal user contact. <br>
Have a look at the [Considerations for Merging Contacts Associated with Portal Users](https://help.salesforce.com/s/articleView?id=sf.contacts_merging_contacts_associated_with_portal_users.htm&type=5)
<br>

**Data Privacy Preferences** <br>
When you merge duplicate leads or contacts, you also associate a **data privacy record** with the primary record. <br>
You can select to retain the **most recently updated** data privacy record or choose manually which one to retain. <br>
<br>
**Contact Roles** <br>
When contacts are merged, contact roles on non-master contacts lose their status. <br>
<br>
**Portal Users**
* **Lightning**: Portal user status isn’t shown during merging
  * The merged record retains the portal user status of the primary record
* **Classic**: Portal user status is shown during merging
  * You choose the portal status you want to retain in the merged record
* **Lightning** and Classic: The primary contact must be associated with a portal user
  * The merged contact retains the portal user status of the primary contact
  * If a non-master contact is associated with a portal user, that user is deactivated

**Campaigns** <br>
When duplicate contacts that are members of different campaigns are merged, Salesforce retains the Member Status Updated date for each campaign the merged contact is a member of. <br>
<br>
**Related Items, Chatter Feeds, and Attachments** <br>
Salesforce relates items to merged records, with some exceptions:
* Chatter feeds are retained from the primary record only
* Salesforce Files attached in the Chatter feed or Files related list are retained in the merged record

**Hidden and Read-Only Fields** <br>
Salesforce retains any data in hidden or read-only fields, such as sharing settings, from the primary record. <br>
Hidden fields aren’t shown while you merge. <br>
A merged record retains the Created By user and Created Date from the oldest record merged, regardless of which record is the primary. <br>
The record shows the merge date as the Last Modified By date. <br>
<br>
**Non-Master Contacts** <br>
The non-master contacts are moved to the Recycle Bin. <br>

#### [Duplicate Jobs](https://help.salesforce.com/s/articleView?id=sf.duplicate_jobs_considerations.htm&type=5)
You can set up **Duplicate Jobs** to run pre-defined **Matching Rules**. <br>
The job will add identified duplicates to a **Duplicate Record Set**. <br>
<br>
**Limits:** <br>
New jobs are blocked, or job results are deleted or overwritten, under the following circumstances: <br>
* Creating a job with the same settings (object and matching rule) as a completed job overwrites the earlier job
* When you run a job using an edited matching rule, prior results of jobs containing that rule get deleted
* When the total number of duplicates in all completed jobs reaches 1,000,000, you can’t run new jobs
  * To run a job, delete the results of one or more jobs until the number of duplicate record items falls below 1,000,000

**Duplicate Record Sets and List Views** <br>
For each job you run, a **list view of duplicate record sets** is generated. <br>
If you delete the list view, the duplicate record sets and duplicate record items persist, and information about the job in Setup also persists. <br>
However, if you delete the job’s results in Setup, the corresponding list view, duplicate record sets, and duplicate record items are all deleted. <br>
<br>
**NOTE:** When duplicate record sets or items in a set generated by a duplicate job contain required custom fields, the job fails. <br> 
If a field included in a matching rule used for a duplicate job is encrypted, the job fails. <br>

### [Batch Apex](https://developer.salesforce.com/blogs/engineering/2013/02/force-com-batch-apex-and-large-data-volumes)
Batch Apex allows for asynchronous processing of large number of records. <br>
Batch Apex can 
* make callouts to external systems
* apply business logic
* create records in Salesforce

A Batch Apex job can be scheduled to process records in batches. <br>
Docu: [Using Batch Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm) <br>
<br>
Batch Apex allows you to run complex and long-running processeses. <br>
It typically goes through the following general steps:
* The start method of collects the records or objects that will be processed
  * Using well-performing SOQL in the start() method reduces the chances of a job being aborted
* The execute method picks up batches of these records and does the bulk of the processing
* After the batches are processed, the finish method sends confirmation emails or executes post-processing operations

### [Salesforce as Identity Provider](https://help.salesforce.com/s/articleView?id=sf.identity_provider_enable.htm&type=5)
You can enable your Salesforce org as a single sign-on (SSO) SAML identity provider to external service providers. <br>
When your org acts as a SAML identity provider, your users can access multiple apps with a single login. <br>
After you enable Salesforce as an identity provider, define a service provider by setting up a SAML-enabled connected app. <br>

### [Canvas App](https://help.salesforce.com/s/articleView?id=sf.connected_app_create_canvas.htm&type=5)
You can expose your connected app as a canvas app. <br>
Canvas apps are available as apps that your org’s Salesforce admin install or as personal apps that users install across orgs. <br>
Users access a canvas personal app from the Chatter tab, and are prompted to allow the app to connect to their Salesforce data. <br>
Users can choose to make an app a canvas personal app. <br>

#### [Canvas Personal Apps](https://developer.salesforce.com/docs/atlas.en-us.236.0.platform_connect.meta/platform_connect/canvas_personal_apps_about.htm)
Canvas personal apps let you create connected apps that are designed specifically for end users across organizations. <br>
With a canvas personal app, you make your own app available for installation without relying on organization administrators for distribution. <br>
<br>
Previously, only administrators could install canvas apps. <br>
Administrators can still install canvas apps, but now developers can create canvas personal apps that end users can install themselves. <br>
<br>
End users install and use canvas personal apps right from the Chatter tab (provided that they have appropriate permissions in Salesforce). <br>
When end users install the app, they are prompted to allow the app to use their Salesforce data. <br>
<br>
More information in the [Canvas Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.236.0.platform_connect.meta/platform_connect/canvas_framework_intro.htm)

### [Bulk API 2.0](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm)
The **REST-based** Bulk API 2.0 provides a programmatic option to **asynchronously** 

* upload
* query
* or delete 

large data sets in your Salesforce org. <br>
Any data operation that includes **more than 2,000 records** is a good candidate for Bulk API 2.0 to successfully 

* prepare
* execute
* and manage 

an asynchronous workflow that makes use of the Bulk framework. <br>
Jobs with fewer than 2,000 records should involve “bulkified” synchronous calls in REST (for example, Composite) or SOAP. <br>
Using the API requires basic familiarity with software development, web services, and the Salesforce user interface. <br>
This API is enabled by default for Performance, Unlimited, Enterprise, and Developer Editions. <br>
The **API Enabled** permission must be enabled. <br>

#### [What’s the Difference Between Bulk API 2.0 and Bulk API?](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/bulk_common_diff_two_versions.htm)
Although Bulk API 2.0's predecessor, “Bulk API”, is available, use Bulk API 2.0 instead of Bulk API if you want a more streamlined workflow. <br>
Bulk API 2.0 provides a simple interface to load large amounts of data into your Salesforce org and to perform bulk queries on your org data. <br>
Its design is more consistent and better integrated with other Salesforce APIs. <br>
Bulk API 2.0 also has the advantage of future innovation. <br>

#### [How Requests Are Processed](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/how_requests_are_processed.htm)
Bulk ingest jobs allow you to upload records to your org by using a CSV file representation. <br>
Bulk query jobs return records based on the specified query. <br>
A Bulk API job specifies which object is being processed and what type of action is being used (insert, upsert, update, or delete). <br>
You process a set of records by creating a job that contains one or more batches. <br>
Whether you create an ingest or query job, Salesforce automatically optimizes your request to process the job as quickly as possible and to minimize timeouts or other failures. <br>

#### [Limits](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/bulk_common_limits.htm)
tbd

#### [Bulk API Query](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_bulk_query_intro.htm)
tbd

### [Limits on Report Types](https://help.salesforce.com/s/articleView?id=sf.reports_report_type_guidelines.htm&type=5)
tbd

### [Record-triggered Flows](https://help.salesforce.com/s/articleView?id=sf.flow_concepts_trigger_record.htm&type=5)
tbd

### [Salesforce CDP](https://help.salesforce.com/s/articleView?id=sf.customer360_a.htm&type=5)
tbd

### [Salesforce Connect](https://help.salesforce.com/s/articleView?id=sf.platform_connect_about.htm&type=5)
tbd

#### [Salesforce Connect Cross-Org Adapter](https://help.salesforce.com/s/articleView?id=sf.xorg_setup.htm&type=5)
tbd
