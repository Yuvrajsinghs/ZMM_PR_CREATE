@AbapCatalog.sqlViewName: 'YPRF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Create PR Program PR F4'
define view ZMM_PR_F4 as select from I_PurchaseRequisitionAPI01
{
    key PurchaseRequisition
}
