# See LICENSE for license details.

#*****************************************************************************
# fence.S
#-----------------------------------------------------------------------------
#
# Test self-modifying code and the fence.i instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

li a3, 111
lh a0, insn
lh a1, insn+2

# test I$ hit
.align 6
sh a0, 1f, t0
sh a1, 1f+2, t0
fence

1: addi a3, a3, 222
TEST_CASE( 2, a3, 333, nop )

# test prefetcher hit
li a4, 100
1: addi a4, a4, -1
bnez a4, 1b

sh a0, 1f, t0
sh a1, 1f+2, t0
fence

.align 6
1: addi a3, a3, 555
TEST_CASE( 3, a3, 888, nop )

TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

insn:
  addi a3, a3, 333

RVTEST_DATA_END
