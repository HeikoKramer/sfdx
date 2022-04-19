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
tbd

### [Metadata Types](https://developer.salesforce.com/docs/atlas.en-us.api_meta.meta/api_meta/meta_types_list.htm)
tbd

### [Custom Metadata Types](https://help.salesforce.com/s/articleView?id=sf.custommetadatatypes_overview.htm&type=5)
**Overall:**
* CMT can be deployed using
  * managed packages 
  * unmanaged packages
  * managed package extensions
* mappings can be used to create associations between objects
* Metadata API is used to 
  * create
  * edit
  * delete custom metadata records
* Apex can create and edit custom metadata records, but **not delete**
* CMT values can be used in formula fields

#### [What are Custom Metadata Types?](https://help.salesforce.com/s/articleView?id=custommetadatatypes_about.htm&type=5&language=en_US)
Custom metadata is customizable, deployable, packageable, and upgradeable application metadata. First, you create a custom metadata type, which defines the form of the application metadata. Then you build reusable functionality that determines the behavior based on metadata of that type. <br>

### [Custom Settings](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_customsettings.htm)
tbd
