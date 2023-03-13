CLASS zcl_zdemo_table_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zdemo_table_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.

    METHODS scarrset_get_entityset
        REDEFINITION .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZDEMO_TABLE_DPC_EXT IMPLEMENTATION.


  METHOD scarrset_get_entityset.
    DATA lv_max_hits TYPE i.
    DATA ls_paging TYPE /iwbep/s_mgw_paging.
    DATA lv_table_size TYPE i.
    DATA(lv_filter_string) = io_tech_request_context->get_osql_where_clause_convert( ).
    SELECT * INTO TABLE @DATA(lt_scarr)
    FROM ztabap_scarr WHERE (lv_filter_string) ORDER BY id.
    IF io_tech_request_context->has_count( ).
      es_response_context-count = lines( lt_scarr ).
      RETURN.
    ENDIF.
    ls_paging-top = io_tech_request_context->get_top( ).
    ls_paging-skip = io_tech_request_context->get_skip( ).

    IF ls_paging-top > 0.
      lv_max_hits = is_paging-top + is_paging-skip.
    ENDIF.

    /iwbep/cl_mgw_data_util=>paging( EXPORTING is_paging = ls_paging CHANGING ct_data = lt_scarr ).
    et_entityset = lt_scarr.

  ENDMETHOD.
ENDCLASS.
