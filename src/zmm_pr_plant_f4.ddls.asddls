@AbapCatalog.sqlViewName: 'YPLANTF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Plant F4'
define view ZMM_PR_PLANT_F4 as select from I_Plant
{
    key Plant,
        PlantName
} where Plant = '1001'
