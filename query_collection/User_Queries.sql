-- count active users grouped by their license name
SELECT count(id), Profile.UserLicense.name FROM User WHERE isActive = true GROUP BY Profile.UserLicense.name

-- count active users with "Customer Community Plus Login" license, grouped by their profile name
SELECT count(id), Profile.Name FROM User WHERE isActive = true AND Profile.UserLicense.name = 'Customer Community Plus Login' GROUP BY Profile.Name

-- users with "Customer Community Plus Login" license that never logged in
SELECT count(id), Profile.Name FROM User WHERE isActive = true AND Profile.UserLicense.name = 'Customer Community Plus Login' AND LastLoginDate = null GROUP BY Profile.Name

-- users with "Customer Community Plus Login" license that never logged in -> grouped by calendar year (createdDate)
SELECT count(id), Calendar_Year(createdDate) FROM User WHERE isActive = true AND Profile.UserLicense.name = 'Customer Community Plus Login' AND LastLoginDate = null GROUP BY Calendar_Year(createdDate) ORDER BY Calendar_Year(createdDate) ASC

-- users with "Customer Community Plus Login" license that never logged in -> grouped by calendar year (LastLoginDate)
SELECT count(id), Calendar_Year(LastLoginDate) FROM User WHERE isActive = true AND Profile.UserLicense.name = 'Customer Community Plus Login' AND LastLoginDate != null GROUP BY Calendar_Year(LastLoginDate) ORDER BY Calendar_Year(LastLoginDate) ASC

-- partner community users, grouped by year of last login
SELECT count(id), Calendar_Year(LastLoginDate) FROM User WHERE isActive = true AND Profile.UserLicense.name = 'Partner Community' GROUP BY Calendar_Year(LastLoginDate) ORDER BY Calendar_Year(LastLoginDate) ASC


-- frozen but still active users
SELECT Id,IsFrozen,IsPasswordLocked,LastModifiedById,LastModifiedDate,UserId FROM UserLogin WHERE IsFrozen = true AND UserId IN (SELECT Id FROM User WHERE isActive = true)

-- count of frozen but still active users grouped and ordered by calendar year 
SELECT count(id), Calendar_Year(LastModifiedDate) FROM UserLogin WHERE IsFrozen = true AND UserId IN (SELECT Id FROM User WHERE isActive = true) GROUP BY Calendar_Year(LastModifiedDate) ORDER BY Calendar_Year(LastModifiedDate) ASC


-- count all platform users without FederationIdentifier 
SELECT count() FROM User WHERE Profile.UserLicense.name = 'Salesforce Platform' AND isActive = true AND FederationIdentifier = '' 


-- active non-portal users not created via AD
SELECT CompanyName,Country,CreatedBy.Name,CreatedDate,Department,Division,Email,FederationIdentifier,Id,LastPasswordChangeDate,Title,Username,UserRole.Name,Profile.Name,UserType,lastLoginDate,Profile.UserLicense.name FROM User 
WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE' ORDER By LastLoginDate ASC NULLS LAST 

--- when did those users last login
SELECT count(id),Calendar_Year(LastLoginDate) FROM User 
WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE'
GROUP BY Calendar_Year(LastLoginDate) ORDER BY Calendar_Year(LastLoginDate) ASC

-- when were those users created
SELECT count(id),Calendar_Year(CreatedDate) FROM User 
WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE'
GROUP BY Calendar_Year(CreatedDate) ORDER BY Calendar_Year(CreatedDate) ASC

-- when chanded those users their paswords
SELECT count(id),Calendar_Year(LastPasswordChangeDate) FROM User 
WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE'
GROUP BY Calendar_Year(LastPasswordChangeDate) ORDER BY Calendar_Year(LastPasswordChangeDate) ASC

-- what are their profiles
SELECT count(id),Profile.name FROM User 
WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE'
GROUP BY Profile.name

-- count of internal users manually created
SELECT count() FROM User WHERE isACtive = true AND Profile.UserLicense.name != 'Customer Community Plus Login' AND Profile.UserLicense.name != 'Guest User License' AND Profile.UserLicense.name != 'Partner Community' AND CreatedBy.Name != 'Place Name of Integrationuser HERE'


-- full-license users which have never logged-in
SELECT count(id) FROM User WHERE Profile.UserLicense.name = 'Salesforce' AND isActive = true AND LastLoginDate = null


-- PERMISSION SETS
-- permission sets assigned to only one user 
SELECT PermissionSet.Name, count(AssigneeId) FROM PermissionSetAssignment GROUP BY PermissionSet.Name HAVING count(AssigneeId) < 2 LIMIT 200

-- permission set without assignment
SELECT Name, isCustom FROM PermissionSet WHERE Id NOT IN (SELECT PermissionSetId FROM PermissionSetAssignment)

-- list all users which have a certain permission set assigned
SELECT Assignee.Name,ExpirationDate,Id,IsActive,PermissionSetGroupId,PermissionSet.Name 
FROM PermissionSetAssignment 
WHERE PermissionSetId = '' -- <- place Id of Permission Set here