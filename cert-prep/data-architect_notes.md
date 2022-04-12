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

**+ 120MB per License:**\*
* Performance
* Unlimited

\* *20 MB for Lightning Platform Starter user licenses* <br>


