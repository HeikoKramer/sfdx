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

![license-types](/cert-prep/images/community-cloud_license-types.png)

#### [Channel Account Licenses](https://help.salesforce.com/s/articleView?id=sf.users_license_types_partner_based.htm&type=5)
tbd

### [Lightning Data](https://help.salesforce.com/s/articleView?id=sf.lightning_data_packages_use.htm&type=5)
tbd

### [Duplicate Management](https://help.salesforce.com/s/articleView?id=sf.duplicate_prevention_map_of_tasks.htm&type=5)
tbd

#### [Merging Duplicate Contacts](https://help.salesforce.com/s/articleView?id=sf.contacts_considerations_for_merging_duplicates.htm&type=5)
tbd

#### [Duplicate Jobs](https://help.salesforce.com/s/articleView?id=sf.duplicate_jobs.htm&type=5)
tbd

### [Customer 360 Data Manager](https://help.salesforce.com/s/articleView?id=sf.c360_basics.htm&type=5)
tbd

#### [Data Mapping](https://help.salesforce.com/s/articleView?id=sf.c360map_map_your_data.htm&type=5)
tbd

### [Batch Apex](https://developer.salesforce.com/blogs/engineering/2013/02/force-com-batch-apex-and-large-data-volumes)
Batch Apex allows for asynchronous processing of large number of records. <br>
Batch Apex can 
* make callouts to external systems
* apply business logic
* create records in Salesforce

A Batch Apex job can be scheduled to process records in batches. <br>
Docu: [Using Batch Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm) <br>

### [Salesforce as Identity Provider](https://help.salesforce.com/s/articleView?id=sf.identity_provider_enable.htm&type=5)
tbd

### [Canvas App](https://help.salesforce.com/s/articleView?id=sf.connected_app_create_canvas.htm&type=5)
tbd

### [Bulk API 2.0](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_intro.htm)
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
