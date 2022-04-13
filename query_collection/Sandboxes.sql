-- Sandboxes created or refreshed within 2021 and 2022 (must be queries using the tooling API):
SELECT Id, createdDate, Description, LicenseType, SandboxName FROM SandboxInfo WHERE Id IN (SELECT SandboxInfoId FROM SandboxProcess WHERE (Calendar_Year(CreatedDate) = 2021 OR Calendar_Year(CreatedDate) = 2022) ) ORDER BY CreatedDate ASC
