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
|View All Data <br /> Modify All Data|Managing all data in an organization; for example, data cleansing, deduplication, mass deletion, mass transferring, and managing record approvals. <br /> <br /> Users with View All Data (or Modify All Data) permission can view (or modify) all apps and data, **even if the apps and data are not shared with them**.|Administrators of an entire organization|
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

Users must be assigned library permissions to access files in the library. <br>
Users can be assigned different permissions for each library they are a member of. <br>
Standard library permissions can be modified if the standard library permissions (Author, Viewer, and Library Administrator) do not contain the permissions required. <br>
However, this modification can only be configured in Salesforce Classic (navigate to Content Permissions in Setup). <br>

### [File Visibility](https://help.salesforce.com/s/articleView?id=sf.collab_files_settings_perms.htm&type=5)
Files in Salesforce can be private, privately shared, or visible to the entire company. <br>
Learn how to identify a file’s sharing settings and how to change them. <br>

This table describes file sharing settings that depend on how the file is shared. <br>
The sharing setting appear on a file's detail page and on the **Shared With** list on a file detail page. <br>

|Sharing Setting|Definition|When Does a File Have This Setting?|
|:--------------|:---------|:----------------------------------|
|Private|The file is private. It hasn't been shared with anyone else besides the owner. The file owner and users with Modify All Data permission can find and view this file. However, if the file is in a private library, only the file owner has access to it.|A file is private when you: <br> • Upload it in Files home <br /> • Publish it to your private library <br /> • Stop sharing it with everyone (Make Private) <br /> • Delete posts that include the file and the file isn't shared anywhere else|
|Privately Shared|The file has been shared only with specific people, groups, or via link. It's not available to all users in your company. Only the file owner, users with Modify All Data or View all Data permission, and specific file viewers can find and view this file. External users see files posted to records they have access to, unless the record post was marked **Internal Only**.|A file is privately shared when it's: <br /> • Shared only with specific people or a private group <br /> • Posted to a private group <br /> • Shared via link <br /> • Posted to a feed on a record <br /> • Published to a shared library|
|Your Company|All users in your company can find and view this file.|A file is shared with your company when it's posted: <br /> • To a feed that all users can see <br /> • To a profile <br /> • To a record <br /> • To a public group|

<br>

This table describes which actions you can perform on a file depending on your file permissions: <br>

|Action|File Owner|File Collaborator|File Viewer|
|:-----|:---------|:----------------|:----------|
|View or Preview|Yes|Yes|Yes|
|Download|Yes|Yes|Yes|
|Schare|Yes|Yes|Yes|
|Attach a File to a Post|Yes|Yes|Yes|
|Upload new version|Yes|Yes|No|
|Edit Deitails|Yes|Yes|No|
|Change Permission|Yes|Yes|No|
|Make a File Private|Yes|No|No|
|Restrict Access|Yes|No|No|
|Delete|Yes|No|No|

<br>

**NOTE:** <br>

* No Access means that only the people in your company with whom this file is shared can find or view the file.
  * If the file is shared with a private group, only members of the group can find or view the file.
* Users with `Modify All Data` permission have built-in access to files that they don’t own. 
  * What they can do with files that they don't own: 
    * view
    * preview
    * download
    * share
    * attach
    * make private
    * restrict access to
    * edit
    * upload new versions of
    * delete
  * If the file is in a private library, then only the file owner has access to it.
* Users with `View All Data` permission can view and preview files that they don't own. 
  * However, if the file is in a private library, then only the file owner has access to it.
* Groups (including group members) and records have viewer permission for files posted to their feeds.
* Permissions for files shared with libraries depend on the library.

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
Restriction rules let you enhance your security by allowing certain users to access only specified records. <br>
They prevent users from accessing records that can contain sensitive data or information that isn’t essential to their work. <br>
Restriction rules filter the records that a user has access to so that they can access only the records that match the criteria you specify. <br>

Restriction rules are available for 
* custom objects
* external objects
* contracts
* tasks
* events

You can create up to two active restriction rules per object in Enterprise and Developer editions and up to five active restriction rules per object in Performance and Unlimited editions. <br>

Restriction rules are applied to the following Salesforce features:
* List Views
* Lookups
* Related Lists
* Reports
* Search
* SOQL
* SOSL

### [Additional Sharing Settings](https://help.salesforce.com/s/articleView?id=sf.other_sharing_settings.htm&type=5)
The `Sharing Settings` page in Setup can be used to manage various additional sharing settings besides configuring organization-wide defaults and sharing rules. <br>

The `Standard Report Visibility` checkbox can be disabled to ensure that users cannot view reports based on standard report types that can expose the data of users to whom they don’t have access. <br>
The `Manual User Record Sharing` checkbox can be enabled to allow users to share their records with others. <br>
The `Require permission to view record names in lookup fields` setting can be enabled to ensure that users have **Read** access to the records in lookup fields or the `View All Lookup Record Names` permission to view the data in the fields. <br>
This applies to user lookup fields such as `Account Owner`. <br>

The `Portal User Visibility` setting can be enabled to allow users in the same customer or partner account to see each other, regardless of the organization-wide defaults. <br>
The `Grant site users access to related cases` setting can be deselected to restrict customers access to cases. <br>
This approach can be used if access to cases needs to be controlled by using manual sharing or Apex managed sharing. <br>

### [Organization-Wide Default Access Settings](https://help.salesforce.com/s/articleView?id=sf.sharing_model_fields.htm&type=5)
For most objects, you can assign default access to 
* Controlled by Parent
* Private
* Public Read Only
* Public Read/Write 

Other access levels are available for only specific objects, like 
* Public Full Access 
* View Only

