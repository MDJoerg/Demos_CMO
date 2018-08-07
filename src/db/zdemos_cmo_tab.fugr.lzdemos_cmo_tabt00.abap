*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 25.04.2018 at 13:21:46
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZTC_DM_CMO_OBJ..................................*
DATA:  BEGIN OF STATUS_ZTC_DM_CMO_OBJ                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTC_DM_CMO_OBJ                .
CONTROLS: TCTRL_ZTC_DM_CMO_OBJ
            TYPE TABLEVIEW USING SCREEN '2000'.
*.........table declarations:.................................*
TABLES: *ZTC_DM_CMO_OBJ                .
TABLES: ZTC_DM_CMO_OBJ                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
