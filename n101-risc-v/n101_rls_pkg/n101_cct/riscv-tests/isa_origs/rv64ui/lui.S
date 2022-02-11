# See LICENSE for license details.

#*****************************************************************************
# lui.S
#-----------------------------------------------------------------------------
#
# Test lui instruction.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64U
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # Basic tests
  #-------------------------------------------------------------

  TEST_CASE( 2, x6, 0x0000000000000000, lui x6, 0x00000 );
  TEST_CASE( 3, x6, 0xfffffffffffff800, lui x6, 0xfffff;sra x6,x6,1);
  TEST_CASE( 4, x6, 0x00000000000007ff, lui x6, 0x7ffff;sra x6,x6,20);
  TEST_CASE( 5, x6, 0xfffffffffffff800, lui x6, 0x80000;sra x6,x6,20);

  TEST_CASE( 6, x0, 0, lui x0, 0x80000 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