|Field|Description|
|:----|:----------|
|Controlled by Parent|A user can perform an action (such as view, edit, or delete) on a contact or order based on whether he or she can perform that same action on the record associated with it. For example, if a contact is associated with the Acme account, then a user can only edit that contact if he or she can also edit the Acme account.|
|Private|Only the record owner, and users above that role in the hierarchy, can view, edit, and report on those records. For example, if Tom is the owner of an account, and he’s assigned to the role of Western Sales, reporting to Carol (who is in the role of VP of Western Region Sales), then Carol can also view, edit, and report on Tom’s accounts.|
|Public Read Only|All users can view and report on records but not edit them. Only the owner, and users above that role in the hierarchy, can edit those records. For example, Sara is the owner of ABC Corp. Sara is also in the role Western Sales, reporting to Carol, who is in the role of VP of Western Region Sales. Sara and Carol have full read/write access to ABC Corp. Tom (another Western Sales Rep) can also view and report on ABC Corp, but can’t edit it.|
|Public Read/Write|All users can view, edit, and report on all records. For example, if Tom is the owner of Trident Inc., all other users can view, edit, and report on the Trident account. However, only Tom can alter the sharing settings or delete the Trident account.|
|Public Read/Write/Transfer|All users can view, edit, transfer, and report on all records. **Only available for cases or leads**. For example, if Alice is the owner of ACME case number 100, all other users can view, edit, transfer ownership, and report on that case. But only Alice can delete or change the sharing on case 100.|
|Public Full Access|All users can view, edit, transfer, delete, and report on all records. **Only available for campaigns**. For example, if Ben is the owner of a campaign, all other users can view, edit, transfer, or delete that campaign.|

#### Personal Calendar Access Levels

|Field|Description|
|:----|:----------|
|Hide Details|Others can see whether the user is available at given times, but can’t see any other information about the nature of events in the user’s calendar.|
|Hide Details and Add Events|In addition to the sharing levels set by Hide Details, users can insert events in other users’ calendars.|
|Show Details|Users can see detailed information about events in other users’ calendars.|
|Show Details and Add Events|In addition to the sharing levels set by Show Details, users can insert events in other users’ calendars.|
|Full Access|Users can see detailed information about events in other users’ calendars, insert events in other users’ calendars, and edit existing events in other users’ calendars.|

**NOTE:** Regardless of the organization-wide defaults that have been set for calendars, all users can invite all other users to events.

#### Price Book Access Levels

|Field|Description|
|:----|:----------|
|Use|All users can view price books and add them to opportunities. Users can add any product within that price book to an opportunity.|
|View Only|All users can view and report on price books but only users with the “Edit” permission on opportunities or users that have been manually granted use access to the price book can add them to opportunities.|
|No Access|Users can’t see price books or add them to opportunities. Use this access level in your organization-wide default if you want only selected users to access selected price books. Then, manually share the appropriate price books with the appropriate users.|

#### Activity Access Levels

|Field|Description|
|:----|:----------|
|Private|Only the activity owner, and users above the activity owner in the role hierarchy, can edit and delete the activity; users with read access to the record to which the activity is associated can view and report on the activity.|
|Controlled by Parent|A user can perform an action (such as view, edit, transfer, and delete) on an activity based on whether he or she can perform that same action on the records associated with the activity. For example, if a task is associated with the Acme account and the John Smith contact, then a user can only edit that task if he or she can also edit the Acme account and the John Smith record.|

#### User Access Levels

|Field|Description|
|:----|:----------|
|Private|All users have read access to their own user record and those below them in the role hierarchy.|
|Public Read Only|All users have read access on one another. You can see all users’ detail pages. You can also see all users in lookups, list views, ownership changes, user operations, and search.|

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

### [Built-in Sharing Behavior](https://help.salesforce.com/s/articleView?id=sf.sharing_across_objects.htm&type=5)
Salesforce provides implicit sharing between accounts and child records (opportunities, cases, and contacts), and for various groups of site and portal users. <br>
Built-in sharing behaviors apply only to standard relationships. <br>

Sharing between **accounts and child records**

* Access to a parent account
  * If you have access to an account’s child record, you have implicit **Read Only** access to that account.
* Access to child records
  * If you have access to a parent account, you have access to the associated child records. 
  * The account owner's role determines the level of access to child records.

Sharing behavior **for site or portal users**

* Account and contact access
  * An account’s portal or site user has **Read Only** access to the parent account and to all of the account’s contacts.
* Management access to data owned by Service Cloud portal users
  * Since Service Cloud portal users don't have roles, portal account owners can't access their data via the role hierarchy. 
  * To grant them access to this data, you can add account owners to the portal’s **share group** where the Service Cloud portal users are working.
  * This step provides **access to all data owned by Service Cloud portal users** in that portal.
* Case access
  * If a portal or site user is a contact on a case, then the user has **Read and Write** access on the case.

**Group membership operations and sharing recalculation**

* Simple operations can trigger a recalculation of sharing rules. Example operations: 
  * changing a user’s role
  * moving a role to another branch in the hierarchy
  * changing a site or portal account’s owner 
* Salesforce must check access to user’s data for people who are above the user’s new or old role in the hierarchy
  * and either add or remove shares to any affected records

### [Role Fields](https://help.salesforce.com/s/articleView?id=sf.user_role_fields.htm&type=5)
The fields that comprise a role entry have specific purposes. <br>
Refer to this table for descriptions of each field and how it functions in a role. <br>

|Field|Description|
|:----|:----------|
|Case Access|Specifies whether users can access other users’ cases that are associated with accounts the users own. This field isn’t visible if your organization’s sharing model for cases is Public Read/Write.|
|Contact Access|Specifies whether users can access other users’ contacts that are associated with accounts the users own. This field isn’t visible if your organization’s sharing model for contacts is Public Read/Write or Controlled by Parent.|
|Opportunity Access|Specifies whether users can access other users’ opportunities that are associated with accounts the users own. This field isn’t visible if your organization’s sharing model for opportunities is Public Read/Write.|
|Sharing Groups|These groups are automatically created and maintained. The Role group contains all users in this role plus all users in roles above this role. The Role and Subordinates group contains all users in this role plus all users in roles above and below this role in the hierarchy. The Role and Internal Subordinates group (available if Salesforce Experiences or portals are enabled for your organization) contains all users in this role. It also contains all users in roles above and below this role, excluding site and portal users.|
|This role reports to|The role above this role in the hierarchy.|

