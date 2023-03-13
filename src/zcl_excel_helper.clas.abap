CLASS zcl_excel_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_column_info,
             column      TYPE i,
             column_name TYPE string,
           END OF ty_column_info.
    TYPES tt_columns_info TYPE STANDARD TABLE OF ty_column_info WITH EMPTY
    KEY.
    DATA lv_table_info TYPE tadir.
    DATA lr_table_struct TYPE REF TO cl_abap_structdescr.
    DATA lr_table_type TYPE REF TO cl_abap_tabledescr.
    DATA lr_table_data TYPE REF TO data.

    METHODS export_file RETURNING VALUE(rv_file_content) TYPE xstring.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_excel_helper IMPLEMENTATION.
  METHOD export_file.
    DATA : lt_excel_struct         TYPE TABLE OF scarr,
           lr_excel_struct         TYPE REF TO data,
           lv_content              TYPE xstring,
           lo_table_row_descriptor TYPE REF TO cl_abap_structdescr,
           lo_source_table_descr   TYPE REF TO cl_abap_tabledescr,
           lv_filename             TYPE bapidocid.

    SELECT * INTO TABLE lt_excel_struct FROM scarr.
    GET REFERENCE OF lt_excel_struct INTO lr_excel_struct.
    DATA(lo_itab_services) = cl_salv_itab_services=>create_for_table_ref(
    lr_excel_struct ).
    lo_source_table_descr ?= cl_abap_tabledescr=>describe_by_data_ref(
    lr_excel_struct ).
    lo_table_row_descriptor ?= lo_source_table_descr->get_table_line_type(
    ).
    DATA(lt_fields) = lo_table_row_descriptor->get_ddic_field_list( p_langu
    = sy-langu ) .

    DATA(lo_tool_xls) = cl_salv_export_tool_ats_xls=>create_for_excel(
    EXPORTING r_data = lr_excel_struct ) .

    DATA(lo_config) = lo_tool_xls->configuration( ).
    LOOP AT lt_fields ASSIGNING FIELD-SYMBOL(<lfs_field>) .
      lo_config->add_column(
      EXPORTING
      header_text = CONV string( <lfs_field>-fieldtext )
      field_name = CONV string( <lfs_field>-fieldname )
      display_type = if_salv_bs_model_column=>uie_text_view
      ).
    ENDLOOP .
    "get excel in xstring
    lo_tool_xls->read_result( IMPORTING content = lv_content ).
    rv_file_content = lv_content.

  ENDMETHOD.

ENDCLASS.
