# Salesforce Sharing and Visibility Architect Notes
Notes I'm taking during my preparation for the [Salesforce Sharing & Visibility Architect](https://trailhead.salesforce.com/en/credentials/sharingandvisibilityarchitect) exam. <br> 
<br>
Resources used for my prep-works: 
* [Exam Guide](https://trailhead.salesforce.com/help?article=Salesforce-Certified-Sharing-and-Visibility-Architect-Exam-Guide)
* [Trailmix](https://trailhead.salesforce.com/users/00550000006yDdKAAU/trailmixes/architect-sharing-and-visibility)
* [DecodeSFCertifications YouTube Channel](https://youtu.be/NwoI9BfZljs)
* [Udemy Course: Salesforce Certified Sharing and Visibility Designer](https://www.udemy.com/share/1036t63@b4Anj0BdcesdfPxXWVMcKxbSPJTSXz6H9-QL40JAcIUehvKavo0zPDjafPl9hcxIWg==/)
* [FocusOnForce Sharing & Visibility Architect Certification Practice Exams](https://focusonforce.com/courses/sharing-and-visibility-designer-practice-exams/)

## Declarative Sharing (76%)
Given a particular customer scenario

* describe the appropriate use and limitations of relevant object and field level security settings 
  * needed to allow and limit users access to different types of information.
* apply the relevant settings required for all the declarative platform security features 
  * that would ensure proper data access to relevant users.
* demonstrate your ability to properly evaluate the use case for and implement teams to ensure the proper visibility and collaboration requirements are implemented.
* Demonstrate how views and folders can be segmented for different groups using out of box security features 
  * such as groups or roles, in an effective manner 
  * while keeping in mind security considerations and how these differ from record level security considerations.
* Given a particular customer's organization hierarchy describe the impact of role hierarchy on record sharing.
* Given a scenario that involves external users, describe how the security and sharing setup can be utilized to properly enforce record visibility for different types of community users. 
  * Specifically: Internal, Customer Community, Customer Community Plus, Partner Community.
* have awareness of how Enterprise Territory Management can (or cannot be applied) to resolve more complex security requirements.
* Given a customer's particular data storage and data residency requirements, have awareness of solution options in the marketplace 
  * that properly leverages declarative and programmatic security features of Salesforce.
* Given an Architect's design and configuration of the sharing and security model, describe the methods of validating the sharing and visibility.
* Given a scenario that involves files sharing, describe how files are shared and secured in Salesforce and what are the different options to storing file securely in Salesforce.

### [View All and Modify All Permissions](https://help.salesforce.com/s/articleView?id=sf.users_profiles_view_all_mod_all.htm&type=5)
The **View All** and **Modify All** permissions ignore sharing rules and settings, allowing administrators to grant access to records associated with a given object across the organization. <br>
**View All** and **Modify All** can be better alternatives to the **View All Data** and **Modify All Data** permissions.  <br>

|Permissions|Used for|Users whoe need them|
|:----------|:-------|:-------------------|
|View All <br /> Modify All|Delegation of object permissions.|Delegated administrators who manage records for specific objects|
|View All Data <br /> Modify All Data|Managing all data in an organization; for example, data cleansing, deduplication, mass deletion, mass transferring, and managing record approvals. <br /> Users with View All Data (or Modify All Data) permission can view (or modify) all apps and data, **even if the apps and data are not shared with them**.|Administrators of an entire organization|
|View All Users|Viewing all users in the organization. Grants Read access to all users, so that you can see their user record details, see them in searches, list views, and so on.|Users who need to see all users in the organization. Useful if the organization-wide default for the user object is Private. Administrators with the Manage Users permission are automatically granted the View All Users permission.|
|View All Lookup Record Names|Viewing record names in all lookup and system fields.|Administrators and users who need to see all information about a record, such as its related records and the Owner, Created By, and Last Modified By fields. This permission only applies to lookup record names in list views and record detail pages.|

**NOTE:** If a user requires access only to metadata for deployments, you can enable the Modify Metadata Through Metadata API Functions permission. This permission gives such users the access they need for deployments without providing access to org data. For details, see “Modify Metadata Through Metadata API Functions Permission” in Salesforce Help. <br>

**View All** and **Modify All** are not available for 
* ideas
* price books
* article types
* products

**View All** and **Modify All** allow for delegation of object permissions only. <br>
To delegate user administration and custom object administration duties, define **delegated administrators**. <br>

**View All** for a given object doesn't automatically give access to its detail objects. <br>
In this scenario, users must have **Read** access granted via sharing to see any associated child records to the parent record. <br>

**View All Users** is available if your organization has **User Sharing**, which controls user visibility in the organization.

### [Libraries](https://help.salesforce.com/s/articleView?id=sf.collab_admin_content_libraries.htm&type=5)
Libraries can be used to manage and organize files and the permissions and access users have to the files. <br>
Files types cannot be restricted by the library. <br>
Members can include individual content users or public groups but not roles. <br>

#### [Library Tagging Rules](https://help.salesforce.com/s/articleView?id=sf.content_tagging_rules.htm&type=5)
Tagging rules have only three options:
* **Restricted Tagging** 
  * restricts the user from selecting tag other than the predefined tags 
* **Guide Tagging** 
  * suggests tags to users 
* **Open Tagging** 
  * allows users to enter any tags for content

#### [Library Permissions](https://help.salesforce.com/s/articleView?id=sf.content_workspace_perm_add.htm&type=5)
There are three pre-built library permissions that can be assigned to library members:
* **Viewers** can 
  * view
  * add comments
  * rate
  * deliver
  * attach
  * share content
* **Authors** can 
  * view
  * add comments
  * rate
  * deliver
  * attach
  * publish
  * archive
  * share content
* **Library Administrators** can 
  * edit library details
  * edit library membership

### [File Visibility](https://help.salesforce.com/s/articleView?id=sf.collab_files_settings_perms.htm&type=5)
tbd

### [Change a Record’s Owner](https://help.salesforce.com/s/articleView?id=sf.account_owner.htm&type=5)
**Opportunity Owner** can be changed by:

* the opportunity owner
* a user above the owner in the role hierarchy
* a system administrator
* a user with the `Transfer Record` permission

**NOTE:** Opportunity team members can be transferred with the opportunity by selecting an option. <br>

### [Mass Reassign Opportunity Teams](https://help.salesforce.com/s/articleView?id=sf.opportunity_team_members_adding.htm&type=5)
The `Mass Reassign Opportunity Teams` wizard is a tool that can be accessed in Setup or the home page of the Opportunities tab. <br>
It can be used to add, remove, or replace team members on multiple opportunity records at the same time. <br>
`Team Selling` must be enabled on the `Opportunity Team Settings` page in Setup to use opportunity teams and this tool. <br>

### [Restriction Rules](https://help.salesforce.com/s/articleView?id=sf.security_restriction_rule.htm&type=5)
tbd

### [Additional Sharing Settings](https://help.salesforce.com/s/articleView?id=sf.other_sharing_settings.htm&type=5)
The `Sharing Settings` page in Setup can be used to manage various additional sharing settings besides configuring organization-wide defaults and sharing rules. <br>

The `Standard Report Visibility` checkbox can be disabled to ensure that users cannot view reports based on standard report types that can expose the data of users to whom they don’t have access. <br>
The `Manual User Record Sharing` checkbox can be enabled to allow users to share their records with others. <br>
The `Require permission to view record names in lookup fields` setting can be enabled to ensure that users have **Read** access to the records in lookup fields or the `View All Lookup Record Names` permission to view the data in the fields. <br>
This applies to user lookup fields such as `Account Owner`. <br>

### [Organization-Wide Default Access Settings](https://help.salesforce.com/s/articleView?id=sf.sharing_model_fields.htm&type=5)
tbd

### [Site User Visibility](https://focusonforce.com/exams/declarative-sharing-64-part-1-sharing-and-visibility-designer/)
The `Site User Visibility` checkbox can be deselected on the Sharing Settings page to ensure that external users are not able to see each other. <br>

This setting ensures that users **cannot**

* search for other users 
* find them in the site's People tab
* add them to a group
* share a file or record with them

### [Bypass encryption field field-level security](http://dreamforce.vidyard.com/watch/BWyoELghogljON4KqXElvw)
There are certain permissions that would allow a user to bypass the field-level security protections that have been set for a custom encrypted text field. <br>
These are `Customize Application` and `Author Apex`, which would give a user the ability to modify field-level security permissions and view the value of the field. <br>

