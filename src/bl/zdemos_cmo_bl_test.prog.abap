*&---------------------------------------------------------------------*
*& Report  ZDEMOS_CMO_BL_TEST
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zdemos_cmo_bl_test NO STANDARD PAGE HEADING LINE-SIZE 1023.

* --------- interface
PARAMETERS: p_type  TYPE zdemos_cmo_object_id DEFAULT 'SOH'.
PARAMETERS: p_qty   TYPE zdemos_cmo_data_quality DEFAULT zif_demos_cmo_da=>c_quality_hdr.
PARAMETERS: p_id    TYPE swo_typeid OBLIGATORY.


START-OF-SELECTION.

* ----- local data
  DATA: lr_instance TYPE REF TO zif_demos_cmo_da.
  DATA: lr_data     TYPE REF TO data.


* get bl for given object
  lr_instance = zcl_demos_cmo_bl=>new_instance( p_type ).
  IF lr_instance IS INITIAL.
    WRITE: / 'Error. No instance.' COLOR 6.
    EXIT.
  ENDIF.

* set id and data quality
  lr_instance->set_id( p_id ).
  lr_instance->set_quality( zif_demos_cmo_da=>c_quality_hdr ).

* check data
  lr_data ?= lr_instance->get_data( ).
  IF lr_data IS INITIAL.
    WRITE: / 'Error. No Data.' COLOR 6.
    EXIT.
  ENDIF.


END-OF-SELECTION.

* output data
  WRITE: / lr_instance->get_description( ).


* destroy
  lr_instance->destroy( ).
