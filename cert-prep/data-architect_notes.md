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
Questions that might help to plan for limits: <br>

* How many other integrations are making API requests into your org?
* How close does your org come to reaching its entitled request limit each day?
* How many API requests per day would be required in order to address your use cases and data volume?
* Of the APIs that could do the job you’re planning, what are their limits characteristics?

**Batch Allocations** <br>

You can submit up to **15,000 batches per rolling 24-hour** period. <br>
This allocation is shared between Bulk API and Bulk API 2.0. <br>
Every batch that is processed in Bulk API or Bulk API 2.0 counts towards this allocation. <br>

<br>

**Maximum number of records uploaded per 24-hour rolling period** <br>
**Bulk API:** 150,000,000 (15,000 batches x 10,000 records per batch maximum) <br>
**Bulk API 2.0:** 150,000,000 <br>

<br>

**Batch processing time** <br>
**Both Bulk APIs:** Batches are processed in chunks. The chunk size depends on the API version. In API version 20.0 and earlier, the chunk size is 100 records. In API version 21.0 and later, **the chunk size is 200 records**. If it takes **longer than 10 minutes** to process a whole batch, the Bulk API places the remainder of the batch back in the queue for later processing. If the Bulk API continues to exceed the 10-minute limit on subsequent attempts, the batch is placed back in the queue and reprocessed up to 10 times before the batch is permanently marked as failed.

<br>

**Maximum time before a batch is retried** <br>
**Bulk API:** 10 minutes <br>
**Bulk API 2.0:** The API automatically handles retries. If you receive a message that the API retried more than 10 times, use a smaller upload file and try again. <br> 

<br>

**Maximum file size** <br>
**Bulk API:** 10MB <br>
**Bulk API 2.0:** 150MB <br>

<br>

**Maximum number of fields in a record** <br>
**Both Bulk APIs:** 5.000 <br>

<br>

**Maximum number of characters in a record** <br>
**Both Bulk APIs:** 400.000 <br>

<br>

**Maximum number of records in a batch** <br>
**Bulk API:** 10.000 <br>
**Bulk API 2.0:** N/A <br>

**Maximum number of characters for all the data in a batch** <br>
**Bulk API:** 10.000.000 <br>
**Bulk API 2.0:** N/A <br>

#### [Bulk API Query](https://developer.salesforce.com/docs/atlas.en-us.api_asynch.meta/api_asynch/asynch_api_bulk_query_intro.htm)
Use bulk query to efficiently query large data sets and reduce the number of API requests. <br>
A bulk query can retrieve up to **15 GB** of data, divided into **15 files of 1 GB each**. <br>
The data formats supported are **CSV, XML, and JSON**. <br>

### [Limits on Report Types](https://help.salesforce.com/s/articleView?id=sf.reports_report_type_guidelines.htm&type=5)
Custom report types are subject to some limits for high performance and usability. <br>

* A custom report type can contain up to **60 object references** 
  * For example, if you select the maximum limit of four object relationships for a report type, you can select fields via lookup from an extra 56 objects
* If a user runs a report from a custom report type and the report has columns from **more than 20 different objects**, an **error occurs**
* You can add up to **1,000 fields** to each custom report type 
  * A counter at the top of the Page Layout step shows the current number of fields 
  * If you have too many fields, you can’t save the layout
* You can’t add these fields to custom report types:
  * Product schedule fields
  * History fields
  * The Age field on cases and opportunities
* Custom report types based on the Service Appointments object don't support these fields:
  * Parent Record
  * Owner
* Object references can be used as the main four objects, as sources of fields via lookup, or as objects used to traverse relationships
  * Each referenced object counts toward the maximum limit even if no fields are chosen from it
  * For example, if you do a lookup from account to account owner’s role, but select no fields from account owner, all the referenced objects still count toward the limit of 60
* Reports run from custom report types that include cases don’t display the Units dropdown list, which lets users view the time values of certain case fields by hours, minutes, or days
* Report types associated with custom objects in the Deleted Custom Objects list count against the maximum number of custom report types you can create
* Reports on feed activities don’t include information about system-generated posts, such as feed tracked changes
* Custom report type names support up to 50 characters
  * If you enter a name that is longer than 50 characters, the name gets truncated
* Custom report type descriptions support up to 255 characters 
  * If you enter a description that is longer than 255 characters, the description gets truncated
* When a lookup relationship is created for a standard or custom object as an Opportunity Product field, and then a custom report type is created with that primary object, Opportunity Product isn’t available as a secondary object for that custom report type

### [Record-triggered Flows](https://help.salesforce.com/s/articleView?id=sf.flow_concepts_trigger_record.htm&type=5)
Creating or updating a record can trigger an autolaunched flow to make additional updates to that record before it's saved to the database. <br>
A record-triggered flow can update a Salesforce record **10 times faster** than a record-change process. <br> 
Configure the record trigger in the Start element of your autolaunched flow. <br>
<br>
A flow that makes **before-save** updates is similar to a **before trigger**. <br>
In a save procedure, before-save updates in flows are **executed immediately prior to Apex before triggers**. <br>
<br>
Because of their speed, we recommend that you use before-save updates in flows to update fields on new or changed records. <br>
However, sometimes you must use a **record-change process** or an **Apex after trigger** to: <br>

* Access field values that are set only **after the record is saved**
  * such as the Last Modified Date field or the **ID of the new record**
* Create or update related records
* Perform actions other than updating the record that launches the flow

Flows that make before-save updates are typically simpler to build than other types of flows. <br>

* The `$Record` global variable contains the values from the record that triggers the flow to run 
 * As a result, there’s **no need to add a Get Records element** to obtain the record data nor create flow variables to store the record data
* When the flow changes the values in the `$Record` global variable, Salesforce automatically applies those new values to the record 
  * So there’s **no need to add an Update Records element** to save the new values to the database
* Only these elements are supported:
  * Assignment 
  * Decision
  * Get Records
  * Loop
    * These elements let you obtain data from other Salesforce records, and use them to decide whether to update the triggering record’s fields and to what values

### [Salesforce Connect](https://help.salesforce.com/s/articleView?id=sf.platform_connect_about.htm&type=5)
Salesforce Connect maps Salesforce external objects to data tables in external systems. <br>
Instead of copying the data into your org, Salesforce Connect accesses the data on demand and in real time. <br>
The data is never stale, and we access only what you need. <br>
Use Salesforce Connect when:

* You have a large amount of data that you don’t want to copy into your Salesforce org
* You need small amounts of data at any one time
* You want real-time access to the latest data

Even though the data is stored outside your org, Salesforce Connect provides seamless integration with the Lightning Platform. <br>
External objects are available to Salesforce tools, such as global search, lookup relationships, record feeds, and the Salesforce mobile app. <br>
External objects are also available to Apex, SOSL, SOQL queries, Salesforce APIs, and deployment via the Metadata API, change sets, and packages. <br>

<br>

