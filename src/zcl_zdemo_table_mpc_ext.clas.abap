class ZCL_ZDEMO_TABLE_MPC_EXT definition
  public
  inheriting from ZCL_ZDEMO_TABLE_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ZDEMO_TABLE_MPC_EXT IMPLEMENTATION.


  method DEFINE.
    super->define( ).
  endmethod.
ENDCLASS.
