-- last week's logins, grouped by type
SELECT count(id), LoginType FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY LoginType

-- last week's logins, grouped by country
SELECT count(id), LoginGeo.country FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY LoginGeo.country

-- last week's logins, grouped by status
SELECT count(id), Status FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY Status

-- last week's logins, grouped by LoginUrl
SELECT count(id), LoginUrl FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY LoginUrl 
-- get login types
SELECT count(id), LoginType FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY LoginType

-- List of LoginTypes:
-- Application
-- Other Apex API
-- Partner Product
-- Other Apex API
-- Remote Access Client
-- SAML Sfdc Initiated SSO
-- Remote Access 2.0
-- Chatter Communities External User
-- Salesforce Outlook Integration

-- login countries
SELECT count(id), LoginGeo.country FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY LoginGeo.country


-- login URLs for 'Remote Access 2.0' LoginType
SELECT count(id), LoginUrl FROM LoginHistory WHERE LoginTime = LAST_WEEK AND LoginType = 'Remote Access 2.0' GROUP BY LoginUrl 

-- login URLs for 'Remote Access 2.0' LoginType via login.salesforce.com
SELECT UserId FROM LoginHistory WHERE LoginTime = LAST_WEEK AND LoginType = 'Remote Access 2.0' AND LoginUrl = 'login.salesforce.com'

-- Used URLs of non-SSO Logins
SELECT count(id), LoginUrl FROM LoginHistory WHERE LoginTime = LAST_WEEK AND LoginType = 'Remote Access 2.0' GROUP BY LoginUrl 


-- Find API Users
SELECT UserName, Profile.UserLicense.name FROM User WHERE Id IN (SELECT UserId FROM LoginHistory WHERE LoginType = 'Other Apex API')


-- login status (of last week's logins)
SELECT count(id), Status FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY Status



-- sfdx command to count and export last weeks login grouped by status
sfdx force:data:soql:query -u prod -t -q "SELECT count(id), Status FROM LoginHistory WHERE LoginTime = LAST_WEEK GROUP BY Status" -r "csv" > logins.csv