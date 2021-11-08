# Apex Recipes
Note file to store useful Apex scripts <br>

## Package License Assignment

```java
// Example how to assign a package license to a user 
// The license assignment is handeled in the UserPackageLicense object
 
List<User> listOfUsers = [SELECT Id 
                            FROM User
                           WHERE Username = 'user@name.here']; // <-- place username here
 
List<UserPackageLicense> listOfLicensesToInsert = new List<UserPackageLicense>();
 
for (User u : listOfUsers) {
    UserPackageLicense userLicenseAssignment = new UserPackageLicense();
    userLicenseAssignment.PackageLicenseId   = 'someId'; // <-- place PackageLicenseId here
    userLicenseAssignment.UserId             = u.Id; // assign UserId
    listOfLicensesToInsert.add(userLicenseAssignment);
}
 
insert listOfLicensesToInsert;
```

## Feature License & Call Center Assignment

```java
// Example how to assign feature licenses and call center via Apex
 
List<User> listOfUsers = [SELECT Id, UserPermissionsMarketingUser, UserPermissionsKnowledgeUser, UserPermissionsInteractionUser, UserPermissionsSupportUser, CallCenterId
                            FROM User
                           WHERE Username = 'some@user.name']; // <-- place username here
 
for (User u : listOfUsers) {
    u.UserPermissionsMarketingUser   = true; // Checks "Marketing User"
    u.UserPermissionsKnowledgeUser   = true; // Checks "Knowledge User"
    u.UserPermissionsInteractionUser = true; // Checks "Flow User"
    u.UserPermissionsSupportUser     = true; // Checks "Service Cloud User"
    u.CallCenterId                   = 'someId'; // <-- place CallCenterId here
}
 
update listOfUsers;
```

## Permission Set Assignment

```java
List<User> listOfUsers = [SELECT Id 
                            FROM User
                           WHERE Username = 'user@name.here']; // <-- place username here

List<PermissionSetAssignment> newAssignments = new List<PermissionSetAssignment>();

for (User u : listOfUsers) {
    PermissionSetAssignment cusOpsAssignment = new PermissionSetAssignment();
    cusOpsAssignment.AssigneeId              = u.Id;
    cusOpsAssignment.PermissionSetId         = 'someId'; // <-- place PermissionSetId here
    newAssignments.add(cusOpsAssignment);
}

insert newAssignments;
```

