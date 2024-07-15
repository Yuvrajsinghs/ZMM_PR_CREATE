@AbapCatalog.sqlViewName: 'YASSACT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Acct Ass F4'
define view ZMM_PR_ACCT_ASS_F4 as select from I_AccountAssignmentCategory
{
    key AccountAssignmentCategory,
        _Text[ left outer where Language = 'E' ].AcctAssignmentCategoryName 
}
where AccountAssignmentCategory = '1' or  AccountAssignmentCategory = '2' or  AccountAssignmentCategory = '3'
