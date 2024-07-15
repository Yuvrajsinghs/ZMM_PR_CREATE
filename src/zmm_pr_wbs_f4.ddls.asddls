@AbapCatalog.sqlViewName: 'YWBSF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create WBS  F4'
define view ZMM_PR_WBS_F4 as select from I_ActualPlanJournalEntryItem  as a 
                            left outer join ZPS_PROJ_BUDGET_CDS as b on a.WBSElement = b.WBSElement
{
    key cast( a.WBSElement as abap.char( 24 ) )  as WBSElement,
    b.user_id
} 
group by 
a.WBSElement,
 b.user_id