### [Account Access via Teams](https://help.salesforce.com/s/articleView?id=sf.accountteam_def.htm&type=5)
Considerations for granting account access via account teams and adding portal users to teams. <br>

**Access** <br>
**Accounts and Related Records**

* Your Salesforce admin sets default access to accounts and related records. 
  * To grant team members more access than the default, you must be the account owner or above in the role hierarchy. 
  * You can grant team members more access than the default, but not less
* To add team members who don’t have Read or Read/Write access to an account, you must be the owner or above in the role hierarchy

**Account Owner Changes and Group-Based Access**

* Suppose that a user with group-based access adds account team members. 
  * If the account owner is changed
    * the team members added by users with group-based access are removed from the team, even if the Keep account team option is selected.
* To keep the team members related to the account, they should be 
  * added by a Salesforce admin
  * the account owner
  * or someone above the owner in the role hierarchy

**Child Records**

* You **can't** grant team members greater access to child records than you have yourself.
  * For example, if you have Read access to child records on an account, you can’t give a team member Read/Write access. 
  * Ask your Salesforce admin to grant the needed access.

**Available Fields**
* The fields available when sales reps add a team member are based on the reps’ level of access to the account

<br>

**Org-Wide Default Access to Accounts and Opportunitie** <br>

Your Salesforce admin can set the default account and opportunity access to Private. <br>
In that case, if you give team members access to an individual opportunity, those users gain Read access to accounts on the opportunity. <br>
**Conversely, if you remove a user’s access to an individual account, the user is removed from opportunity teams related to the account.** <br>

<br>

**Portal Users** <br>
High-volume portal users **can’t** be added to teams.

### [Opportunity Teams](https://help.salesforce.com/s/articleView?id=sf.salesteam_def.htm&type=5)
Considerations and guidelines for using opportunity team list views, managing access to private records via opportunity teams, and adding portal users to teams. <br>

**Opportunity Teams in List Views** <br>
When you create or edit a custom list view for opportunities, the available filters include the following: <br>

**My opportunity teams**
* This filter shows opportunity teams that you belong to, whether owned by you or others.

**My team’s opportunities**
* This filter shows opportunities owned by your direct and indirect reports, based on role hierarchy.

<br>

**Private Accounts and Opportunities** <br>
**Organization-Wide Default Access Set to Private**
* Your Salesforce admin can set the organization-wide default access for accounts and opportunities to Private. 
  * In that case, if you give team members access to an individual opportunity, those users gain read-only access to accounts on the opportunity. 
  * Conversely, if you remove a user’s access to an individual account, the user is removed from opportunity teams related to the account.

**Records Set to Private**
* You **can’t** create opportunity teams for opportunities with the Private field selected.

**Portal Users**
* High-volume portal users **can’t** be added to teams.

### Convert a Master-Detail Relationship to a Lookup Relationship
It is possible to convert a master-detail relationship to a lookup relationship as long as no roll-up summary fields exist on the master object. <br>
Converting the relationship to a lookup relationship would change the organization-wide default sharing setting of the child object to `Public Read/Write`. <br>
Converting the relationship from a lookup relationship to a master-detail relationship would change the organization-wide default sharing setting to `Controlled by Parent`. <br>

### CRM Content License Assignment
A feature license is required to use CRM Content. <br>
It can be manually added to a user but does not have to be if the Autoassign feature is used. <br>
The Autoassign option can be used to automatically assign feature licenses to new or existing users. <br>

### [Content Deliveries](https://help.salesforce.com/s/articleView?id=sf.content_delivery_create.htm&type=5)
A content delivery allows you to convert documents such as Microsoft® PowerPoint and Word files into an optimized web-based version for easy online viewing. <br>
After you create your delivery, you can send its encrypted URL to any recipient, such as 
* leads
* customers
* partners
* colleagues

You can track how often people view or download the content. <br>
Content deliveries are available in **Salesforce Classic only**. <br>
However, **Lightning Email generates delivery-based links as email attachments** for Lightning Experience users who have access to the Content Deliveries feature. <br>

A content delivery can be created from the Content Deliveries related list on most Salesforce objects. <br>
Salesforce CRM Content users can also create a content delivery from the content details page or the Related Content related list. <br>

Delivery methods that determine how your content can be viewed. <br>
The options that appear depend on the file format you uploaded. <br>

|Option|Descroption|
|:-----|:----------|
|Allow Recipient to View in the Browser|Creates an online version of the file that recipients can view in their browser.|
|Allow Recipient to Download as [file type] file|Allows the recipient of your content delivery to view the content in its original format. For example, if you uploaded a Microsoft® Word file, this field will be Allow download as .doc file. If a preview of the file doesn’t exist in Salesforce, users can download the delivered file regardless of whether downloading is allowed. File previews are made the first time they are requested in Salesforce, but not before. Viewing a file’s detail page or posting it to a feed generate file previews.|
|Allow Recipient to Download as PDF|Allows recipients to download a .pdf version of the file. This option is only available for Microsoft® PowerPoint, Word, and Excel files.|

### [Case Teams](https://help.salesforce.com/s/articleView?id=sf.caseteam_setup.htm&type=5)
A case team allows a group of support users to work together on solving cases in Salesforce. <br>
It is possible to create a predefined case team in Setup. <br>
Case team roles can be used to specify either `read` or `read/write` access for the support reps to case records. <br>
The **Case Team** related list can be added to the cases to which the case team should be assigned. <br>
A list view can be created based on custom criteria in Lightning Experience to allow the support reps to view the cases that they should handle. <br>
They also have the option of using the filter panel of a list view to filter their cases by **My Case Teams**. <br>

