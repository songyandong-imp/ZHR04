*&---------------------------------------------------------------------*
*& Report ZSYD006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyd006.

DATA lv_count TYPE int4.
DATA lt_scarr TYPE STANDARD TABLE OF ztabap_scarr.

START-OF-SELECTION.


  DO 10000 TIMES.

    lv_count = lv_count + 1.

    APPEND VALUE #( id = lv_count carrid = 'AC' carrname = |Air Canada_{ lv_count }|  currcode = 'CNY' url = 'http://www.ac.com' ) TO lt_scarr.

  ENDDO.

  MODIFY ztabap_scarr FROM TABLE lt_scarr.

  CLEAR lt_scarr.

  DO 10000 TIMES.

    lv_count = lv_count + 1.

    APPEND VALUE #( id = lv_count carrid = 'AA' carrname = |American Airlines_{ lv_count }|  currcode = 'USD' url = 'http://www.aa.com' ) TO lt_scarr.

  ENDDO.

  MODIFY ztabap_scarr FROM TABLE lt_scarr.
