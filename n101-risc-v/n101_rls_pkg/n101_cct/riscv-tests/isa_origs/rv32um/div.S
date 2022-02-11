# See LICENSE for license details.

#*****************************************************************************
# div.S
#-----------------------------------------------------------------------------
#
# Test div instruction.
#

#include "riscv_test.h"
#include "test_macros.h"
#include "test_register.h"

RVTEST_RV32U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------
  li  t0, 0x0;
  li  t1, 0x2;

test_start:
  TEST_RR_OP( 2, div,  3,  20,   6 );
  TEST_RR_OP( 3, div, -3, -20,   6 );
  TEST_RR_OP( 4, div, -3,  20,  -6 );
  TEST_RR_OP( 5, div,  3, -20,  -6 );

  TEST_RR_OP( 6, div, -1<<63, -1<<63,  1 );
  TEST_RR_OP( 7, div, -1<<63, -1<<63, -1 );

  TEST_RR_OP( 8, div, -1, -1<<63, 0 );
  TEST_RR_OP( 9, div, -1,      1, 0 );
  TEST_RR_OP(10, div, -1,      0, 0 );

  // CAI below is just used for rs/rd coverage;
#`ifndef N100_CFG_REGNUM_IS_16 \
  li   s11, 1; // for rs2
  li   t2 , 1; // for rs1
  li   a3 , 1;
  li   a6 , 1;
  li   a7 , 1;
  li   s2 , 1;
  li   s3 , 1;
  li   s4 , 1;
  li   s7 , 1;
  li   s8 , 1;
     
  div  t2, s11, t2;
  div  a7, s11, t2;
  div  a7, a3 , t2;
  div  a7, t2 , t1;
  div  a7, a6 , t2;
  div  a7, a7 , t2;
  div  t2, s2 , a7;
  div  a7, s3 , t2;
  div  a7, s4 , t2;
  div  a7, s7 , t2;
  div  a7, s8 , t2;
#`endnif N100_CFG_REGNUM_IS_16 \


  SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff, 0xff);
check_mode:
  addi t0, t0, 1;
  bne  t1, t1, test_start;


  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