<br>

**Case Team List Views** <br>
`My Case Teams` can be selected under `Filter By Owner`. <br>
A public group can be created for the members of the case team. <br>
The list view can be made visible only to the public group. <br>

### [Guest User Sharing Rules](https://help.salesforce.com/s/articleView?id=sf.security_sharing_rules_guest.htm&type=5)
A guest user sharing rule is a **special type of criteria-based sharing rule** and the only way to grant record access to unauthenticated guest users. <br>
Guest user sharing rules can **only grant Read Only access**. <br>

You must create guest user sharing rules to open up record access to guest users. <br>
Keep in mind that the guest user sharing rule type grants access to users without login credentials. <br>
By creating a guest user sharing rule, you're allowing **immediate and unlimited access** to all records matching the sharing rule's criteria to anyone. <br>
To secure your Salesforce data and give your guest users access to what they need, consider all the use cases and implications of creating this type of sharing rule. <br>
Implement security controls that you think are appropriate for the sensitivity of your data. <br>

### [External Organization-Wide Defaults](https://help.salesforce.com/s/articleView?id=sf.security_owd_external.htm&type=5)
External organization-wide defaults provide separate organization-wide defaults for internal and external users. <br>
They simplify your sharing rules configuration and improve recalculation performance. <br>
Additionally, you can easily see which information is being shared to external users. <br>

For example, to configure more restrictive access for external users, set the default **internal access** to `Public Read Only` or `Public Read/Write` and the default **external access** to `Private`. <br>
These settings also speed up performance for reports, list views, searches, and API queries. <br>

**NOTE:** The external access level for an object can’t be more permissive than the internal access level. <br>

You can set external organization-wide defaults for these objects.

* Account
* Asset
* Case
* Campaign
* Contact
* Individual
* Lead
* Opportunity
* Order
* User
* Custom Objects

External organization-wide defaults aren’t available for some objects, but you can achieve the same behavior with sharing rules. <br>
Set the default access to Private and create a sharing rule to share records with all internal users. <br>

External users include:

* Authenticated website users
* Chatter external users
* Site users
* Customer Portal users
* High-volume Experience Cloud site users
* Partner Portal users
* Service Cloud Portal users

### [Account Role Optimization (ARO)](https://help.salesforce.com/s/articleView?id=sf.networks_partners_optimize_roles.htm&type=5)
If you expect to have a large volume of business accounts with a single Experience Cloud user, we recommend enabling account role optimization (ARO) to ensure the best performance possible. <br>
ARO minimizes the number of roles created for users with Customer Community Plus and Partner Community licenses. <br>
**The fewer roles, the better the performance of your Experience Cloud site.** <br>

With ARO enabled for an external role-based user who is the only external role-based user on the account, a shared person role is created and assigned to the user. <br>
It rolls up to the account owner. <br>
Without ARO, the default number of site roles (1 to 3) is created and assigned to the user. <br>
This optimization can replace the need for possibly thousands of account roles. <br>

When a second role-based user with a Customer Community Plus or Partner Community license is added to the account, more roles are necessary to support sharing data. <br>
Instead, the default number of 1 to 3 account roles are created based on the default number of site roles. <br>
The lowest level (Worker) role is assigned to all external role-based account users. <br>
In a three-role hierarchy, the Executive, Manager, and User roles are created. <br>
The top-most role rolls up to the account owner. <br>

Account role optimization interacts with Customer Community Plus and Partner Community license users independently. <br>
If an account has a single user with a Customer Community Plus license and two users with Partner Community licenses, ARO applies only to the Customer Community Plus license user. <br>
The user with the Customer Community Plus license is assigned to the shared customer site person role. <br>
Each user with the Partner Community license is individually assigned to one of the account’s partner site roles. <br>
This feature doesn’t affect role usage for person accounts. <br>

### [Sharing Sets](https://help.salesforce.com/s/articleView?id=sf.networks_setting_light_users.htm&type=5)
Give Experience Cloud site users access to records using sharing sets. <br>
A sharing set grants site users **access to any record associated with an account or contact that matches the user’s account or contact**. <br>
You can grant access to records via access mapping, which defines access for each object in the sharing set. <br>
Access mappings support indirect lookups from the user and target record to the account or contact. <br>
For example, grant site users access to all cases related to an account that’s identified on the user’s contact records. <br>
A sharing set applies across all sites that a user is a member of. <br>
Record access granted to users via a sharing set **isn’t extended to their superiors in the role hierarchy**. <br>

#### [Share Groups](https://help.salesforce.com/s/articleView?id=sf.networks_sharing_light_users.htm&type=5)
A share group can be created by adding the user as a member to the group from the `Share Group Settings` tab of the existing sharing set. <br>
Members of a share group can access any records owned by customer site users in the associated sharing set. <br>