**NOTE:** Using Salesforce Connect to access external data in an org requires one or more Salesforce Connect add-on licenses! <br>
Salesforce Connect Example: [Heroku External Objects with Salesforce Connect](https://devcenter.heroku.com/articles/heroku-external-objects-salesforce)

#### [Salesforce Connect Adapters](https://help.salesforce.com/s/articleView?id=sf.platform_connect_adapters.htm&type=5)
|Salesforce Connect Adapter|Description|When to Use|Number of Connections per License|
|:-------------------------|:----------|:----------|:--------------------------------|
|Cross-org|Uses the Lightning Platform REST API to access data that’s stored in other Salesforce orgs.|To seamlessly connect data between your Salesforce orgs. For example, provide your service representatives a unified view of customer transactions by integrating data from different Salesforce orgs.|5|
|OData 2.0 <br /> OData 4.0|Uses Open Data Protocol to access data that’s stored outside Salesforce. The external data must be exposed via OData producers.|To integrate external data sources into your org that support the ODATA protocol and publish an OData provider. For example, give your account executives a unified data view by pulling data from legacy systems such as SAP, Microsoft, and Oracle in real time.|1|
|Custom adapter <br /> created via Apex|You use the Apex Connector Framework to develop your own custom adapter when the other available adapters aren’t suitable for your needs. A custom adapter can obtain data from anywhere. For example, some data can be retrieved from the Internet via callouts, while other data can be manipulated or even generated programmatically.|To develop your own adapter with the Apex Connector Framework when the other available adapters aren’t suitable for your needs. For example, when you want to retrieve data via callouts from a REST API.|1|


## Large Data Volume considerations (20%)
* design a data model that scales considering large data volume and solution performance
* recommend a data archiving and purging plan that is optimal for customer's data storage management needs
* decide when to use virtualised data and describe virtualised data options

### [Skinny Tables](https://developer.salesforce.com/docs/atlas.en-us.salesforce_large_data_volumes_bp.meta/salesforce_large_data_volumes_bp/ldv_deployments_infrastructure_skinny_tables.htm)
Salesforce can create skinny tables to contain frequently used fields and to avoid joins. <br>
This can improve the performance of certain read-only operations. <br>
Skinny tables are kept in sync with their source tables when the source tables are modified. <br>

<br>

If you want to use skinny tables, contact Salesforce Customer Support. <br>
When enabled, skinny tables are created and used automatically where appropriate. <br>
You can’t create, access, or modify skinny tables yourself. <br>
If the report, list view, or query you’re optimizing changes—for example, to add new fields—you’ll need to contact Salesforce to update your skinny table definition. <br>

<br>

**Key features of skinny tables:**

* more rows are returned at a faster rate
* kept in sync with the base table 
* queries are faster, ad they **avoid joins**
* a collection of frequently used fields
* useful for high data volumes (millions of records)
* do not include soft deleted records
* provide a view across multiple objects for easy access to combined data

<br>

**Skinny tables can contain the following types of fields:** 

* Checkbox
* Date
* Date and time
* Email
* Number
* Percent
* Phone
* Picklist (multi-select)
* Text
* Text area
* Text area (long)
* URL

<br>

**Skinny table considerations:**

* Skinny tables can contain a maximum of 100 columns
* Skinny tables can’t contain fields from other objects
* For Full sandboxes: Skinny tables are copied to your Full sandbox orgs
* For other types of sandboxes: Skinny tables aren’t copied to your sandbox organizations (contact Salesforce support)

<br>

**Ressources:**

* [Long- and Short-Term Approaches for Tuning Force.com Performance](https://developer.salesforce.com/blogs/engineering/2013/03/long-and-short-term-approaches-for-tuning-force-com-performance)
 
### [Using Mashups](https://developer.salesforce.com/docs/atlas.en-us.salesforce_large_data_volumes_bp.meta/salesforce_large_data_volumes_bp/ldv_deployments_techniques_using_mashups.htm)
One approach to reducing the amount of data in Salesforce is to maintain large data sets in a different application, and then make that application available to Salesforce as needed. <br>
Salesforce refers to such an arrangement as a mashup because it provides a quick, loosely coupled integration of the two applications. <br>
Mashups use Salesforce presentation to display Salesforce-hosted data and externally hosted data. <br>

<br>

**Supported mashup designs:**

* External Website
  * The Salesforce UI displays an external website, and passes information and requests to it
  * With this design, you can make the website look like part of the Salesforce UI
* Callouts
  * Apex code allows Salesforce to use Web services to exchange information with external systems in real time

**NOTE:** Because of their real-time restrictions, mashups are limited to short interactions and small amounts of data. <br>

<br>

**Advantages of Using Mashups**

* Data is never stale
* No proprietary method needs to be developed to integrate the two systems

**Disadvantages of Using Mashups**

* Accessing data takes more time
* Functionality is reduced
  * **reporting and workflow do not work on the external data**

### [Salesforce Backup and Restore Essentials](https://developer.salesforce.com/blogs/2015/03/salesforce-backup-and-restore-essentials-part-1-backup-overview-api-options-and-performance)
**Reasons to do backups** <br>
Salesforce performs real-time replication to disk at each data center, and near real-time data replication between the production data center and the disaster recovery center. <br>
However, there are many different reasons why a customer would like to organize their own backup of information from Salesforce. <br>

* Recover from data corruption (unintended user error or malicious activity)
* Prepare for a data migration rollback
* Archive data to reduce volumes
* Replicate data to a data warehouse/BI
* Take snapshots of development versions

<br>

**What to backup and how?** <br>
There are two types of information you can backup from Salesforce: **Data** and **Metadata**. <br>
Salesforce provides four APIs to backup data and metadata information from the application: <br>

* REST API
* SOAP API
* Bulk API
* Metadata API

These APIs will allow you to set up either a **full**, **incremental**, or **partial** backup. <br>

<br>

**Security**
Any local backup should be properly guarded against security risks, which might involve encryption of local data or other security measures. <br>
When choosing a backup method, keep the following factors in mind to ensure your backup data is secure. <br>

* File system storage
  * data location
  * disk capacity
  * redundancy
  * availability
  * durability
  * encryption of the data at rest
  * encryption key management
  * physical security access
  * authentication
  * access logs
* Backup and Restore server configuration
* run and maintenance 
  * availability
  * redundancy
  * encryption of data in transit
  * encryption of cached data
  * network/CPU/memory capacity
* Backup archives retention 
  * retain backups for a specific amount of time

<br>

**Which API to pick?**
If you opt to use Salesforce APIs for your backup solution, you’ll need to choose which API to use based on your backup use case. <br>
Some APIs (such as the Bulk API) are designed for bulk operations that can be performed asynchronously, while other APIs are designed for synchronous operations. <br>

|Requirements|Recommended API|Explanation|
|:-----------|:--------------|:----------|
|You need to preserve governor limits regarding the number of API calls|Bulk|Bulk API **does not consume API calls** but **consumes Bulk API calls**, which are less restrictive|
|You need to preserve the governor limit regarding “number of batches per rolling 24 hour period”|REST or SOAP|REST or SOAP are not subject to Bulk-specific governor limits, however they have their own limits|
|You need to backup an object containing a large volume of records (more than 2M records) or do a backup that raises performance challenges|Bulk|Bulk API will generally be faster than the other APIs, but the REST or SOAP APIs might sometimes get better results depending on several factors: **query batch size**, **current asynchronous load** on the instance, **degree of parallelization**|
|You need to backup an object that is not yet supported by the Bulk API (CaseStatus, OpportunityStage, AcceptedEventRelation)|REST or SOAP|Bulk API does not yet support all queryable objects| 
|You need to backup an object that contains a lot of XML-like information (example: EmailMessage)|REST or Bulk|While this is not directly caused by the Salesforce SOAP API, we have seen some XML parsers encountering difficulties when processing the HTTP response (mix of XML-based protocol and XML data)|
|You need to backup metadata|Metadata|The Metadata API is by far the most exhaustive API to retrieve metadata, however a large part of the metadata is also available in the REST, SOAP and Tooling APIs|
|You need to back up files (Attachment, ContentVersion, Document, FeedItem, StaticResource, etc.)|REST or SOAP|The Salesforce CLI makes retrieving metadata rather easy.|

#### [Backup and Restore](https://help.salesforce.com/s/articleView?id=release-notes.rn_security_backup_restore_ga.htm&type=5&release=234)
Salesforce provides the own backup solution **Backup & Restore** at additional license cost. <br>
With Backup & Restore you can protect your organization against <br>

* incorrect data updates
* integration execution issues
* malicious actors
* and ransom ware attacks 

Backup & Restore provides: <br>

* Custom and Standard Object backups
* Daily incremental backups
* Backup in the same region
* Backup-to-Current-State comparisons
* Record previews before restoring
* Restoration to original org
* Backup dashboard & statistics
* Run logs on which to build custom triggers and flows

### [Integration Patterns](https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_pat_summary.htm)
Lists of integration patterns: <br>

|Pattern|Scenario|
|:------|:-------|
|Remote Process Invocation <br /> (Request and Reply)|Salesforce invokes a process on a remote system, **waits** for completion of that process, and then tracks state based on the response from the remote system.|
|Remote Process Invocation <br /> (Fire and Forget)|Salesforce invokes a process in a remote system but **doesn’t wait** for completion of the process. Instead, the remote process receives and acknowledges the request and then hands off control back to Salesforce.|
|Batch Data Synchronization|Data stored in Lightning Platform is created or refreshed to reflect updates from an external system, and when changes from Lightning Platform are sent to an external system. Updates in either direction are done in a batch manner.|
|Remote Call-In|Data stored in Lightning Platform is created, retrieved, updated, or deleted by a remote system.|
|UI Update Based on Data Changes|The Salesforce user interface must be automatically updated as a result of changes to Salesforce data.|
|Data Virtualization|Salesforce accesses external data in real time. This removes the need to persist data in Salesforce and then reconcile the data between Salesforce and the external system.|

Great article on [Data Virtualization](https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_data_virtualization.htm).

### [External Object Relationships](https://help.salesforce.com/s/articleView?id=sf.external_object_relationships.htm&type=5)
External objects support standard lookup relationships, which use the 18-character Salesforce record IDs to associate related records with each other. <br>
However, data that’s stored outside your Salesforce org often doesn’t contain those record IDs. <br>
Therefore, two special types of lookup relationships are available for external objects: **external lookups** and **indirect lookups**. <br>

<br>

External lookups and indirect lookups compare a **specific field’s values on the parent object** to the relationship field’s values on the child object. <br>
When values match, the records are related to each other. <br>

<br>

**Note:** Federated Search supports only external lookup relationships, and the Federated Search external object is always the parent. <br>

<br>

To create an external object relationship, create a custom field on the child object with one of the following field types. <br>
If the child is an external object, you can instead change the field type of an existing custom field to one of the following. <br>

* [Lookup Relationship](https://help.salesforce.com/s/articleView?id=sf.external_object_lookup_relationships.htm&type=5)
  * Use a lookup when the external data includes a column that identifies related Salesforce records by their **18-character IDs**
* [External Lookup Relationship](https://help.salesforce.com/s/articleView?id=external_object_external_lookup_relationships.htm&type=5&language=en_US)
  * Use an external lookup **when the parent is an external object**
* [Indirect Lookup Relationship](https://help.salesforce.com/s/articleView?id=external_object_indirect_lookup_relationships.htm&type=5&language=en_US)
  * Use an indirect lookup **when the external data doesn’t include Salesforce record IDs**

This table summarizes the types of relationships that are available to external objects. <br>

|Relationship|Allowed Child Objects|Allowed Parent Objects|Parent Field for Matching Records|
|:-----------|:--------------------|:---------------------|:--------------------------------|
|Lookup|Standard <br /> Custom <br /> External|Standard <br /> Custom|The 18-character Salesforce record ID|
|External Lookup|Standard <br /> Custom <br /> External|External|The External ID standard field|
|Indirect Lookup|External|Standard <br /> Custom|You select a custom field with the `External ID` and `Unique` attributes|


### [Field History Tracking](https://help.salesforce.com/s/articleView?id=sf.tracking_field_history.htm&type=5)
You can select certain fields to track and display the field history in the History related list of an object. <br>
Field history data is retained for up to **18 months through your org**, and up to **24 months via the API**. <br>
**NOTE:** Field history tracking data doesn’t count against your Salesforce org’s data storage limits! <br>

<br>

Salesforce stores an object’s tracked field history in an associated object called StandardObjectNameHistory or CustomObjectName__History. <br>
For example, AccountHistory represents the history of changes to the values of an Account record’s fields. <br>
Similarly, MyCustomObject__History tracks field history for the MyCustomObject__c custom object. <br>

<br>

**General Considerations:** <br>

* Salesforce starts tracking field history from the date and time that you enable it on a field
  * Changes made before this date and time aren’t included and didn't create an entry in the History related list
* Use Data Loader or the queryAll() API to retrieve field history that's 18–24 months old
* Changes to fields with more than 255 characters are tracked as edited, and their old and new values aren’t recorded
* Changes to time fields aren’t tracked in the field history related list
* The Field History Tracking timestamp is precise to a second in time
  * if two users update the same tracked field on the same record in the same second, both updates have the same timestamp
  * Salesforce can’t guarantee the commit order of these changes to the database 
  * As a result, the display values can look out of order
* You can’t create a record type on a standard or custom object and enable field history tracking on the record type in the same Metadata API deployment 
  * Instead, create the record type in one deployment and enable history tracking on it in a separate deployment
* Salesforce doesn’t enable the recently viewed or referenced functionality in StandardObjectNameHistory or CustomObjectName__History objects
  * As a result, you can’t use the FOR VIEW or FOR REFERENCE clauses in SOQL queries on these history objects
  * For example, the following SOQL query isn’t valid:
  * `SELECT AccountId, Field FROM AccountHistory LIMIT 1 FOR VIEW`

<br>

**Interactions With Other Salesforce Features** <br>

* In Lightning, you can see gaps in numerical order in the Created Date and ID fields
  * All tracked changes still are committed and recorded to your audit log 
  * the exact time that those changes occur in the database can vary widely and aren't guaranteed to occur within the same millisecond 
  * For example, there can be triggers or updates on a field that increase the commit time, and you can see a gap in time
  * During that time period, IDs are created in increasing numerical order but can also have gaps for the same reason
* If Process Builder, an Apex trigger, or a Flow causes a change on an object the current user doesn’t have permission to edit, that change isn’t tracked 
  * Field history honors the permissions of the current user and doesn’t record changes that occur in system context
* Salesforce attempts to track all changes to a history-tracked field, even if a particular change is never stored in the database 
  * For example, let’s say an admin defines an Apex before trigger on an object that changes a Postal Code field value of 12345 to 94619
  * A user adds a record to the object and sets the Postal Code field to 12345
  * Because of the Apex trigger, the actual Postal Code value stored in the database is 94619
  * Although only one value was eventually stored in the database, the tracked history of the Zip Code field has two new entries
    * No value --> 12345 (the change made by the user when they inserted the new record)
    * 12345 --> 94619 (the change made by the Apex trigger)

<br>

**Translation and Locale Considerations** <br>

* Tracked field values aren’t automatically translated; they display in the language in which they were made
  * For example, if a field is changed from Green to Verde, Verde is displayed no matter what a user’s language is, unless the field value has been translated into other languages via the Translation Workbench
  * This behavior also applies to record types and picklist values
* Changes to custom field labels that have been translated via the Translation Workbench are shown in the locale of the user viewing the History related list
  * For example, if a custom field label is Red and translated into Spanish as Rojo, then a user with a Spanish locale sees the custom field label as Rojo
  * Otherwise, the user sees the custom field label as Red
* Changes to date fields, number fields, and standard fields are shown in the locale of the user viewing the History related list
  * For example, a date change to August 5, 2012 shows as 8/5/2012 for a user with the English (United States) locale, and as 5/8/2012 for a user with the English (United Kingdom) locale

### [Salesforce Field Indexes](https://developer.salesforce.com/blogs/engineering/2015/06/know-thy-salesforce-field-indexes-fast-reports-list-views-soql)
Creating selective, optimizable filter conditions that target indexed fields is key when you want to run fast Salesforce 

* reports 
* list views
* SOQL queries

**Creating Indexes** <br>

One way that custom indexes get created is by Salesforce’s **auto-indexer**. <br>
The platform constantly analyzes custom index candidates, and when it sees that a custom index would make a noticeable difference in the response time for one or more queries, it automatically creates the index for you. <br>

Another other way is to log a case with Salesforce Support requesting a custom index to help the response time for a query. <br>
You can request a custom index too (and should) when you are working with large objects and know that an index will help your application perform more efficiently and faster. <br>

#### [Technical View on Indexes](https://developer.salesforce.com/docs/atlas.en-us.salesforce_large_data_volumes_bp.meta/salesforce_large_data_volumes_bp/ldv_deployments_infrastructure_indexes.htm)
The custom indexes that Salesforce Customer Support creates in your production environment are copied to all sandboxes that you create from that production environment. <br>

The platform maintains indexes on the following fields for most objects:

* RecordTypeId
* Division
* CreatedDate
* Systemmodstamp (LastModifiedDate)
* Name
* Email (for contacts and leads)
* Foreign key relationships (lookups and master-detail)
* The unique Salesforce record ID, which is the primary key for each object

<br>

Salesforce also supports custom indexes on custom fields, except for:

* multi-select picklists
* text areas (long)
* text areas (rich)
* non-deterministic formula fields
* encrypted text fields

<br>

External IDs cause an index to be created on that field. <br>
The query optimizer then considers those fields. <br>
You can create External IDs only on the following fields:

* Auto Number
* Email
* Number
* Text

### [Deferred Sharing Calculations](https://developer.salesforce.com/blogs/engineering/2013/08/extreme-force-com-data-loading-part-6-taking-advantage-of-deferred-sharing-calculation)
At some point during your project, you must configure your sharing settings so that your users have the appropriate level of access to the appropriate records. <br>
If your organization has large data volumes, you might find that the calculations you need to complete this configuration and implement your record access model add a substantial amount of time to your data loading. <br>
The calculations can increase your total data loading time for several reasons: <br>

* To determine if users who try to access records should actually be able to access those records, Salesforce stores data that specifies the individuals, roles, and groups that should have record access, as well as data that specifies which group members actually belong to a group.
* When new data is added or sharing settings are changed, the stored record sharing and group membership data must be updated accordingly.
* There are multiple ways to grant any user or group access to a record.
* Changes to the role and territory hierarchies can affect a large number of users in the organization, and require updating the sharing data for a large number of records.

Changes to organization-wide defaults and sharing rules can affect your users’ access to some or all of that object’s records. <br>

<br>

**Timing Your Sharing Configuration Steps** <br>

Pre-Data Loading Configuration Steps: <br>

* Create the role hierarchy.
* Assign users to roles.
* Set organization-wide defaults to Public Read/Write.

In the role hierarchy, record access is inherited based on record ownership, and managers automatically gain access to all of the records owned by people assigned to subordinate roles. <br>
If you load a lot of data, and then make significant changes to the role hierarchy or the users assigned to roles within that hierarchy, those changes will trigger a recalculation of record access so that the managers above the affected roles and role members have the appropriate, adjusted record access. <br>

<br>

If you set an object’s organization-wide default to Public Read/Write, the system will not use or maintain an object share table for that object—users will already have an unrestricted baseline level of access to all of that object’s records. <br>
Because the system is not maintaining an object share table for that object, it does not need to spend time calculating who should have access to its records when you load data. <br>

**NOTE:** The Public Read/Write organization-wide default can speed up your data loading, but at some point, you might need to use a different sharing setting to meet your business requirements. <br>

Post-Data Loading Configuration Steps: <br>

* Set organization-wide defaults to Public Read Only or Private.
* Create public groups and queues.
* Create sharing rules.
 
Once you have completed your data load and changed your objects’ organization-wide defaults to Public Read Only or Private, the system must perform a sharing calculation, which will take a substantial amount of time. <br>
As always, if you plan to load very large volumes of data, test your data load in a sandbox organization so that you can plan for the time that it will take to complete in production. <br>
Because sandbox and production environments are different, what you see in your sandbox organization might not line up perfectly with what you see in your production organization, but it should indicate the general scope and impact of your changes. <br>
Again, you cannot use Defer Sharing Calculation when changing your organization-wide defaults, but you can speed up these changes by asking Customer Support to enable the parallel sharing rule processing feature for your organization. <br>

Because public groups and queues are not part of the role hierarchy or the territory hierarchy, creating them does not slow sharing performance significantly, and there isn’t a strong reason for creating them at a specific time. <br>
Configuring them later just allows you to focus on loading your records as quickly and efficiently as possible. <br>

Finally, if you create a sharing rule before your data is loaded into an object, the platform must check every record that you insert during your data loading against that rule, and then adjust the object share table if necessary. <br>
This process does not take much time for each insert, but the aggregation of all of your inserts can slow your data loading noticeably. <br>
To avoid this drag on loading performance, you can **create your sharing rules after all the data has been loaded**. <br>

There are two options for doing this: <br>

* Create each rule and allow it to recalculate before creating the next rule.
* Use Defer Sharing Calculation to suspend the processing of sharing rules
  * create all of the rules at once
  * then recalculate all of the rules at once

The second option might be more efficient, but it might also require a very long time to recalculate all the rules. <br>
If you have limited ability to set aside maintenance windows for these activities, the first option might be more appropriate for your organization. <br>

**Configuring Record Access with the Defer Sharing Calculation Feature** <br>

By default, when you create or modify a sharing rule, a role or a group — or change who belongs to a group — the system updates the object share tables and the group membership tables immediately. <br>
If these sharing calculations take longer than you expect, they can throw off your planned loading schedule. <br>
With Defer Sharing Calculation, you can turn off these recalculations while you submit additional sharing changes, and then let them all execute together later. <br>
And if you test these submissions and calculations in a sandbox organization, you can better predict how long they will take in your production organization, allowing you to negotiate more reasonable maintenance windows with your customers. <br>

**Configuring Defer Sharing Calculation** <br>

* Contact Customer Support to enable Defer Sharing Calculation.
* Once the feature is enabled, users with `View Setup and Configuration` permission will see the **Defer Sharing Calculations** link in Setup.
* To see the **Suspend**, **Resume**, and **Recalculate** buttons on this page, users must also have the `Manage Sharing Calculation Deferral` permission. 
  * Creating a permission set allows you to easily assign this permission to all users who require access to these buttons.

**NOTE:** This permission also grants the users who receive it the `Manage Users`, `View Setup and Configuration`, and `Reset User Passwords and Unlock Users` permissions, so it is a powerful permission that should be restricted to a few senior administrators. <br>

**Using the Defer Sharing Calculation Feature** <br>

The controls on the Defer Sharing Calculations page allow you to: <br>

* View the current state of group membership and sharing calculations
* Suspend group membership calculations, which will also suspend sharing rule calculations, or suspend only sharing rule calculations
* Perform all of your planned changes to roles, groups, queues, and sharing rules quickly while calculations are suspended
* Resume the calculation of group membership or sharing rules

When you resume group membership and sharing calculations after making many changes in an organization with large data volumes, those calculations might take a long time to complete. <br>
Changes to group membership are calculated automatically when you resume the calculations, but changes to sharing rules are not. <br>
You can use the **Recalculate button** to ensure that all changes to sharing rules have taken effect. <br>
**Until you click this button, users might not have the access that you have specified in your sharing rules**, and they might continue to have access that you intended to remove. <br>

**NOTE:** When you suspend group membership calculations, the system must recalculate all sharing rules, even if you did not add, delete, or modify any sharing rules. This is because the changes that make to groups might affect some or all of the **Owned by members of** or **Share with** groups specified in your sharing rules. <br>

Remember that when group membership or sharing rule calculations are suspended, any administrators performing operations on roles, groups, queues, or sharing rules will discover that their changes have not taken effect. <br>
To develop good coordination between administrators — and realistic estimates of the maintenance windows you will need to make large scale changes to your sharing configuration — we recommend thoroughly testing deferred group membership and sharing calculations in a sandbox organization with the data volumes that you anticipate having in production. <br>

**When Not to Use Defer Sharing Calculation** <br>

Although using Defer Sharing Calculation is a best practice for organizations with large volumes of data, some customers might have so much data that attempting to recalculate all sharing changes at once is not feasible or takes an impractical amount of time. <br>
These customers might find that allowing sharing calculations to proceed normally while they configure and load data into their organizations provides the best overall throughput for their organization. <br>

### [Reporting Snapshots](https://help.salesforce.com/s/articleView?id=sf.data_about_analytic_snap.htm&type=5)
A reporting snapshot lets you report on historical data. <br>
Authorized users can save tabular or summary report results to fields on a custom object, then map those fields to corresponding fields on a target object. <br>
They can then schedule when to run the report to load the custom object's fields with the report's data. <br>
Reporting snapshots enable you to work with report data similarly to how you work with other records in Salesforce. <br>

<br>

After you set up a reporting snapshot, users can: <br>

* Create and run custom reports from the target object.
* Create dashboards from the source report.
* Define list views on the target object, if it's included on a custom object tab.

For example, a customer support manager could set up a reporting snapshot that reports on the open cases assigned to his or her team everyday at 5:00 PM, and store that data in a custom object to build a history on open cases from which he or she could spot trends via reports. Then the customer support manager could report on point-in-time or trend data stored in the custom object and use the report as a source for a dashboard component. <br>

**NOTE:** Reporting snapshots don't support row-level formula fields. <br>

[Prepare Reporting Snapshots](https://help.salesforce.com/s/articleView?id=data_setting_up_analytic_snap.htm&type=5&language=en_US)
To set up a reporting snapshot, you need a source report and a target object with fields to contain the data in the source report. <br>

[Define a Reporting Snapshot](https://help.salesforce.com/s/articleView?id=data_defining_analytic_snap.htm&type=5&language=en_US)
After you create a source report, target object, and target object fields, you can define your reporting snapshot. <br>
You define a reporting snapshot by naming it and choosing the source report that will load report results into the target object you specify when the reporting snapshot runs. <br>

[Map Reporting Snapshot Fields](https://help.salesforce.com/s/articleView?id=data_mapping_analytic_snap.htm&type=5&language=en_US)
After you create a source report, target object, target object fields, and define your reporting snapshot, you can map the fields on your source report to the fields on your target object. <br>
You map source report fields to target object fields so that when the report runs, it automatically loads specific target object fields with data from specific source report fields. <br>

[Schedule and Run a Reporting Snapshot](https://help.salesforce.com/s/articleView?id=data_scheduling_analytic_snap.htm&type=5&language=en_US)
After you create a source report, target object, target object fields, define your reporting snapshot, and map its fields, you can schedule when it runs. <br>
You can schedule a reporting snapshot to run daily, weekly, or monthly so that data from the source report is loaded into the target object when you need it. <br>

[Manage Reporting Snapshots](https://help.salesforce.com/s/articleView?id=data_managing_analytic_snap.htm&type=5&language=en_US)
After you set up a reporting snapshot, you can view details about it and edit and delete it. <br>
From Setup, enter Reporting Snapshots in the Quick Find box, then select Reporting Snapshots to display the Reporting Snapshots page, which shows the list of reporting snapshots defined for your organization. <br>

[Troubleshoot Reporting Snapshots](https://help.salesforce.com/s/articleView?id=data_troubleshooting_snapshots.htm&type=5&language=en_US)
The Run History section of a reporting snapshot detail page displays if a reporting snapshot ran successfully or not. <br>
When a reporting snapshot fails during a scheduled run, the failure is noted in the Result column. <br>
To view the details of a run, click the date and time of the run in the Run Start Time column. <br>

### [Query Plan Tool](https://help.salesforce.com/s/articleView?id=000334796&type=1)
Use this tool to check the Query Plan for any SOQL queries that execute slowly. <br>
It will provide you with insight on the different plans and should you have some of the filters indexed, provide the cost of using the index compared to a full table scan. <br>

If the cost for the table scan is lower than the index, and the query is timing out, you will need to perform further analysis on using other filters to improve selectivity, or, if you have another selective filter in that query that is not indexed but is a candidate for one. <br>

**Determine if a filter is selective:** <br>

* Determine if it has an index.
* If the filter is on a standard field, it'll have an index if it is a
  * primary key (Id, Name, OwnerId)
  * a foreign key (CreatedById, LastModifiedById, lookup, master-detail relationship)
  * an audit field (CreatedDate, SystemModstamp)
* Custom fields will have an index if they have been marked as **Unique** or **External Id**
* If the filter doesn't have an index, it won't be considered for optimization.
* If the filter has an index, determine how many records it would return:
  * For a standard index, the threshold is 30 percent of the first million targeted records and 15 percent of all records after that first million. 
  * In addition, the selectivity threshold for a standard index maxes out at **1 million total targeted records**
    * which you could reach only if you had more than 5.6 million total records.
  * For a custom index, the selectivity threshold is 10 percent of the first million targeted records and 5 percent all records after that first million.
  * In addition, the selectivity threshold for a custom index maxes out at 333,333 targeted records
    * which you could reach only if you had more than 5.6 million records.
* If the filter exceeds the threshold, it won't be considered for optimization.
* If the filter doesn't exceed the threshold, this filter IS selective, and the query optimizer will consider it for optimization.

Check out the [Database Query & Search Optimization Cheat Sheet](http://resources.docs.salesforce.com/194/0/en-us/sfdc/pdf/salesforce_query_search_optimization_developer_cheatsheet.pdf)

## Data Governance (10%)
Given a customer scenario
* recommend an approach for designing a GDPR compliant data model
* discuss the various options to identify, classify and protect personal and sensitive information 
* compare and contrast various approaches and considerations for designing and implementing an enterprise data governance program 

### [Data Governance Plan](https://a.sfdcstatic.com/content/dam/www/ocms-backup/assets/pdf/misc/data_Governance_Stewardship_ebook.pdf)
The following elements / sections should be included in your Data Governance Plan: <br>

* Data Definitions
* Data Quality Standards
* Quality Control Process
* Roles & Ownership
* Security & Permission

### Governance Models
* Top-down
  * Management defines the governance based on their vision
* Bottom-up
  * End users define governance based on their work practice 
* Silo-in
  * Multiple groups collectively work out and agree on a governance 
* Center-out
  * Experts define a governance 

### [Privacy Cente](https://help.salesforce.com/s/articleView?id=sf.privacy_center.htm&type=5)
Manage components of data privacy law such as the General Data Protection Regulation (GDPR), and fulfill customer requests on how their personally identifiable information (PII) is stored, deleted, and transferred. <br>

<br>

Privacy Center helps you maintain customer privacy through every stage of the data lifecycle. <br>
Create policies that satisfy your customer’s right to be forgotten with the Right to Be Forgotten Policies feature. <br>
Or retain and de-identify a customer’s personally identifiable information (PII) using the Retention Policies feature. <br>
Portability Policies compile and deliver PII to customers in response to data subject access requests. <br>

More information in the [Whitepaper](https://resources.docs.salesforce.com/rel1/doc/en-us/static/pdf/privacy_center_whitepaper.pdf) <br>

### [Custom Field Encryption](https://developer.salesforce.com/docs/atlas.en-us.securityImplGuide.meta/securityImplGuide/fields_about_encrypted_fields.htm)
Restrict other Salesforce users from seeing custom text fields that you want to keep private. <br>
Only users with the `View Encrypted Data` permission can see data in encrypted custom text fields. <br>

<br>

**Implementation Notes** <br>

* Encrypted fields are encrypted with **128-bit master keys** and use the **Advanced Encryption Standard (AES) algorithm**
  * You can archive, delete, and import your master encryption key
  * To enable master encryption key management, contact Salesforce
* You can use encrypted fields in email templates but the value is always masked 
  * regardless of whether you have the `View Encrypted Data` permission.
* If you have the `View Encrypted Data` permission and you grant login access to another user
  * the user can see encrypted fields in plain text
* Only users with the `View Encrypted Data` permission can clone the value of an encrypted field when cloning that record
* Only the `<apex:outputField>` component supports presenting encrypted fields in Visualforce pages


**Restrictions** <br>

Encrypted text fields: <br>

* Can’t be unique, have an external ID, or have default values
* Aren’t available for mapping leads to other objects
* Are **limited to 175 characters** because of the encryption algorithm
* Aren’t available for use in filters such as list views, reports, roll-up summary fields, and rule filters
* Can’t be used to define report criteria, but they can be included in report results
* Aren’t searchable, but they can be included in search results
* Aren’t available for Connect Offline, Salesforce for Outlook, lead conversion, workflow rule criteria or formulas, formula fields, outbound messages, default values, and Web-to-Lead and Web-to-Case forms


**Best Practices** <br>

* Encrypted fields are editable regardless of whether the user has the View Encrypted Data permission 
  * Use validation rules, field-level security settings, or page layout settings to prevent users from editing encrypted fields
* You can still validate the values of encrypted fields using validation rules or Apex 
  * Both work regardless of whether the user has the `View Encrypted Data` permission
* To view encrypted data unmasked in the debug log, the user must also have the `View Encrypted Data` in the service that Apex requests originate from 
  * These requests can include Apex Web services, triggers, workflows, inline Visualforce pages (a page embedded in a page layout), and Visualforce email templates
* Existing custom fields can’t be converted into encrypted fields nor can encrypted fields be converted into another data type 
  * To encrypt the values of an existing (unencrypted) field, export the data, create an encrypted custom field to store that data, and import that data into the new encrypted field
* Mask Type isn’t an input mask that ensures the data matches the Mask Type
  * Use validation rules to ensure that the data entered matches the mask type selected
* Use encrypted custom fields only when government regulations require it because they involve more processing and have search-related limitations

### Key Principles of GDPR
**Legitimate Purpose** <br>
* Personal data can only be collected for legitimate purpose 
* Data used must be limited, explicit and for specific purpose

**Data Deletion** <br>
* Personal Data must be deleted if it is no longer required for the original purpose

**Secure** <br>
* Data must kept secure
* Measures must be in place to prevent
  * unauthorized access
  * disclosure
  * loss
  * destruction
  * alteration

**Consent** <br>
* Consent to collect and store personal data must be 
  * freely given
  * specific
  * informed
  * unambiguous
* It can be revoked

**Accurate** <br>
* Personal data must be accurate and kept up to date

**Accountable** <br>
* Data is handled accordingly GDPR principles
  * demonstrated compliance via record keeping and reporting

### [Data Stewardship](https://admin.salesforce.com/blog/2019/why-effective-data-stewardship-gives-you-a-competitive-edge)
Some of the key areas which would be important to analyze for optimizing a data stewardship engagement include the following: <br>

* **Redundant metadata** 
  * Any redundant metadata can have an adverse impact on the overall quality of data 
    * because it can cause inconsistencies related to data entry
  * Some users might enter the data in one set of fields while other users might enter it in another
    * leading to inconsistent data quality and seemingly incomplete records
* **Sharing model** 
  * When the organization-wide default sharing setting is 'Private', users are more likely to create duplicate records
  * If a user can't see a record that is owned by another user, then they are likely to create a duplicate version of it 
    * under the assumption that the record does not exist in Salesforce
  * An organization may consider changing the setting of an object to 'Public Read Only'
    * if it is not essential to keep records owned by others hidden from users
* **Required fields and validation rules**
  * The fields that are required for data entry and the data that should be validated prior to saving the records are necessary to consider for evaluating a data stewardship engagement

### [User Management Settings](https://help.salesforce.com/s/articleView?id=sf.users_mgmt_settings.htm&type=5)
Manage org-wide user settings to improve user experience and increase org security. <br>

* Enable User Self-Deactivation
  *  Let external Experience Cloud site and Chatter users deactivate their own accounts 
  * The results are identical to an administrator-initiated deactivation
* Personal User Information Policies and Timelines
  * To protect your external users’ data, Salesforce introduced security settings that let you control personal user information visibility
  * Use this topic as a starting point to understand all the security improvements and updates 
    * including timelines for enforcement and how to prepare for the changes
* Manage Personal User Information Visibility for External Users
  * Protect your external users’ data by concealing personal information fields from other external users 
  * To meet your business’s security needs, you can modify which user fields are classified as personal information and hidden
* Hide Personal User Information from External Users
   * Orgs with Experience Cloud sites or legacy portals can enable the Hide Personal Information setting 
    * to conceal certain fields when users with external profiles search user records
* Let Users Scramble Their User Data
  * When users no longer want their personal data recognized in Salesforce, you can permanently scramble the data 
    * with the **System.UserManagement.obfuscateUser** Apex method
  * However, when you invoke the method for a user, the data becomes anonymous, and you can never recover it 
  * As an extra precaution, you can’t use the method until you enable Scramble Specific Users’ Data for your org
* Enable Contactless Users
  * Enable the contactless user feature for your org to reduce the overhead of managing customers and partners 
    * by creating users without contact information
  * Without contacts, you don’t have to worry about keeping user and contact records in sync 
* Enable Enhanced Profile List Views
  * Enhanced lists give you the ability to quickly view, customize, and edit list data to speed up your daily productivity
* Enable Enhanced Permission Set Component Views
  * When you have large numbers of Apex class assignments for permission sets
    * enable a paginated result set, standard filtering, and sorting to work more efficiently
* Enable the Enhanced Profile User Interface
  * The enhanced profile user interface provides a streamlined experience for managing profiles 
  * You can easily navigate, search, and modify settings for a profile 
  * Your Salesforce org can use one profile user interface at a time
* Limit Profile Details to Required Users
  * Limit users from viewing any profile names other than their own
* Restrict Permissions Cloning in Profiles
  * Use the Restricted Profile Cloning option to ensure that **only permissions accessible to your org** are enabled when you clone profiles
  * If you don't enable this setting, all permissions currently enabled in the source profile are also enabled for the cloned profile
* Enable the Email Domain Allowlist
  * Enable the Email Domain Allowlist Setup page, where you can restrict the email domains allowed in a user’s Email field

**Mask personal user information** <br>
The `Enhanced Personal Information Management` setting can be enabled on the `User Management Settings` page in Setup to block **view** and **edit** access to 30 fields that are considered personal information. <br>
To customize the user fields that are concealed, they can be added or removed from the `PersonalInfo_EPIM` field set on the User object. <br>
Custom user fields and all standard user fields are supported. <br>


#### [Which Standard Fields Can I Encrypt?](https://help.salesforce.com/s/articleView?id=sf.security_pe_standard_fields.htm&type=5)
There are actually a lot of encryptable standard field among multiple objects. I'll list only field from **Account**, **Contact** and **Lead** object here. <br>

**Account** <br>
* Account Name
* Account Site
* Billing Address (encrypts Billing Street and Billing City)
* Description
* Fax
* Phone
* Shipping Address (encrypts Shipping Street and Shipping City)
* Website

**Contact** <br>
* Assistant
* Assistant Phone
* Description
* Email
* Fax
* Home Phone
* Mailing Address (encrypts Mailing Street and Mailing City)
* Mobile
* Name (encrypts First Name, Middle Name, and Last Name)
* Other Address (encrypts Other Street and Other City)
* Other Phone
* Phone
* Title

**Lead** <br>
* Address (Encrypts Street and City)
* Company
* Description
* Email
* Fax
* Mobile
* Name (Encrypts First Name, Middle Name, and Last Name)
* Phone
* Title
* Website

### [Einstein Data Detect](https://help.salesforce.com/s/articleView?id=release-notes.rn_security_einstein_data_detect_ga.htm&type=5&release=234)
Sometimes users make data entry mistakes, or customers mistakenly provide personally identifiable information (PII). <br>
When sensitive data ends up where it doesn’t belong, it’s hard to meet data privacy and security obligations. <br>
Einstein Data Detect helps you quickly find sensitive data such as credit card numbers and social security numbers no matter where it’s entered in your org. <br>
You can then apply data classification categories right from the UI and adjust privacy and security controls as necessary. <br>

* **Where:** 
  * This change applies to Lightning Experience in Enterprise, Performance, and Unlimited Editions editions
* **Who:** 
  * The Einstein Data Detect managed package is available to customers who have purchased the **Salesforce Shield add-on subscription**
* **Why:** 
  * Einstein Data Detect helps you find misplaced data in fields, attachments, and documents
  * Built with platform-native technology, you can:
    * Determine the sensitivity of a field based on its contents and categorize it accurately
    * Categorize data classification metadata in bulk without having to store your data in a third-party service
    * Identify which other Salesforce security and privacy products can help you meet your security and privacy requirements

For example, review detected fields and decide which to encrypt with Shield Platform Encryption or mask with Data Mask. <br>
Pair your results with Privacy Center to automatically create Deletion, Masking, and Retention templates for specific categories of data. <br>
And if you know that specific fields contain PII, you can create Transaction Security policies that place guardrails on reports that contain those fields. <br>

### Options to protect data
**Encryption** <br>
* Shield Platform Encryption for
  * fields
  * files
  * attachments
  * and the rest
* Classic Encryption for
  * encrypt and mask custom fields

**Salesforce Data Mask** <br>
* Mask sensitive data
  * in **Full or Partial Sandboxes**

**Event Monitoring** <br>
* **monitor** and **prevent** access to sensitive data

**Sharing Model** <br>
* ensure users only have access to appropriate records

**Field Level Security** <br>
* ensure users only have access to appropriate fields on a record

**Session Security Settings** <br>
* used to secure areas in setup that are considered sensitive operations
  * like accessing reports
  * managing encryption keys
  * authentication

### [Data Retention](https://www.salesforce.org/blog/ask-an-architect-3-recommended-steps-to-building-a-data-retention-policy/)
A data retention policy is a statement of how long data will be stored by the organization including how the data is deleted or otherwise treated. <br>

Data needs to be cataloged and should list the

* type of data
* business owner
* purpose
* how it is used
* classification level


It defines

* how long the data is required
* when it will be 
  * deleted
  * anonymized
  * archived

### [Shield Encryption](https://trailhead.salesforce.com/en/content/learn/modules/spe_admins/spe_admins_get_started)
Salesforce offers you two ways to encrypt data. <br>
Classic encryption is included in the base price of your Salesforce license. <br>
With classic encryption, you can protect a special type of custom text field that you create for data you want to encrypt. <br>
The custom field is protected with industry-standard 128-bit Advanced Encryption Standard (AES) keys. <br>

<br>

Shield Platform Encryption is available for free in Developer Edition orgs. <br>
All other editions require you to purchase a license. <br>
With Shield Platform Encryption, you can encrypt all kinds of confidential and sensitive data at rest on the Salesforce Platform. <br>
“At rest” means any data that’s inactive or stored in 
* files
* spreadsheets
* standard and custom fields
* and databases and data warehouses

The data is encrypted with a stronger **256-bit AES key**. <br> 
Subscribers can manage access to their data with a wider range of keys and permissions. <br>
Shield Platform Encryption allows you to search for encrypted data in databases. <br>

<br>

Shield Platform Encryption gives customers an encryption advantage because it allows you to 
* prove compliance with regulatory and industry requirements
* show that you meet contractual obligations for securing private data in the cloud

### [Enhanced Transaction Security](https://help.salesforce.com/s/articleView?id=sf.enhanced_transaction_security_policy_types.htm&type=5)
Enhanced Transaction Security is a framework that intercepts real-time events and applies appropriate actions to monitor and control user activity. <br>
Each transaction security policy has conditions that evaluate events and the real-time actions that are triggered after those conditions are met. <br>
The actions are 
* Block 
* Multi-Factor Authentication
* Notifications

**NOTE:** Requires **Salesforce Shield** or **Salesforce Event Monitoring** add-on subscriptions.

## Data Migration (15%)
* Given a customer scenario, recommend appropriate techniques and methods for ensuring high data quality at load time. 
* Compare and contrast various techniques for improving performance when migrating large data volumes into Salesforce.
* Compare and contrast various techniques and considerations for exporting data from Salesforce.

### [Granular Locking](https://developer.salesforce.com/docs/atlas.en-us.216.0.draes.meta/draes/draes_tools_granular_locking.htm)
By default, the Lightning Platform platform **locks the entire group membership table** to protect data integrity when Salesforce makes changes to roles and groups. <br>
This locking makes it **impossible to process group changes in multiple threads** to increase throughput on updates. <br>
When the granular locking feature is enabled, the system employs **additional logic to allow multiple updates to proceed simultaneously** if there is **no hierarchical or other relationship between the roles or groups** involved in the updates. <br>
Administrators can adjust their maintenance processes and integration code to take advantage of this limited concurrency to process large-scale updates faster, all while still avoiding locking errors. <br>

The key advantages of granular locking are that:

* Groups that are in separate hierarchies are now able to be manipulated concurrently.
* Public groups and roles that do not include territories are no longer blocked by territory operations.
* Users can be added concurrently to territories and public groups.
* User provisioning can now occur in parallel.
  * Portal user creation requires locks only if new portal roles are being created.
  * Provisioning new portal users in existing accounts occurs concurrently.
* A single-long running process, such as a role delete, blocks only a small subset of operations.

### Improve Loading Performance 
The following steps can be taken prior to loading the data in order to improve performance: <br>

* Set the organization-wide default sharing setting to `Public Read/Write` 
  * to make sure that Salesforce does not use or maintain an object share table
* Since workflow rules, validation rules, and Apex triggers can slow down processing, they should be disabled prior to loading the data
* Sharing rules should be created after loading the data
  * they can affect the performance of the data load
* Complex object relationships (lookup and master-detail relationships) should be defined after loading the data 
  * they can also affect the performance of the data load 
  * If more lookups are defined on an object, the system has to perform more checks during data loading

### [Standard Account Matching Rule](https://help.salesforce.com/s/articleView?id=sf.matching_rules_standard_account_rule.htm&type=5)
The standard account matching rule identifies duplicate accounts using 
* match keys
* a matching equation
* and matching criteria. 

It’s activated by default. <br>
<br>

**Match Keys** <br>
Match keys speed up matching by narrowing the potential matches to the most likely duplicates before the rule applies the comprehensive matching equation. <br>

|Match Key Notation|Match Key Value Examples|
|:-----------------|:-----------------------|
|Company (2,6) City (\_, 6)|Account: Orange Sporting Company = orangesporti <br /> City: San Francisco = sanfra <br /> Key: orangesportisanfra|

**Matchingh Equation** <br>
`(Account Name AND Billing Street) OR (Account Name AND City AND State)`

**Matching Criteria** <br>

|Field|Matching Algorithms|Scoring Method|Threshold|Blank Fields|Special Handling|
|:----|:------------------|:-------------|:--------|:-----------|:---------------|
|Account Name|Acronym <br /> Edit Distance <br /> Exact|Maximum|70|Don't match|Removes words such as “Inc” and “Corp” before comparing fields. Company names are normalized.|

### [Sequencing Load Operations](https://developer.salesforce.com/blogs/engineering/2013/06/extreme-force-com-data-loading-part-4-sequencing-load-operations)
tbd

### [Performance Tests](https://help.salesforce.com/s/articleView?id=000335652&type=1)
tbd

### [Create Audit Fields Permission](https://help.salesforce.com/s/articleView?id=000334139&type=1)
tbd
