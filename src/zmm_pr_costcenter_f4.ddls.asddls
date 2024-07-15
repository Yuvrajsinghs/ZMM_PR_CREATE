@AbapCatalog.sqlViewName: 'YCOSTCENTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Cost CenterF4'
define view ZMM_PR_COSTCENTER_F4 as select from I_CostCenter

{
   key CostCenter,
      _Text[ left outer where Language = 'E' ].CostCenterName 
}
