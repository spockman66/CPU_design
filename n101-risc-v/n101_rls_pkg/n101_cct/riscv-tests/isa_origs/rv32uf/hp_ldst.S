# See LICENSE for license details.

#*****************************************************************************
# hp_ldst.S
#-----------------------------------------------------------------------------
#
# This test verifies that flhw, and fshw work properly.
#

#include "riscv_test.h"
#include "test_macros.h"


#`ifdef N100_CFG_HAS_NDSE
#`ifdef N100_CFG_FPU_SINGLE

RVTEST_RV32UF
RVTEST_CODE_BEGIN

# SP hex format
.equ  s_psubnorm_min,     0x33800000
.equ  s_psubnorm_max,     0x387FC000
.equ  s_nnorm_min,        0x38800000
.equ  s_pnorm_max,        0x477FE000
.equ  s_pnorm_lt1_max,    0x3F7FE000
.equ  s_one,              0x3F800000
.equ  s_pnorm_gt1_min,    0x3F802000
.equ  s_minus_2,          0xC0000000
.equ  s_zero,             0x00000000
.equ  s_minus_zero,       0x80000000
.equ  s_pinfini,          0x7F800000
.equ  s_ninfini,          0xFF800000
.equ  s_snan,             0xFF800001
.equ  s_qnan,             0xFFC00000
.equ  s_cnan,             0x7FC00000

# HP hex format
.equ  h_psubnorm_min,     0x00000001
.equ  h_psubnorm_max,     0x000003FF
.equ  h_nnorm_min,        0x00000400
.equ  h_pnorm_max,        0x00007BFF
.equ  h_pnorm_lt1_max,    0x00003BFF
.equ  h_one,              0x00003C00
.equ  h_pnorm_gt1_min,    0x00003C01
.equ  h_minus_2,          0x0000C000
.equ  h_zero,             0x00000000
.equ  h_minus_zero,       0x00008000
.equ  h_pinfini,          0x00007C00
.equ  h_ninfini,          0x0000FC00
.equ  h_snan,             0x0000FC01
.equ  h_qnan,             0x0000FE00
.equ  h_cnan,             0x00007E00

#define HP2SP_CVT(testnum, label, exp_sp, exp_hp, offset1, offset2) \
test_ ## testnum:                                 \
  li TESTNUM, testnum;                            \
  la a1, label;                                   \
  flhw f1, offset1(a1);                           \
  fmv.x.w a2, f1;                                 \
  li a0, exp_sp;                                  \
  bne a0, a2, fail;                               \
  fshw f1, offset2(a1);                           \
  lhu a2, offset2(a1);                            \
  li a0, exp_hp;                                  \
  bne a0, a2, fail;

# hp_hex: | 0x00000001           | 0x000003FF           | 0x00000400           | 0x00007BFF               | 0x00003BFF         | 0x00003C00 |      
# sp_hex: | 0x33800000           | 0x387FC000           | 0x38800000           | 0x477FE000               | 0x3F7FE000         | 0x3F800000 |      
#    dec: | 5.960464477539063e-8 | 6.097555160522461e-5 | 6.103515625e-5       | 65504                    | 0.99951171875      | 1          |      
#    bin: | 2^-24                | 2^-14 - 2^-24        | -2^-14               | 2^15 * (1 + (1 - 2^-10)) | 1 - 2^-11          | 1          |      
#  notes: | smallest pos subnorm | largest pos subnorm  | smallest neg subnorm | largest pos norm         | largest number < 1 | one        |  

