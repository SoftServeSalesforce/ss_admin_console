public with sharing class UnitOfWorkHelper {
    
    public fflib_SObjectUnitOfWork linkSObjects(List<SObject> data, SObjectType sObjectType) {
        fflib_SObjectUnitOfWork uow = 
            new fflib_SObjectUnitOfWork( 
                new Schema.SObjectType[] {sObjectType});
        return uow;
    }
}