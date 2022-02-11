# See LICENSE for license details.

#*****************************************************************************
# div_rem.S
#-----------------------------------------------------------------------------
#
# Test divu instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

#`ifdef N22_CFG_HAS_PMP

CLOSE_FORCE_INTERRUPT
pmp_initial:
  li t0, 0x1fffffff ; 
  csrs pmpaddr0, t0 ; 
  li t0, 0x1f ; 
  csrs pmpcfg0, t0 ;  
  la  t0,  switch_mode;
  csrw mtvec, t0;
  li  a3,  0x0;


test_start:
  TEST_RR_BB_OP(2, divu, remu,3,2,20,6);
  TEST_RR_BB_OP(3, divu, remu,0xD27E2,0x1C,0xEF45602,0x123);
  TEST_RR_BB_OP(4, div, rem, -3,-2,-20,6);
  TEST_RR_BB_OP(5, div, rem, 3,-2,-20,-6);
  TEST_RR_BB_OP(6, remu, divu,2,3,20,6);
  TEST_RR_BB_OP(7, remu, divu,0x1C,0xD27E2,0xEF45602,0x123);
  TEST_RR_BB_OP(8, rem, div, -2,-3,-20,6);
  TEST_RR_BB_OP(9, rem, div, -2,3,-20,-6);

# TEST_RR_OP( 2, divu,                   3,  20,   6 );
# TEST_RR_OP( 3, divu,           715827879, -20,   6 );
# TEST_RR_OP( 4, divu,                   0,  20,  -6 );
# TEST_RR_OP( 5, divu,                   0, -20,  -6 );

# TEST_RR_OP( 6, divu, -1<<31, -1<<31,  1 );
# TEST_RR_OP( 7, divu,     0,  -1<<31, -1 );

# TEST_RR_OP( 8, divu, -1, -1<<31, 0 );
# TEST_RR_OP( 9, divu, -1,      1, 0 );
# TEST_RR_OP(10, divu, -1,      0, 0 );
// CAI: add for umode coverage collection.
check_mode:
  ebreak;// transfer to mmode, for sure.
  nop;
  addi a3, a3, 1;
  li  a4, 2;
  beq  a3,a4, endtest;
  j test_start;

endtest: 
  ebreak;
  nop;
  la   t0 ,  common_base_handler            
  csrw mivec , t0         #write mivec
  la t0, trap_vector;
  csrw mtvec,t0 ;
  OPEN_FORCE_INTERRUPT
  j pass

switch_mode:
  li   t0, MSTATUS_MPP;
  li   t1, 1;
  csrs mstatus, t0; //default is mmode;
  bne  a3,t1, 1f; 
  csrc mstatus, t0;
1:csrr t0, mepc;
  addi t0, t0, 4;
  csrw mepc, t0;
  mret

#`endif N22_CFG_HAS_PMP
  j pass
  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
