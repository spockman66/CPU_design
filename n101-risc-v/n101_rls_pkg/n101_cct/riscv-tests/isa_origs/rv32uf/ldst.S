# See LICENSE for license details.

#*****************************************************************************
# ldst.S
#-----------------------------------------------------------------------------
#
# This test verifies that flw, fld, fsw, and fsd work properly.
#

#include "riscv_test.h"
#include "test_macros.h"

#`ifdef N100_CFG_FPU_SINGLE

RVTEST_RV32UF
RVTEST_CODE_BEGIN

  TEST_CASE(2, a0, 0x40000000, la a1, tdat; flw f1, 4(a1); fsw f1, 20(a1); lw a0, 20(a1))
  TEST_CASE(3, a0, 0xbf800000, la a1, tdat; flw f1, 0(a1); fsw f1, 24(a1); lw a0, 24(a1))

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
.word 0xbf800000
.word 0x40000000
.word 0x40400000
.word 0xc0800000
.word 0xdeadbeef
.word 0xcafebabe
.word 0xabad1dea
.word 0x1337d00d

RVTEST_DATA_END

#`endif N100_CFG_FPU_SINGLE


#`ifndef N100_CFG_FPU_SINGLE

RVTEST_RV64M
RVTEST_CODE_BEGIN

j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
#`endif N100_CFG_FPU_SINGLE
