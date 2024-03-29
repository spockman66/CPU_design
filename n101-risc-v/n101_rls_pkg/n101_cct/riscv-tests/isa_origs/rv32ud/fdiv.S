# See LICENSE for license details.

#*****************************************************************************
# fdiv.S
#-----------------------------------------------------------------------------
#
# Test f{div|sqrt}.d instructions.
#

#include "riscv_test.h"
#include "test_macros.h"

#`ifdef N100_CFG_FPU_DOUBLE
RVTEST_RV64UF
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_D_fdiv( 2,  fdiv.d, 1, 1.1557273520668288, 3.14159265, 2.71828182 );
  TEST_FP_OP2_D_fdiv( 3,  fdiv.d, 1,-0.9991093838555584,      -1234,     1235.1 );
  TEST_FP_OP2_D_fdiv( 4,  fdiv.d, 0,         3.14159265, 3.14159265,        1.0 );

  TEST_FP_OP1_D_fdiv( 5,  fsqrt.d, 1, 1.7724538498928541, 3.14159265 );
  TEST_FP_OP1_D_fdiv( 6,  fsqrt.d, 0,                100,      10000 );

  TEST_FP_OP1_D_DWORD_RESULT_fdiv(16,  fsqrt.d, 0x10,      0x7FF8000000000000,      -1.0 );

  TEST_FP_OP1_D_fdiv( 7,  fsqrt.d, 1, 13.076696830622021, 171.0);

  TEST_FP_OP1_D_fdiv( 8,  fsqrt.d, 1,0.00040099251863345283320230749702, 1.60795e-7);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END

#`endif N100_CFG_FPU_DOUBLE

#`ifndef N100_CFG_FPU_DOUBLE
RVTEST_RV64M
RVTEST_CODE_BEGIN

j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
#`endnif N100_CFG_FPU_DOUBLE
