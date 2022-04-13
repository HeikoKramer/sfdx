-- find all password resets
SELECT Action,CreatedBy.Name,CreatedDate,DelegateUser,Display,Id FROM SetupAuditTrail WHERE Action = 'resetpassword'

-- find all entries of a certain user
SELECT Action,CreatedBy.Name,CreatedDate,DelegateUser,Display,Id FROM SetupAuditTrail WHERE CreatedById = '' -- <-- user ID here

-- find all of today's actions, which are email related 
SELECT Action,CreatedBy.Name,CreatedDate,DelegateUser,Display,Id FROM SetupAuditTrail WHERE Action LIKE '%mail%' AND CreatedDate = today

-- find all changes to standard profiles
SELECT Action,CreatedBy.Name,CreatedDate,DelegateUser,Display,Id FROM SetupAuditTrail WHERE Action = 'profileFlsChangedStandard'