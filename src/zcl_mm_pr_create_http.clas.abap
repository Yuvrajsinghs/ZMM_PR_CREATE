class ZCL_MM_PR_CREATE_HTTP definition
  public
  create public .

public section.
  TYPES : BEGIN OF ty,

              Material      TYPE string,
              NpmNumber     TYPE string,
              MaterialDesc  TYPE string,
              Specription   TYPE string,
              Quantity      TYPE string,
              Unit          TYPE string,
              Price         TYPE string,
              Requisitioner TYPE string,
              Costcenter    TYPE string,
              GL            TYPE string,
              Asset         TYPE string,
            END OF ty.

    CLASS-DATA tabdata TYPE TABLE OF ty.

    TYPES : BEGIN OF ty1,
              ordertype   TYPE string,
              purgrp      TYPE string,
              acctass     TYPE string,
              Plant       TYPE string,
              wbs         TYPE string,
              MyFirst_Table LIKE tabdata,
            END OF ty1.

    CLASS-DATA tab1 TYPE ty1.

     CLASS-METHODS :
        get_mat
        IMPORTING VALUE(GL)      TYPE CHAR10
        RETURNING VALUE(GLASRET) TYPE char10,
        AssetAcc
        IMPORTING VALUE(AssetAcc)      TYPE CHAR12
        RETURNING VALUE(AssetAccount) TYPE char12.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_PR_CREATE_HTTP IMPLEMENTATION.


   METHOD AssetAcc.
    DATA ASS TYPE char12.
    ASS = |{ AssetAcc ALPHA = IN }|.
    AssetAccount = ASS.

  ENDMETHOD.


   METHOD get_mat.
    DATA GLASS TYPE char10.
    data hjhj TYPE char10 .
    GLASS = |{ GL ALPHA = IN }|.
    GLASRET = GLASS.

  ENDMETHOD.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
  DATA(body) = request->get_text( ).
   xco_cp_json=>data->from_string( body )->write_to( REF #( tab1 ) ).

   DATA(USERID) = cl_abap_context_info=>get_user_technical_name( ) .



IF tab1-acctass = '1'  .
   MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
         CREATE FIELDS ( purchaserequisitiontype PurReqnDescription )
         AUTO FILL CID
         WITH VALUE #(  ( %cid                    = 'My%CID_1'
                          purchaserequisitiontype = tab1-ordertype ) )

        CREATE BY \_PurchaseRequisitionItem
        FIELDS ( plant
                 Material
                 PurchaseRequisitionItemText
                 accountassignmentcategory
                 requestedquantity
                 purchaserequisitionprice
                 BaseUnit
                 purreqnitemcurrency
                 RequisitionerName
                 yy1_brandname_pri
                 PurReqnSSPAuthor
                 PurReqnOrigin
                 PurchasingGroup

               )
        WITH VALUE #(
                      (    %cid_ref = 'My%CID_1'
                            %target = VALUE #( FOR any IN tab1-myfirst_table INDEX INTO i  ( %cid   = |My%CID_{ i }_001|
                                         "   (  %cid                        = 'My%ItemCID_1'
                                               plant                       = tab1-plant
                                               Material                    = any-material
                                               PurchaseRequisitionItemText = any-materialdesc
                                               accountassignmentcategory   = tab1-acctass
                                               requestedquantity           = any-quantity
                                               purchaserequisitionprice    = any-price
                                               BaseUnit                    = any-unit
                                               purreqnitemcurrency         = 'INR'
                                               RequisitionerName           = any-requisitioner
                                               yy1_brandname_pri           = any-specription
                                               PurReqnSSPAuthor            =  USERID
                                               PurReqnOrigin               =  'S'
                                               PurchasingGroup             = tab1-purgrp

                                              )  )
                       )
                     )
  ENTITY purchaserequisitionitem
  CREATE BY \_purchasereqnacctassgmt
         FIELDS (

                  WBSElementExternalID
                  CostCenter
                  GLAccount
                )
         WITH VALUE #(  FOR any IN tab1-myfirst_table INDEX INTO i1
                        ( %cid_ref = |My%CID_{ i1 }_001|
                          %target  = VALUE #( ( %cid        = |My%acctCID_{ i1 }_1|
                                               WBSElementExternalID =  tab1-wbs
                                               CostCenter           =  zcl_mm_pr_create_http=>get_mat( gl = conv #( ANY-costcenter )  )
                                               GLAccount            =  zcl_mm_pr_create_http=>get_mat( gl = conv #( ANY-gl )  )

                                           )
 ) ) )
      REPORTED DATA(ls_reported)
      MAPPED DATA(ls_mapped)
      FAILED DATA(ls_failed).

  ELSEIF tab1-acctass = '2' .

    MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
         CREATE FIELDS ( purchaserequisitiontype )
         AUTO FILL CID
         WITH VALUE #(  ( %cid                    = 'My%CID_1'
                          purchaserequisitiontype = tab1-ordertype ) )

        CREATE BY \_PurchaseRequisitionItem
        FIELDS ( plant
                 Material
                 PurchaseRequisitionItemText
                 accountassignmentcategory
                 requestedquantity
                 purchaserequisitionprice
                 BaseUnit
                 purreqnitemcurrency
                 RequisitionerName
                 yy1_brandname_pri
                 PurReqnSSPAuthor
                 PurReqnOrigin
                 PurchasingGroup
                 CompanyCode


               )
        WITH VALUE #(
                      (    %cid_ref = 'My%CID_1'
                            %target = VALUE #( FOR any IN tab1-myfirst_table INDEX INTO i  ( %cid   = |My%CID_{ i }_001|
                                         "   (  %cid                        = 'My%ItemCID_1'
                                               plant                       = tab1-plant
                                               Material                    = any-material
                                               PurchaseRequisitionItemText = any-materialdesc
                                               accountassignmentcategory   = tab1-acctass
                                               requestedquantity           = any-quantity
                                               purchaserequisitionprice    = any-price
                                               BaseUnit                    = any-unit
                                               purreqnitemcurrency         = 'INR'
                                               RequisitionerName           = any-requisitioner
                                               yy1_brandname_pri           = any-specription
                                               PurReqnSSPAuthor            = USERID
                                               PurReqnOrigin               =  'S'
                                               PurchasingGroup             = tab1-purgrp
                                               CompanyCode                 = '1000'

                                              )  )
                       )
                     )
  ENTITY purchaserequisitionitem
  CREATE BY \_purchasereqnacctassgmt
         FIELDS (

                  WBSElementExternalID
                  MasterFixedAsset

                )
         WITH VALUE #(  FOR any IN tab1-myfirst_table INDEX INTO i1
                        ( %cid_ref = |My%CID_{ i1 }_001|
                          %target  = VALUE #( ( %cid        = |My%acctCID_{ i1 }_1|
                                               WBSElementExternalID =  tab1-wbs
                                                MasterFixedAsset     = zcl_mm_pr_create_http=>assetacc( AssetAcc = conv #( ANY-asset )  )


                                           )
 ) ) )
      REPORTED ls_reported
      MAPPED ls_mapped
      FAILED ls_failed.

      ELSEIF tab1-acctass = '3' .

    MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
         CREATE FIELDS ( purchaserequisitiontype  )
         AUTO FILL CID
         WITH VALUE #(  ( %cid                    = 'My%CID_1'
                          purchaserequisitiontype = tab1-ordertype
                          ) )

        CREATE BY \_PurchaseRequisitionItem
        FIELDS ( plant
                 Material
                 PurchaseRequisitionItemText
                 accountassignmentcategory
                 requestedquantity
                 purchaserequisitionprice
                 BaseUnit
                 purreqnitemcurrency
                 RequisitionerName
                 yy1_brandname_pri
                 PurReqnSSPAuthor
                 PurReqnOrigin
                 PurchasingGroup

               )
        WITH VALUE #(
                      (    %cid_ref = 'My%CID_1'
                            %target = VALUE #( FOR any IN tab1-myfirst_table INDEX INTO i  ( %cid   = |My%CID_{ i }_001|
                                         "   (  %cid                        = 'My%ItemCID_1'
                                               plant                       = tab1-plant
                                               Material                    = any-material
                                               PurchaseRequisitionItemText = any-materialdesc
                                               accountassignmentcategory   = tab1-acctass
                                               requestedquantity           = any-quantity
                                               purchaserequisitionprice    = any-price
                                               BaseUnit                    = any-unit
                                               purreqnitemcurrency         = 'INR'
                                               RequisitionerName          =  any-requisitioner
                                               yy1_brandname_pri           = any-specription
                                               PurReqnSSPAuthor            =  USERID
                                               PurReqnOrigin               =  'S'
                                               PurchasingGroup             = tab1-purgrp

                                              )  )
                       )
                     )
  ENTITY purchaserequisitionitem
  CREATE BY \_purchasereqnacctassgmt
         FIELDS (

                  WBSElementExternalID
                )
         WITH VALUE #(  FOR any IN tab1-myfirst_table INDEX INTO i1
                        ( %cid_ref = |My%CID_{ i1 }_001|
                          %target  = VALUE #( ( %cid        = |My%acctCID_{ i1 }_1|
                                               WBSElementExternalID =  tab1-wbs

                                           )
 ) ) )
      REPORTED ls_reported
      MAPPED ls_mapped
      FAILED ls_failed.

  else.

    MODIFY ENTITIES OF i_purchaserequisitiontp ENTITY purchaserequisition
         CREATE FIELDS ( purchaserequisitiontype  PurReqnDescription )
         AUTO FILL CID
         WITH VALUE #(  ( %cid                    = 'My%CID_1'
                          purchaserequisitiontype = tab1-ordertype ) )

        CREATE BY \_PurchaseRequisitionItem
        FIELDS ( plant
                 Material
                 PurchaseRequisitionItemText
                 accountassignmentcategory
                 requestedquantity
                 purchaserequisitionprice
                 BaseUnit
                 purreqnitemcurrency
                 RequisitionerName
                 yy1_brandname_pri
                 PurReqnSSPAuthor
                 PurReqnOrigin
                 PurchasingGroup

               )
        WITH VALUE #(
                      (    %cid_ref = 'My%CID_1'
                            %target = VALUE #( FOR any IN tab1-myfirst_table INDEX INTO i  ( %cid   = |My%CID_{ i }_001|
                                         "   (  %cid                        = 'My%ItemCID_1'
                                               plant                       = tab1-plant
                                               Material                    = any-material
                                               PurchaseRequisitionItemText = any-materialdesc
                                               accountassignmentcategory   = tab1-acctass
                                               requestedquantity           = any-quantity
                                               purchaserequisitionprice    = any-price
                                               BaseUnit                    = any-unit
                                               purreqnitemcurrency         = 'INR'
                                               RequisitionerName           =  any-requisitioner
                                               yy1_brandname_pri           = any-specription
                                               PurReqnSSPAuthor            =  USERID
                                               PurReqnOrigin               =  'S'
                                               PurchasingGroup             = tab1-purgrp


                                              )  )
                       )
                     )
      REPORTED ls_reported
      MAPPED ls_mapped
      FAILED ls_failed.

  ENDIF.

  COMMIT ENTITIES
  RESPONSE OF i_purchaserequisitiontp
  FAILED DATA(ls_commit_failed)
  REPORTED DATA(ls_commit_reported).

