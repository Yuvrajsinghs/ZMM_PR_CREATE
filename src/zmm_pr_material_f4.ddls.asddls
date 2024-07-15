@AbapCatalog.sqlViewName: 'YMATF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Material F4'
define view ZMM_PR_MATERIAL_F4 as select from I_Product as a
left outer join I_ProductDescription_2 as b on ( b.Product = a.Product and b.Language = 'E' )
{
   key a.Product,
       a.ManufacturerBookPartNumber,
       b.ProductDescription,
       a.BaseUnit,
       a.YY1_Colour_PRD as colour,
       a.YY1_Model_PRD as model
}
