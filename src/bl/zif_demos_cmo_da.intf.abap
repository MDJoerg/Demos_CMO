interface ZIF_DEMOS_CMO_DA
  public .


  constants C_QUALITY_ID type ZDEMOS_CMO_DATA_QUALITY value '0' ##NO_TEXT.
  constants C_QUALITY_DESC type ZDEMOS_CMO_DATA_QUALITY value '1' ##NO_TEXT.
  constants C_QUALITY_HDR type ZDEMOS_CMO_DATA_QUALITY value '2' ##NO_TEXT.
  constants C_QUALITY_HDR_FULL type ZDEMOS_CMO_DATA_QUALITY value '3' ##NO_TEXT.
  constants C_QUALITY_SUB type ZDEMOS_CMO_DATA_QUALITY value '4' ##NO_TEXT.
  constants C_QUALITY_SUB_FULL type ZDEMOS_CMO_DATA_QUALITY value '5' ##NO_TEXT.
  constants C_QUALITY_FULL type ZDEMOS_CMO_DATA_QUALITY value '6' ##NO_TEXT.

  methods GET_DESCRIPTION
    returning
      value(EV_DESCRIPTION) type ZDEMOS_CMO_OBJECT_TEXT .
  methods SET_CONFIG
    importing
      !IS_CONFIG type ZDEMOS_CMO_S_BL_CFG
    returning
      value(RR_SELF) type ref to ZIF_DEMOS_CMO_DA .
  methods SET_ID
    importing
      !IV_ID type DATA
    returning
      value(RR_SELF) type ref to ZIF_DEMOS_CMO_DA .
  methods SET_QUALITY
    importing
      !IV_QUALITY type ZDEMOS_CMO_DATA_QUALITY
    returning
      value(RR_SELF) type ref to ZIF_DEMOS_CMO_DA .
  methods DESTROY .
  methods GET_DATA
    returning
      value(RR_DATA_REF) type ref to DATA .
endinterface.