DATA json TYPE string.
DATA return_data TYPE string.
DATA msz_1       TYPE string.
IF ls_commit_reported IS NOT INITIAL.
if ls_commit_reported-purchaserequisition is NOT INITIAL .
  LOOP AT ls_commit_reported-purchaserequisition ASSIGNING FIELD-SYMBOL(<ls_invoice>).
  IF <ls_invoice>-PurchaseRequisition IS NOT INITIAL .
   return_data  = | PR Created { <ls_invoice>-PurchaseRequisition } |.
  ENDIF.
  ENDLOOP.
ENDIF.
ENDIF.

IF ls_commit_failed IS NOT INITIAL.

   if ls_commit_reported-purchaserequisition is NOT INITIAL .
    DATA(message1) = ls_commit_reported-purchaserequisition[ 1 ]-%msg->if_message~get_text( ).
    msz_1 = |Error For PR Not Created { message1 } |.
    json   =   msz_1.
   return_data = return_data && cl_abap_char_utilities=>cr_lf &&  json .
   ENDIF.

   IF ls_commit_reported-purchaserequisitionitem is NOT INITIAL .
    message1 = ls_commit_reported-purchaserequisitionitem[ 1 ]-%msg->if_message~get_text( ).
    msz_1    =  |Error For PR Not Created { message1 } |.
    json     =   msz_1.
    return_data = return_data && cl_abap_char_utilities=>cr_lf &&  json .
   ENDIF.

   IF ls_commit_reported-purreqnitmaccountassignment Is NOT INITIAL .
    message1 = ls_commit_reported-purreqnitmaccountassignment[ 1 ]-%msg->if_message~get_text( ).
    msz_1    = |Error For PR Not Created { message1 } |.
    json     =   msz_1.
    return_data = return_data && cl_abap_char_utilities=>cr_lf &&  json .
   ENDIF.

ENDIF.

 REPLACE ALL OCCURRENCES OF '\r\n'  IN return_data WITH ''.
    response->set_text( return_data ).

endmethod.
ENDCLASS.
