@AbapCatalog.sqlViewName: 'YASSETF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Custom PR Create Asset F4'
define view ZMM_PR_ASSET_F4 as select from I_FixedAsset
{
  key MasterFixedAsset,
      AssetClass,
      FixedAssetDescription
}
