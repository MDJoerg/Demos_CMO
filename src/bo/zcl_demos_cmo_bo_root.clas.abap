CLASS zcl_demos_cmo_bo_root DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_demos_cmo_da .
  PROTECTED SECTION.

    DATA ms_config TYPE zdemos_cmo_s_bl_cfg .
    DATA mv_id TYPE string .
    DATA mv_target_quality TYPE zdemos_cmo_data_quality VALUE 0 ##NO_TEXT.
    DATA mv_current_quality TYPE zdemos_cmo_data_quality VALUE -1 ##NO_TEXT.
    DATA mr_data TYPE REF TO data .

    METHODS dbread_prepare .
    METHODS dbread_quality_id
      RETURNING
        VALUE(rv_success) TYPE abap_bool .


    METHODS dbread_quality_desc
      RETURNING
        VALUE(rv_success) TYPE abap_bool .


    METHODS dbread_quality_hdr
      RETURNING
        VALUE(rv_success) TYPE abap_bool .

    METHODS dbread_quality_hdr_full
      RETURNING
        VALUE(rv_success) TYPE abap_bool .

    METHODS dbread_quality_sub
      RETURNING
        VALUE(rv_success) TYPE abap_bool .

    METHODS dbread_quality_sub_full
      RETURNING
        VALUE(rv_success) TYPE abap_bool .


    METHODS dbread_quality_full
      RETURNING
        VALUE(rv_success) TYPE abap_bool .

    METHODS initialize .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DEMOS_CMO_BO_ROOT IMPLEMENTATION.


  METHOD dbread_prepare.
  ENDMETHOD.


  METHOD dbread_quality_desc.
  ENDMETHOD.


  METHOD dbread_quality_full.

  ENDMETHOD.


  METHOD dbread_quality_hdr.

  ENDMETHOD.


  METHOD dbread_quality_hdr_full.

  ENDMETHOD.


  METHOD dbread_quality_id.
  ENDMETHOD.


  METHOD dbread_quality_sub.

  ENDMETHOD.


  METHOD dbread_quality_sub_full.

  ENDMETHOD.


  METHOD initialize.

* init data quality
    IF ms_config-da_quality IS NOT INITIAL
      AND mv_target_quality IS INITIAL.
      mv_target_quality = ms_config-da_quality.
    ENDIF.

* init data ref
    IF ms_config-da_struc IS NOT INITIAL.
      CREATE DATA mr_data TYPE (ms_config-da_struc).
    ENDIF.

  ENDMETHOD.


  METHOD zif_demos_cmo_da~destroy.
    CLEAR: ms_config,
           mv_id,
           mv_target_quality,
           mr_data.
  ENDMETHOD.


  METHOD zif_demos_cmo_da~get_data.

* ============= checks
* initialized?
    IF mr_data IS INITIAL.
*     intitialize
      initialize( ).
      IF mr_data IS INITIAL.
*      error message to protocol
        "      TODO
*      return w/o data
        EXIT.
      ENDIF.
    ENDIF.


* ============= DB Read functions
* call prepare
    dbread_prepare( ).

* id level (0)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_id( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_id.
      ENDIF.
    ENDIF.

* desc level (1)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_desc( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_desc.
      ENDIF.
    ENDIF.

* hdr level (2)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_hdr( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_hdr.
      ENDIF.
    ENDIF.


* hdr full level (3)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_hdr_full( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_hdr_full.
      ENDIF.
    ENDIF.

* sub level (4)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_sub( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_sub.
      ENDIF.
    ENDIF.

* sub full level (5)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_sub_full( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_sub_full.
      ENDIF.
    ENDIF.


* full level (6)
    IF mv_current_quality LT mv_target_quality.
      IF dbread_quality_full( ) EQ abap_false.
*      error
        " TODO protocol
        EXIT.
      ELSE.
        mv_current_quality = zif_demos_cmo_da=>c_quality_full.
      ENDIF.
    ENDIF.


* ============= read & fill target struc
    rr_data_ref = mr_data.


  ENDMETHOD.


  METHOD zif_demos_cmo_da~get_description.

* local data
    FIELD-SYMBOLS: <lfs_data> TYPE data.
    FIELD-SYMBOLS: <lfs_text> TYPE data.

* set default to instance id
    ev_description = mv_id.

* get assigned data
    CHECK mr_data IS NOT INITIAL.
    ASSIGN mr_data->* TO <lfs_data>.

* assign text field
    ASSIGN COMPONENT 'TEXT' OF STRUCTURE <lfs_data> TO <lfs_text>.
    CHECK <lfs_text> IS ASSIGNED.
    CHECK <lfs_text> IS NOT INITIAL.

* fill text if assigned and not empty
    ev_description = <lfs_text>.

  ENDMETHOD.


  METHOD zif_demos_cmo_da~set_config.
*  store to instance
    ms_config = is_config.

*  call initialize
    initialize( ).

*  return me
    rr_self = me.
  ENDMETHOD.


  METHOD zif_demos_cmo_da~set_id.
    mv_id = iv_id.
    rr_self = me.
  ENDMETHOD.


  METHOD zif_demos_cmo_da~set_quality.
    mv_target_quality = iv_quality.
    rr_self = me.
  ENDMETHOD.
ENDCLASS.
