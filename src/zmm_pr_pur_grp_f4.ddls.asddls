@AbapCatalog.sqlViewName: 'YPURGROF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Pur Grop F4'
define view ZMM_PR_PUR_GRP_F4 as select from I_PurchasingGroup
{
  key PurchasingGroup  ,
      PurchasingGroupName
}
