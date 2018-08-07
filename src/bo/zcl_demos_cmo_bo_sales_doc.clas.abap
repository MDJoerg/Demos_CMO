class ZCL_DEMOS_CMO_BO_SALES_DOC definition
  public
  inheriting from ZCL_DEMOS_CMO_BO_ROOT
  create public .

public section.

  methods ZIF_DEMOS_CMO_DA~SET_ID
    redefinition .
protected section.

  data MS_VBAK type VBAK .
  data MT_VBAP type VBAP_T .

  methods DBREAD_PREPARE
    redefinition .
  methods DBREAD_QUALITY_DESC
    redefinition .
  methods DBREAD_QUALITY_HDR
    redefinition .
  methods DBREAD_QUALITY_ID
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_DEMOS_CMO_BO_SALES_DOC IMPLEMENTATION.


  METHOD dbread_prepare.

* local data
    DATA: lv_vbeln TYPE vbeln.


* call super
    super->dbread_prepare( ).

* map to vbeln
    CHECK mv_id IS NOT INITIAL.
    lv_vbeln = mv_id.

* select header to cache
    SELECT SINGLE * FROM vbak
      INTO CORRESPONDING FIELDS OF ms_vbak
      WHERE vbeln EQ lv_vbeln.
    IF sy-subrc NE 0.
      " TODO protocol
      EXIT.
    ELSE.
* select items
      SELECT * FROM vbap
        INTO CORRESPONDING FIELDS OF TABLE mt_vbap
        WHERE vbeln EQ lv_vbeln.
    ENDIF.




  ENDMETHOD.


  METHOD dbread_quality_desc.
*   must be redefined - no text per default
    rv_success = abap_true.
  ENDMETHOD.


  METHOD dbread_quality_hdr.

* local data
    FIELD-SYMBOLS: <lfs_data> TYPE data.
    FIELD-SYMBOLS: <lfs_hdr>  TYPE data.


* check cache
    CHECK mr_data IS NOT INITIAL.
    CHECK ms_vbak IS NOT INITIAL.


* prepare data access - data
    ASSIGN mr_data->* TO <lfs_data>.
    CHECK <lfs_data> IS ASSIGNED.

* prepare data access - hdr
    ASSIGN COMPONENT 'HDR' OF STRUCTURE <lfs_data> TO <lfs_hdr>.
    CHECK <lfs_hdr> IS ASSIGNED.


* fill data from cache
    MOVE-CORRESPONDING ms_vbak TO <lfs_hdr>.

* return true
    rv_success = abap_true.

  ENDMETHOD.


  METHOD dbread_quality_id.

* local data
    FIELD-SYMBOLS: <lfs_data> TYPE data.
    FIELD-SYMBOLS: <lfs_key>  TYPE data.


* check cache
    CHECK mr_data IS NOT INITIAL.
    CHECK ms_vbak IS NOT INITIAL.


* prepare data access - data
    ASSIGN mr_data->* TO <lfs_data>.
    CHECK <lfs_data> IS ASSIGNED.

* prepare data access - hdr
    ASSIGN COMPONENT 'KEY' OF STRUCTURE <lfs_data> TO <lfs_key>.
    CHECK <lfs_key> IS ASSIGNED.


* fill data from cache
    <lfs_key> = mv_id.

* return true
    rv_success = abap_true.

  ENDMETHOD.


  METHOD zif_demos_cmo_da~set_id.

* ---- local data
    DATA: lv_vbeln TYPE vbeln.

* ---- convert and set as id
    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = iv_id
      IMPORTING
        output = lv_vbeln.
    mv_id = lv_vbeln.

* ---- fill result
    rr_self = me.

  ENDMETHOD.
ENDCLASS.