# hp_hex: | 0x00003C01           | 0x0000C000           | 0x00000000           | 0x00008000               | 0x00007C00         | 0x0000FC00 |     
# sp_hex: | 0x3F802000           | 0xC0000000           | 0x00000000           | 0x80000000               | 0x7F800000         | 0xFF800000 |     
#    dec: | 1.0009765625         | -2                   | 0                    | -0                       | +oo                | -oo        |     
#    bin: | 1 + 2^-10            | -2                   | 0                    | -0                       | +oo                | -oo        |     
#  notes: | smallest number > 1  | -2                   | 0                    | -0                       | pos infini         | neg infini | 

  li a1, MSTATUS_FS
  csrs mstatus, a1    

  HP2SP_CVT( 2, tdat, s_psubnorm_min , h_psubnorm_min ,  0, 32)
  HP2SP_CVT( 3, tdat, s_psubnorm_max , h_psubnorm_max ,  2, 34)
  HP2SP_CVT( 4, tdat, s_nnorm_min    , h_nnorm_min    ,  4, 36)
  HP2SP_CVT( 5, tdat, s_pnorm_max    , h_pnorm_max    ,  6, 38)
  HP2SP_CVT( 6, tdat, s_pnorm_lt1_max, h_pnorm_lt1_max,  8, 40)
  HP2SP_CVT( 7, tdat, s_one          , h_one          , 10, 42)
  HP2SP_CVT( 8, tdat, s_pnorm_gt1_min, h_pnorm_gt1_min, 12, 44)
  HP2SP_CVT( 9, tdat, s_minus_2      , h_minus_2      , 14, 46)
  HP2SP_CVT(10, tdat, s_zero         , h_zero         , 16, 48)
  HP2SP_CVT(11, tdat, s_minus_zero   , h_minus_zero   , 18, 50)
  HP2SP_CVT(12, tdat, s_pinfini      , h_pinfini      , 20, 52)
  HP2SP_CVT(13, tdat, s_ninfini      , h_ninfini      , 22, 54)
  HP2SP_CVT(14, tdat, s_cnan         , h_cnan         , 24, 56)
  HP2SP_CVT(15, tdat, s_cnan         , h_cnan         , 26, 58)

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

tdat:
.word 0x03ff0001   // largest pos subnorm/smallest pos subnorm in HP hex format
.word 0x7bff0400   // largest pos norm/smallest neg subnorm in HP hex format
.word 0x3c003bff   // one/largest number < 1 in HP hex format
.word 0xc0003c01   // -2/smallest number > 1 in HP hex format
.word 0x80000000   // -0/0 in HP hex format
.word 0xfc007c00   // -oo/+oo in HP hex format
.word 0xfe01fc01   // QNaN/SNaN in HP hex format
.word 0x00000000
# @tdat + 32
.word 0xabad1dea
.word 0x1337d00d
.word 0x8767247a
.word 0x15da70fe
.word 0xde0249ad
.word 0x67fa89a0
.word 0x67463476
.word 0x56545684

RVTEST_DATA_END

#`endif N100_CFG_FPU_SINGLE
#`endif N100_CFG_HAS_NDSE


#`ifndef N100_CFG_HAS_NDSE
#`ifndef N100_CFG_FPU_SINGLE

RVTEST_RV64M
RVTEST_CODE_BEGIN

li TESTNUM, 2
j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
#`endnif N100_CFG_FPU_SINGLE
#`endnif N100_CFG_HAS_NDSE


#`ifndef N100_CFG_HAS_NDSE
#`ifdef N100_CFG_FPU_SINGLE

RVTEST_RV64M
RVTEST_CODE_BEGIN

li TESTNUM, 2
j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
#`endif N100_CFG_FPU_SINGLE
#`endnif N100_CFG_HAS_NDSE


#`ifdef N100_CFG_HAS_NDSE
#`ifndef N100_CFG_FPU_SINGLE

RVTEST_RV64M
RVTEST_CODE_BEGIN

li TESTNUM, 2
j pass

TEST_PASSFAIL
RVTEST_CODE_END
  .data
RVTEST_DATA_BEGIN
  TEST_DATA

RVTEST_DATA_END
#`endnif N100_CFG_FPU_SINGLE
#`endif N100_CFG_HAS_NDSE

