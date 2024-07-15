@AbapCatalog.sqlViewName: 'YGLF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create GL Account F4'
define view ZMM_PR_GLACCOUNT_F4 as select from I_GLAccount

{
 key GLAccount,
     _Text[ left outer where Language = 'E' ].GLAccountName   
}