### [Experience Cloud User Licenses](https://help.salesforce.com/s/articleView?id=sf.users_license_types_communities.htm&type=5)
Covered in my [Data Architect Notes](https://github.com/HeikoKramer/sfdx/blob/main/cert-prep/data-architect_notes.md#experience-cloud-user-licenses).

### [Partner User Roles](https://help.salesforce.com/s/articleView?id=sf.networks_partner_roles_overview.htm&type=5)
When you enable the first external user on a partner account, a user role hierarchy is created for that account. <br>
This role hierarchy rolls up to the account owner (typically, the channel manager). <br>
The three roles in this hierarchy are Partner User, Partner Manager, or Partner Executive. <br>
When you create contacts on the partner account and convert them to external users, assign one of these roles to them. <br>

The Partner User role rolls up to the Partner Manager role, which rolls up to the Partner Executive role. <br>
The Partner Executive role rolls up to the Channel Manager role. <br>
Partner users can view and edit all data owned by or shared with users below them in the hierarchy, regardless of the org’s sharing model. <br>

The role names include the partner account name. <br>
For example, the partner account name is Acme. <br>
The three roles created for the Acme account are Acme Partner User, Acme Partner Manager, and Acme Partner Executive. <br>
If the ownership of a partner account is changed to another channel manager, the partner user role is moved to that location in the role hierarchy. <br>

You can delete partner roles, in which case the roles are renamed to maintain the hierarchy. <br>
For example, if the Manager role is deleted from a three-role hierarchy of Executive, Manager, and User, then the Executive role is renamed to Manager. <br>
The object ID remains the same. <br>
When you create a partner role, it is automatically placed at the top as a parent. <br>
You can delete multiple roles in bulk for better performance. <br>
For example, if most of your users are assigned the User role, you can delete the Executive and Manager roles. <br>
For more information on deleting partner roles, see SOAP API Developer's Guide. <br>

### [Delegated External Admins](https://help.salesforce.com/s/articleView?id=sf.networks_DPUA.htm&type=5)
Delegated external user administration rights can only be granted to external users with the following community user license types:
* Partner Community
* Customer Community Plus
* Gold Partner
* Enterprise Administration
* Customer Portal Manager licenses


A delegated external administrator can
* create and edit external user records 
* generate new passwords for external users
* deactivate existing external users 

**NOTE:** If custom fields are present on the user detail records, they are not visible to the delegated external administrator.

### [Super User Access](https://help.salesforce.com/s/articleView?id=sf.networks_partner_super_user_access.htm&type=5)
Super User Access can be enabled to allow **partner users** to **access data owned by other partner users** who have the same role or a role below them. <br>
Super user access applies only to 
* cases
* leads
* custom objects
* opportunities

### [Record-Level Access](https://resources.docs.salesforce.com/sfdc/pdf/salesforce_record_access_under_the_hood.pdf)
Just click on the headline above for the appropriate pdf document with great visualisations. <br>

### [3rd Party Proxy Server](https://developer.salesforce.com/docs/atlas.en-us.integration_patterns_and_practices.meta/integration_patterns_and_practices/integ_pat_security_considerations.htm)
Sensitive on-premise information can be accessed using Salesforce through a third-party proxy server. <br>
The third-party proxy server would be situated in front of the web server. <br>
It would forward client requests from Salesforce to the web server. <br>

### [Assign a Territory Manually to an Opportunity](https://help.salesforce.com/s/articleView?id=sf.tm2_assign_territory_to_opportunity_manually.htm&type=5)
On an opportunity record, you can assign and track the territory whose assigned sales reps work that opportunity. <br>
Manual territory assignments are controlled by your access to the opportunity’s assigned (parent) account. <br>
When you assign a territory to an opportunity, that opportunity is shared with all Salesforce users assigned to that territory’s parent in the territory model’s hierarchy. <br>
The `Territory` field on an opportunity can be used to assign a territory to the opportunity. <br>

### [Named Credentials](https://help.salesforce.com/s/articleView?id=sf.named_credentials_about.htm&type=5)
A named credential specifies the **URL of a callout endpoint** and its required **authentication parameters** in one definition. <br>
To simplify the setup of authenticated callouts, specify a named credential as the callout endpoint. <br>
If you instead specify a URL as the callout endpoint, you must register that URL in your org’s remote site settings and handle the authentication yourself. <br>
For example, for an Apex callout, your code handles authentication, which can be less secure and especially complicated for OAuth implementations. <br>

Salesforce manages all authentication for callouts that specify a named credential as the callout endpoint so that you don’t have to. <br>
You can also skip remote site settings, which are otherwise required for callouts to external sites, for the site defined in the named credential. <br>

<br>

Named credentials are supported in these types of callout definitions:

* Apex callouts
* External data sources of these types:
  * Salesforce Connect: OData 2.0
  * Salesforce Connect: OData 4.0
  * Salesforce Connect: Custom (developed with the Apex Connector Framework)
* External Services

Named Credentials also include an OutboundNetworkConnection field that you can use to route callouts through a private connection. <br>
By separating the endpoint URL and authentication from the callout definition, named credentials make callouts easier to maintain. <br>
For example, if an endpoint URL changes, you update only the named credential. <br>
All callouts that reference the named credential simply continue to work. <br>

If you have multiple orgs, you can create a named credential with the same name but with a different endpoint URL in each org. <br>
You can then package and deploy—on all the orgs—one callout definition that references the shared name of those named credentials. <br>
For example, the named credential in each org can have a different endpoint URL to accommodate differences in development and production environments. <br>
If an Apex callout specifies the shared name of those named credentials, the Apex class that defines the callout can be packaged and deployed on all those orgs without programmatically checking the environment. <br>

A named credential authentication protocol support 
* basic password authentication
* OAuth 2.0
* JWT
* JWT Token Exchange
* AWS Signature Version 4

You can set up each named credential to use an org-wide named principal or per-user authentication. <br>
A named principal applies the same credential or authentication configuration for the entire org, while per-user authentication provides access control at the individual user level. <br>

To reference a named credential from a callout definition, use the named credential URL. <br>
A named credential URL contains the scheme 
* **callout:**
* the name of the named credential
* an optional path

For example: `callout:My_Named_Credential/some_path`. <br>

You can append a query string to a named credential URL. <br>
Use a question mark (?) as the separator between the named credential URL and the query string. <br>
For example: `callout:My_Named_Credential/some_path?format=json`. <br>

### Custom Sharing Object
All custom object sharing objects are named as follows, where 'customObject' is the name of the custom object: `customObject__Share`. <br>

A share object provides information about
* the record access level 
* record ID
* reason why the user or group is granted access
* user or group ID

### [File Upload and Download Security](https://help.salesforce.com/s/articleView?id=sf.admin_files_type_security.htm&type=5)
The `File Upload and Download Security` page in Setup allows Salesforce Administrators to configure **how certain file types behave** when accessed in Salesforce. <br>

These download behaviors are available for each file type:
* Download (recommended)
  * The file, regardless of file type, is always downloaded.
* Execute in Browser
  * The file, regardless of file type, is displayed and executed automatically when accessed in a browser or through an HTTP request.
* Hybrid
  * Salesforce Files are downloaded. Attachments and documents execute in the browser.

To prevent users from uploading files that can pose a security risk, select `Don't allow HTML uploads as attachments or document records`. <br>
This setting blocks the upload of these MIME file types: 
* .html
* .htt
* .mht
* .svg
* .swf
* .thtml
* .xhtml.

### [User, Sharing, and Permission Objects](https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_erd_users.htm)
![Sharing and Permission Objects](/cert-prep/images/user_sharing-permissions.png)

### [Territory Model State](https://help.salesforce.com/s/articleView?id=sf.tm2_territory_model_state.htm&type=5)
A territory model's lifecycle state indicates whether a territory is 
* in the planning stage `Planning` 
* in active use `Active`
* or archived `Archived`

There can be only one territory model in `Active` state at a time, but it is possible to create and maintain multiple models in planning or archived state to use for extra modeling or reference. <br>

### [Magic Mover for Notes And Attachments to Lightning Experience](https://help.salesforce.com/s/articleView?id=000315846&type=1)
**Magic Mover for Notes And Attachments to Lightning Experience** is an AppExchange package that consists of three tools. <br>
Admins can use the **Attachments to Files** tool for bulk conversion of all the non-private attachments and the **Notes Conversion** tool to convert all the public notes. <br>
They can also use the **Update Page Layouts** tool to update layouts for use with the new related lists exclusively. <br>
Conversion of notes and attachments is supported for custom objects and these standard objects: Account, Asset, Campaign, Case, Contact, Contract, Lead, Opportunity, Product, Quote, and Solution. <br>

### [See Record Access Reasons](https://help.salesforce.com/s/articleView?id=release-notes.rn_forcecom_sharing_view_record_access_lex.htm&type=5&release=232)
The `Sharing Hierarchy` button on a record can be used to view all the users who have access to the record and the reason for the access. <br>
From the **Sharing Hierarchy list view**, one can click on `View` to view the reason for record access. <br>

### [Apex Crypto Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_restful_crypto.htm)
The Apex Crypto class allows the protection of data at rest and in transit from unauthorized parties. <br>
The class has various functions that can be used for data encryption. <br>
It can be used for encrypting data for integration with external services such as Google or AWS. <br>
It allows verifying the authenticity of the source system and ensuring the integrity of the data and its confidentiality. <br>
For example, the `Crypto.encrypt()` method allows encrypting data using a specific algorithm such as **RSA-SHA256** before sending it to an external system. <br>

## Performance and Scalability (7%)
Given a particular complex customer org setup, design a security model that is maintainable at large scale.

### [Branch Accounts](https://resources.docs.salesforce.com/sfdc/pdf/draes.pdf)
Accounts can be split into multiple branch accounts, and the opportunities can be distributed evenly among the accounts. <br>
It should be ensured that no more than **10,000** opportunities are related to any single account record in Salesforce to reduce the risk of locking errors. <br>

### Ownership Data Skew
When a single user owns **more than 10,000 records**, it is called **ownership data skew**. <br>
It can cause performance issues if the user is 
* moved around the hierarchy
* or if they are moved into or out of a role or group that is the source group for a sharing rule

The following actions can be taken to prevent long-running recalculation of access rights:
* The ownership of records can be distributed across a greater number of users to decrease the chance of long-running updates
* If possible, the user should not be assigned to a role in the role hierarchy
* The user should be placed in a separate role at the top of the hierarchy

### [Granular Locking](https://developer.salesforce.com/docs/atlas.en-us.216.0.draes.meta/draes/draes_tools_granular_locking.htm)
Granular locking is a feature that is enabled by default. <br>
It employs additional logic to allow multiple updates to proceed simultaneously if there is no 
* hierarchical or other relationship between the roles 
* or groups involved in the updates

This can be used to process large-scale updates faster while avoiding locking errors. <br>

There are several key advantages of granular locking:
* Groups that are in separate hierarchies can be manipulated concurrently
* Public groups and roles that do not include territories are no longer blocked by territory operations
* Users can be added concurrently to territories and public groups
* User provisioning can occur in parallel
* A single-long running process, such as a role delete, blocks only a small subset of operations

### [Group Maintenance Tables](https://developer.salesforce.com/docs/atlas.en-us.salesforce_record_access_under_the_hood.meta/salesforce_record_access_under_the_hood/uth_groups.htm)
Sharing rows grant access to users and groups, but the data that specifies who belongs to each group resides in the Group Maintenance tables. <br>
These tables store membership data for every Salesforce group, including system-defined groups. <br>
System-defined groups are groups of users that Salesforce creates and manages internally to support various features and behaviors, such as queues. <br>
This type of management lets the data that supports queues and personal or public groups coexist in the same database tables, and unifies how Salesforce manages the data. <br>
For example, Salesforce can grant record access to a queue the same way it grants record access to a public group. <br>

Salesforce also uses system-defined groups to implement hierarchies. <br>
During recalculation, Salesforce creates two types of system-defined groups, **Role groups** and **RoleAndSubordinates groups**, for every node in the role hierarchy. <br>
If the organization has external organization-wide defaults enabled, a third type of system-defined group, **RoleAndInternalSubordinates**, is created. <br>

|Group|Consists of|Purpose|
|:----|:----------|:------|
|Role|Users assigned to any of the following. <br> - A specific role <br> - One of its manager roles|Used to give managers access to their subordinates’ records|
|RoleAndSubordinates|Users assigned to any of the following. <br> - A specific role <br> - One of its manager roles <br> - One of its subordinate roles|Used when an organization defines a rule that shares a set of records with: <br> - A particular role<br> - Its subordinates|
|RoleAndInternalSubordinates|Users assigned to any of the following. <br> - A specific role <br> - One of its manager roles <br> - One of its subordinate roles, excluding Portal roles|Used when an organization defines a rule that shares a set of records with: <br> - A particular role <br> - Its subordinates, excluding Portal roles|

All three group types have:

* Indirect members, who inherit record access from the group’s direct members and are assigned to manager roles
* Direct members, who are defined according to their group type
  * In Role groups, direct members are those members assigned to the role the group represents.
  * In RoleAndSubordinates groups, direct members are those members assigned to the role the group represents or one of its subordinate roles
  * In RoleAndInternalSubordinates groups, direct members are those members assigned to the role the group represents, or one of its non-portal subordinate roles.

![Group Maintenance Tables](/cert-prep/images/group_maintanace.png)

By scanning the Role groups, Salesforce can quickly identify the indirect members who inherit record access from users at that role. <br>
For example, to see which users inherit record access from Bob in the role hierarchy, Salesforce simply searches for Role groups that have Bob as a direct member (the East Sales Rep Role group), and finds all the indirect members in those groups (Marc and Maria). <br>

Likewise, by scanning the RoleAndSubordinates groups, Salesforce can quickly see which users receive access through role and subordinate sharing rules. <br>
For example, if a rule shares a set of records with users in the Sales Executive role and their subordinates, Salesforce can identify those users by scanning the Sales Executive RoleAndSubordinates group. <br>

<br>

System-defined groups support Territory Management in a similar way. <br>
For each territory, Salesforce creates a:

* Territory group
  * in which users who are assigned to the territory are direct members
  * while users assigned to territories higher in the hierarchy are indirect members
* TerritoryAndSubordinates group
  * in which users who are assigned to that territory or territories lower in the hierarchy are direct members 
  * while users assigned to territories higher in that branch are indirect members

Users can’t modify system-defined groups through the user interface or API in the ways that they can personal and public groups. <br>
Modifying a queue or hierarchy causes Salesforce to recalculate its associated system-defined groups accordingly. <br>
The size and complexity of an organization’s queues and hierarchies directly affect the duration of record access calculations. <br>

## Programmatic Sharing (17%)
Given a scenario
* design a solution that leverages programmatic sharing functionalities to achieve a requirement that cannot be met using declarative functionality.
* describe how to minimize security risks in programmatic customizations (Apex, Visualforce, Lightning Component) relative to data visibility.
* demonstrate how to properly design unit tests to verify programmatic security solutions.
* demonstrate how to properly enforce Object and Field level permission when designing Programmatic Solutions.

### [anti-CSRF token](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/pages_security_tips_csrf.htm)
Within the Lightning platform, Salesforce has implemented an anti-CSRF token to prevent CSRF attacks. <br>
Every page includes a random string of characters as a hidden form field. <br>
Upon the next page load, the application checks the validity of this string of characters and does not execute the command unless the value matches the expected value. <br>

### [Sharing a Record Using Apex](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_bulk_sharing_creating_with_apex.htm)
To access sharing programmatically, you must use the **share object** associated with the standard or custom object for which you want to share. <br>
For example, **AccountShare** is the sharing object for the Account object, **ContactShare** is the sharing object for the Contact object. <br>
In addition, all custom object sharing objects are named as follows, where MyCustomObject is the name of the custom object: <br>
**MyCustomObject__Share** <br>

<br>

Objects on the detail side of a master-detail relationship **do not have** an associated sharing object. <br>
The detail record’s access is determined by the master’s sharing object and the relationship’s sharing setting. <br>

A share object includes records supporting all three types of sharing: 
* managed sharing
* user managed sharing
* Apex managed sharing

Sharing granted to users implicitly are not tracked with this object. <br>
Examples for implicit sharing:
* organization-wide defaults
* the role hierarchy
* permissions such as 
  * `View All` and `Modify All` permissions for the given object
  * `View All Data` and `Modify All Data` 

Every share object has the following properties:
* objectNameAccessLevel
  * The level of access that the specified user or group has been granted for a share sObject. 
  * The name of the property is AccessLevel appended to the object name. 
  * For example, the property name for LeadShare object is LeadShareAccessLevel. Valid values are:
    * `Edit`
    * `Read`
    * `All` (The `All` access level is an internal value and can’t be granted.)
* ParentID
  * The ID of the object. This field cannot be updated.
* RowCause
  * The reason why the user or group is being granted access. 
  * The reason determines the type of sharing, which controls who can alter the sharing record. This field cannot be updated.
* UserOrGroupId
  * The user or group IDs to which you are granting access. A group can be:
    * A public group or a sharing group associated with a role.
    * A territory group.
  * This field cannot be updated.

#### [Apex Sharing Reasons](https://help.salesforce.com/s/articleView?id=sf.security_apex_sharing_reasons.htm&type=5)
Apex sharing reasons can be used to troubleshoot programmatic sharing and to ensure that the share record is not deleted when the ownership is changed. <br>
Each Apex sharing reason has a label and a name. <br>
The label displays in the ‘Reason’ column when viewing the sharing for a record in the user interface. <br>
It is important to note that Apex sharing reasons can only be created for custom objects; they do not support sharing records of related standard objects. <br>
An Apex sharing reason can be viewed by clicking the ‘Sharing’ button on a record, but the detail page of the record does not display it. <br>

When working with Apex sharing reasons, note the following:

* Only users with the “Modify All Data” permission can add, edit, or delete sharing that uses an Apex sharing reason.
* Deleting an Apex sharing reason will delete all sharing on the object that uses the reason.
* You can create up to 10 Apex sharing reasons per custom object.
* You can create Apex sharing reasons using the Metadata API.

### [Cross Site Scripting](https://developer.salesforce.com/docs/atlas.en-us.secure_coding_guide.meta/secure_coding_guide/secure_coding_cross_site_scripting.htm)
The following functions can be used to neutralize potential XSS threats:
* `HTMLENCODE()` 
  * This function allows performing additional HTML encoding of input prior to reflection in HTML context.
* `JSENCODE()` 
  * This function can be used to perform JavaScript encoding of input prior to reflection in JavaScript context.
* `JSINHTMLENCODE()`
  * Before the introduction of auto-HTML encoding, developers called this function when including merge-fields in JavaScript event handlers within HTML.
* `JSENCODE(HTMLENCODE())`
  * This function can be used in place of `JSINHTMLENCODE()`.

### [DescribeFieldResult Class](https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_methods_system_fields_describe.htm#apex_methods_system_fields_describe)
The `DescribeFieldResult` class contains two important methods to determin the current user's access rights to a record:
* `isAccessible()`
  * Returns true if the current user can see this field, false otherwise.
* `isUpdateable()`
  * Returns true if the field can be edited by the current user
  * or child records in a master-detail relationship field on a custom object can be reparented to different parent records
  * false otherwise.
* `isCreateable()`
  * Returns true if the object can be created by the current user, false otherwise.
* `isDeletable()`
  * Returns true if the object can be deleted by the current user, false otherwise.

### [Lightning Locker](https://developer.salesforce.com/docs/component-library/documentation/en/lwc/lwc.security_locker_service)
Lightning Locker is a security architecture implemented for Lightning components to promote a safe and secure environment for the components to interact with each other. <br>
Lightning Locker automatically enables strict mode for JavaScript code where variables require declarations, objects, and functions cannot be deleted, etc. <br>
Lightning Locker also prevents loading of external resources. <br>
Any external JavaScript libraries must be uploaded and referenced as static resources. <br>

Access to JavaScript global variables is restricted, and they are either hidden or wrapped in secure versions. <br>
For example, if a developer needs to access the global 'window' variable, a 'SecureWindow' variable is provided instead that is a secure version of the original variable. <br>
Components are not allowed to access elements in other components. <br>
A component can only access elements that it owns or created. <br>

### [Using the runAs Method](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_testing_tools_runas.htm)
Generally, all Apex code runs in system mode, where the permissions and record sharing of the current user aren’t taken into account. <br>
The system method `runAs` enables you to write test methods that change the user context to an existing user or a new user so that the user’s record sharing is enforced. <br>
The `runAs` method doesn’t enforce user permissions or field-level permissions, **only record sharing**. <br>
**NOTE:** The user's sharing permissions are enforced within a `runAs` block, regardless of the sharing mode of the test class. <br>
If a user-defined method is called in the `runAs` block, the sharing mode enforced is that of the class where the method is defined. <br>

You can use `runAs` **only in test methods**. The original system context is started again after all `runAs` test methods complete. <br>
The `runAs` method **ignores user license limits**. You can create new users with runAs even if your organization has no additional user licenses. <br>

**NOTE:** Every call to `runAs` counts against the total number of DML statements issued in the process. 
The `runAs` method can be used to perform mixed DML operations in the test by enclosing the DML operations within the `runAs` block. <br>
This can be used to bypass the mixed DML error that is otherwise returned when inserting or updating setup objects together with other sObjects. <br>

### [SOQL Injection](https://focusonforce.com/exams/programmatic-sharing-25-sharing-and-visibility-designer/)
The following are valid methods of preventing SOQL injection attacks:
* Static queries with bind variables
* `String.escapeSingleQuotes()`
* Typecasting
* Replacing characters
* Allowlisting

### [The `stripInaccessible` Method](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_with_security_stripInaccessible.htm)
Use the `stripInaccessible` method to enforce field- and object-level data protection. <br>
This method can be used to strip the fields and relationship fields from query and subquery results that the user can’t access. <br>
The method can also be used to remove inaccessible sObject fields before DML operations to avoid exceptions and to sanitize sObjects that have been deserialized from an untrusted source. <br>

The following example code removes inaccessible fields from the query result. <br>
A display table for campaign data must always show the BudgetedCost. <br>
The ActualCost must be shown only to users who have permission to read that field. <br>

```java
SObjectAccessDecision securityDecision = 
         Security.stripInaccessible(AccessType.READABLE,
                 [SELECT Name, BudgetedCost, ActualCost FROM Campaign]);

    // Construct the output table
    if (securityDecision.getRemovedFields().get('Campaign').contains('ActualCost')) {
        for (Campaign c : securityDecision.getRecords()) {
        //System.debug Output: Name, BudgetedCost
        }
    } else {
        for (Campaign c : securityDecision.getRecords()) {
        //System.debug Output: Name, BudgetedCost, ActualCost
        }
}
```

### [With Sharing Keyword](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_keywords_sharing.htm)
The `with sharing` keyword can be used in the definition of an Apex class to specify that the organization-wide defaults and sharing rules for the current user are considered for the Apex class. <br>

```java
public with sharing class sharingClass {

   // Code here

}
```

### [Lightning Security](https://developer.salesforce.com/docs/atlas.en-us.secure_coding_guide.meta/secure_coding_guide/secure_coding_lightning_security.htm)
**General Lightning Security Considerations** <br>
Third-party Lightning components and apps operate in a special domain (lightning.force.com or lightning.com) that is shared with Salesforce-authored Lightning code.
In particular, setup.app, which controls many sensitive security settings. <br>
Visualforce applications, by contrast, are served from a different domain (force.com or visualforce.com) that isn't shared with Salesforce code. <br>
Because Lightning code shares the same origin as Salesforce-authored code, increased restrictions are placed on third-party Lightning code. <br>
These restrictions are enforced by Lightning Locker and a special Content Security Policy. <br>
There is also additional scrutiny in the AppExchange security review. <br>


When developing Lightning apps, ensure that the stricter CSP setting is enabled. <br>
Org admins should enable this setting to protect the org's security controls from vulnerabilities in custom Lightning components. <br>
Develop and test your code with stricter CSP enabled in order to ensure compatibility. <br>
Note that stricter CSP is enabled by default beginning with Summer '18, but not in orgs created previously. <br>
