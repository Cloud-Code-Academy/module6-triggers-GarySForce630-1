trigger OpportunityTrigger on Opportunity (before update, after update, before delete) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        OpportunityTriggerHandler.beforeUpdate(Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isDelete) {
        OpportunityTriggerHandler.beforeDelete(Trigger.old);
    }
}