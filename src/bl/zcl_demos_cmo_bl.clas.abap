class ZCL_DEMOS_CMO_BL definition
  public
  final
  create public .

public section.

  class-methods NEW_INSTANCE
    importing
      !IV_OBJECT_ID type ZDEMOS_CMO_OBJECT_ID
    returning
      value(RR_OBJECT) type ref to ZIF_DEMOS_CMO_DA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_DEMOS_CMO_BL IMPLEMENTATION.


  METHOD new_instance.

* ---- local data
    DATA: ls_cfg TYPE zdemos_cmo_s_bl_cfg.


* ----- select cfg
    SELECT SINGLE * FROM ztc_dm_cmo_obj
      INTO CORRESPONDING FIELDS OF ls_cfg
      WHERE object_id EQ iv_object_id.
    IF sy-subrc EQ 0.
*     create object
      CREATE OBJECT rr_object TYPE (ls_cfg-da_class).
*     set config
      rr_object->set_config( ls_cfg ).
*     set data quality
      IF ls_cfg-da_quality IS NOT INITIAL.
        rr_object->set_quality( ls_cfg-da_quality ).
      ENDIF.
    ELSE.
*      ERROR HANDLING

    ENDIF.


  ENDMETHOD.
ENDCLASS.
