-- Object_automation-flows
SELECT ApiName,Description,Label,ManageableState,ProcessType 
FROM FlowDefinitionView 
WHERE IsActive = true 
AND Label Like '%Lead%'
LIMIT 200

-- Object_apex-triggers
SELECT ApiVersion,BodyCrc,CreatedBy.Name,LengthWithoutComments,Name,
UsageAfterDelete,UsageAfterInsert,UsageAfterUndelete,UsageAfterUpdate,
UsageBeforeDelete,UsageBeforeInsert,UsageBeforeUpdate,UsageIsBulk 
FROM ApexTrigger WHERE TableEnumOrId = 'Lead'

-- Object_relationship-fields
SELECT DataType,DeveloperName,DurableId,Id,Label,RelationshipName
FROM FieldDefinition
WHERE EntityDefinitionId = 'Lead'
AND RelationshipName != ''
LIMIT 200