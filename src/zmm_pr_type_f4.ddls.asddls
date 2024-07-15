@AbapCatalog.sqlViewName: 'YPRTYPEF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Type F4'
define view ZMM_PR_TYPE_F4 as select from I_PurchaseRequisitionType as a 

{
    key a.PurchaseRequisitionType,
    _Text[ left outer  where Language = 'E'  ].PurchasingDocumentTypeName
        
} 
where a.PurchaseRequisitionType = 'NB' or a.PurchaseRequisitionType = 'ZDAC' or a.PurchaseRequisitionType = 'ZSER'
