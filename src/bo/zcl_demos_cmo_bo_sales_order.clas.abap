class ZCL_DEMOS_CMO_BO_SALES_ORDER definition
  public
  inheriting from ZCL_DEMOS_CMO_BO_SALES_DOC
  create public .

public section.
protected section.

  methods DBREAD_QUALITY_DESC
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_DEMOS_CMO_BO_SALES_ORDER IMPLEMENTATION.


  METHOD dbread_quality_desc.

*   local data
    FIELD-SYMBOLS: <lfs_data> TYPE zdemos_cmo_s_bo_soh_all.
    DATA lv_text(200).

*   check
    CHECK mr_data IS NOT INITIAL.
    CHECK ms_vbak IS NOT INITIAL.

*   prepare data access
    ASSIGN mr_data->* TO <lfs_data>.
    CHECK <lfs_data> IS ASSIGNED.

*   build text
    WRITE: 'Sales Order',
           <lfs_data>-key,
           ms_vbak-erdat,
           ms_vbak-netwr CURRENCY ms_vbak-waerk,
           ms_vbak-waerk,
           ms_vbak-kunnr,
           ms_vbak-ihrez
           TO lv_text.

*   fill export
    <lfs_data>-text = lv_text.
    rv_success = abap_true.

  ENDMETHOD.
ENDCLASS.
