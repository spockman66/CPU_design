// See LICENSE for license details.

#ifndef _ENV_PHYSICAL_SINGLE_CORE_H
#define _ENV_PHYSICAL_SINGLE_CORE_H

#include "../encoding.h"
//-----------------------------------------------------------------------
// Begin Macro
//-----------------------------------------------------------------------

#define  INITIAL_X    \
        li   x1 , 0;\
        li   x2 , 0;\
        li   x3 , 0;\
        li   x4 , 0;\
        li   x5 , 0;\
        li   x6 , 5;\
        li   x7 , 6;\
        li   x8 , 7;\
        li   x9 , 8;\
        li   x10 , 9;\
        li   x11 , 10;\
        li   x12 , 11;\
        li   x13 , 12;\
        li   x14 , 13;\
        li   x15 , 14;\
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
        li   x16 , 15;\
        li   x17 , 16;\
        li   x18 , 17;\
        li   x19 , 18;\
        li   x20 , 19;\
        li   x21 , 20;\
        li   x22 , 21;\
        li   x23 , 22;\
        li   x24 , 23;\
        li   x25 , 24;\
        li   x26 , 25;\
        li   x27 , 26;\
        li   x28 , 27;\
        li   x29 , 28;\
        li   x30 , 29;\
        li   x31 , 30;\
/*#`endnif N100_CFG_REGNUM_IS_16*/\

#define RVTEST_RV64U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV64UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV32U                                                    \
  .macro init;                                                          \
  .endm

#define RVTEST_RV32UF                                                   \
  .macro init;                                                          \
  RVTEST_FP_ENABLE;                                                     \
  .endm

#define RVTEST_RV64M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV64S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#define RVTEST_RV32M                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_MACHINE;                                                \
  .endm

#define RVTEST_RV32S                                                    \
  .macro init;                                                          \
  RVTEST_ENABLE_SUPERVISOR;                                             \
  .endm

#if __riscv_xlen == 64
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bgez a0, 1f; RVTEST_PASS; 1:
#else
# define CHECK_XLEN li a0, 1; slli a0, a0, 31; bltz a0, 1f; RVTEST_PASS; 1:
#endif

#define INIT_PMP                                                        \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  li t0, -1;        /* Set up a PMP to permit all accesses */           \
  csrw pmpaddr0, t0;                                                    \
  li t0, PMP_NAPOT | PMP_R | PMP_W | PMP_X;                             \
  csrw pmpcfg0, t0;                                                     \
  .align 2;                                                             \
1:

#define INIT_CLIC                                                       \
  li   x8, -1;                                                          \
  csrw CSR_MCLICLVL, x8;                                                \
  csrw CSR_MCLICIE, x8;                                                 \


#define INIT_SPTBR                                                      \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  csrwi sptbr, 0;                                                       \
  .align 2;                                                             \
1:

#define DELEGATE_NO_TRAPS                                               \
  la t0, 1f;                                                            \
  csrw mtvec, t0;                                                       \
  csrwi medeleg, 0;                                                     \
  csrwi mideleg, 0;                                                     \
  csrwi mie, 0;                                                         \
  .align 2;                                                             \
1:

#define RVTEST_ENABLE_SUPERVISOR                                        \
  li a0, MSTATUS_MPP & (MSTATUS_MPP >> 1);                              \
  csrs mstatus, a0;                                                     \
  li a0, SIP_SSIP | SIP_STIP;                                           \
  csrs mideleg, a0;                                                     \

#define RVTEST_ENABLE_MACHINE                                           \
  li a0, MSTATUS_MPP;                                                   \
  csrs mstatus, a0;                                                     \

#define RVTEST_FP_ENABLE                                                \
  li a0, MSTATUS_FS & (MSTATUS_FS >> 1);                                \
  csrs mstatus, a0;                                                     \
  csrwi fcsr, 0

#define NONVEC_HANDLER_TRICK                                            \
    li a0, 0;                                                           \
    li a1, 0;                                                           \
    li a2, 0;                                                           \
    li a3, 0;                                                           \
    li a4, 0;                                                           \
    li a5, 0;                                                           \
    li t0, 0;                                                           \
    li t1, 0;                                                           \
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
    li t2, 0;                                                           \
    li a6, 0;                                                           \
    li a7, 0;                                                           \
    li t3, 0;                                                           \
    li t4, 0;                                                           \
    li t5, 0;                                                           \
    li t6, 0;                                                           \
/*#`endnif N100_CFG_REGNUM_IS_16*/\

#define RISCV_MULTICORE_DISABLE                                         \
  csrr a0, mhartid;                                                     \
  1: bnez a0, 1b
#define JUDGE_MCAUSE_VECTOR_HANDLER_CLOSE_IRQ\
        li a1,0xfff;\
        csrr a0, mcause;\
        and a0,a0,a1; /*fliter out exccode*/\
        li a1,0x0;  /*software irq id*/\
        beq a0,a1,close_soft_irq; \
        li a1,0x1;  /*timer irq id*/\
        beq a0,a1,close_timer_irq; \
        li a1,0x2;  /*plic irq id*/\
        beq a0,a1,close_bwe_irq; \
        li a1, 0x3;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq3_irq; \
        li a1, 0x4;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq4_irq; \
        li a1, 0x5;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq5_irq; \
        li a1, 0x6;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq6_irq; \
        li a1, 0x7;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq7_irq; \
        li a1, 0x8;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq8_irq; \
        li a1, 0x9;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq9_irq; \
        li a1, 0xa;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq10_irq; \
        li a1, 0xb;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq11_irq; \
        li a1, 0xc;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq12_irq; \
        li a1, 0xd;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq13_irq; \
        li a1, 0xe;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq14_irq; \
        li a1, 0xf;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq15_irq; \
        li a1, 0x10;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq16_irq; \
        li a1, 0x11;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq17_irq; \
        li a1, 0x12;  /*internal irq id*/\
        beq a0,a1,vector_handler_close_irq18_irq; \
        li a1, 0x13;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq19_irq; \
        li a1, 0x14;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq20_irq; \
        li a1, 21;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq21_irq; \
        li a1, 22;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq22_irq; \
        li a1, 23;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq23_irq; \
        li a1, 24;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq24_irq; \
        li a1, 25;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq25_irq; \
        li a1, 26;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq26_irq; \
        li a1, 27;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq27_irq; \
        li a1, 28;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq28_irq; \
        li a1, 29;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq29_irq; \
        li a1, 30;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq30_irq; \
        li a1, 31;  /*external irq id*/\
        beq a0,a1,vector_handler_close_irq31_irq; \

#define EXTRA_TVEC_USER
#define EXTRA_TVEC_MACHINE
#define EXTRA_INIT
#define EXTRA_INIT_TIMER

#define INTERRUPT_HANDLER \
j other_exception;\


#define RVTEST_CODE_BEGIN                                               \
        .section .text.init;                                            \
        .align  6;                                                      \
        .weak stvec_handler;                                            \
        .weak mtvec_handler;                                            \
        .weak nmi_handlers;                                            \
        .weak user_trap_vector;                                            \
        .weak illegal_instruction_handler_pit;\
        .weak u_illegal_instruction_handler_pit;\
        .weak clic_user_trap_vector;                                            \
        .weak standard_clic_mtvt2_handler; \
        .weak standard_clic_mnxti_handler; \
        .weak test_wfi1; \
        .weak test_wfi2; \
        .globl _start;                                                  \
_start:                                                                 \
  mtvt_base: \
  .option norvc \
/*irq_0*/  .word vector_irq_handler;                                                          \
/*irq_1*/  .word vector_irq_handler;                                                          \
/*irq_2*/  .word vector_irq_handler;                                                          \
/*irq_3*/  .word vector_irq_handler;                                                          \
/*irq_4*/  .word vector_irq_handler;                                                          \
/*irq_5*/  .word vector_irq_handler;                                                          \
/*irq_6*/  .word vector_irq_handler;                                                          \
/*irq_7*/  .word vector_irq_handler;                                                          \
/*irq_8*/  .word vector_irq_handler;                                                          \
/*irq_9*/  .word vector_irq_handler;                                                          \
/*irq_10*/  .word vector_irq_handler;                                                          \
/*irq_11*/  .word vector_irq_handler;                                                          \
/*irq_12*/  .word vector_irq_handler;                                                          \
/*irq_13*/  .word vector_irq_handler;                                                          \
/*irq_14*/  .word vector_irq_handler;                                                          \
/*irq_15*/  .word vector_irq_handler;                                                          \
/*irq_16*/  .word vector_irq_handler;                                                          \
/*irq_17*/  .word vector_irq_handler;                                                          \
/*irq_18*/  .word vector_irq_handler;                                                          \
/*irq_19*/  .word vector_irq_handler;                                                          \
/*irq_20*/  .word vector_irq_handler;                                                          \
/*irq_21*/  .word vector_irq_handler;                                                          \
/*irq_22*/  .word vector_irq_handler;                                                          \
/*irq_23*/  .word vector_irq_handler;                                                          \
/*irq_24*/  .word vector_irq_handler;                                                          \
/*irq_25*/  .word vector_irq_handler;                                                          \
/*irq_26*/  .word vector_irq_handler;                                                          \
/*irq_27*/  .word vector_irq_handler;                                                          \
/*irq_28*/  .word vector_irq_handler;                                                          \
/*irq_29*/  .word vector_irq_handler;                                                          \
/*irq_30*/  .word vector_irq_handler;                                                          \
/*irq_31*/  .word vector_irq_handler;                                                          \
/*irq_32*/  .word vector_irq_handler;                                                          \
        .align 7;                                                       \
  mtvec_base: \
        j common_base_handler; \
        INITIAL_X ;               \
        j  reset_vector;                                                \
        .align 2;                                                       \
\
trap_vector:                                                            \
        /* test whether the test came from pass/fail */                 \
        /* Bob: since we have added the random irq */                   \
        /* Bob:  we need to save-and-restore the registers: begin */    \
        csrw mscratch, a0;                                              \
        la  a0, test_trap_data ;                                        \
        sw t1, 0(a0);                                                   \
        sw t2, 4(a0);                                                   \
  .pushsection .data; \
  .align 2; \
  test_trap_data: \
  .word 0; \
  .word 0; \
  .popsection \
/*upper code is used for compatibility of old ccts, there is no use for new ccts*/\
        /* was it an interrupt or an exception? */                      \
        csrr t1, mcause;                                                \
        bgez t1, handle_exception;                                      \
  handle_exception:                                                       \
        li t1, 0xfff;                                                       \
        csrr t2, mcause;                                                    \
        and t1, t2, t1;                                                 \
        li t2, CAUSE_USER_ECALL;                                        \
        beq t1, t2, write_tohost;                                       \
        li t2, CAUSE_SUPERVISOR_ECALL;                                  \
        beq t1, t2, write_tohost;                                       \
        li t2, CAUSE_MACHINE_ECALL;                                     \
        beq t1, t2, write_tohost;                                       \
        /* Bob: Here to check bus-error : Begin */                   \
        li t2, CAUSE_ILLEGAL_INSTRUCTION;                                     \
        beq t1, t2, illegal_instruction_handler;                                      \
        li t2, CAUSE_FETCH_ACCESS;                                     \
        beq t1, t2, ifetch_error_handler;                                      \
        li t2, CAUSE_LOAD_ACCESS;                                     \
        beq t1, t2, load_error_handler;                                      \
        li t2, CAUSE_STORE_ACCESS;                                     \
        beq t1, t2, store_error_handler;                                      \
        li t2, CAUSE_BREAKPOINT;                                        \
        beq t1, t2, ebreak_handler;                                     \
        li t2, CAUSE_MISALIGNED_FETCH;                                        \
        beq t1, t2, misaligned_fetch_handler;                                     \
        li t2,CAUSE_MISALIGNED_LOAD;                                        \
        beq t1, t2, misaligned_load_handler;                                     \
        li t2,CAUSE_MISALIGNED_STORE;                                        \
        beq t1, t2, misaligned_store_handler;                                     \
        /* Bob: Here to check bus-error : end */      \
        /* if an mtvec_handler is defined, jump to it */                \
        /*la t1, mtvec_handler; */\
        /*beqz t1, 1f;*/                                                    \
        /*jr t1;*/                                                          \
  other_exception:                                                      \
        /* some unhandlable exception occurred */                       \
        /* Bob add IRQ Cause here: begin */                       \
  trap_vector_restore_rountine:\
      /*--- Restore ABI registers with interrupts enabled -(14)*/\
        lw ra, 18*4(sp);       /* Restore return address*/\
/*#`ifndef N100_CFG_REGNUM_IS_16 */\
        lw t6, 17*4(sp);    /* Restore temporaries.*/\
        lw t5, 16*4(sp);    /* Restore temporaries.*/\
        lw t4, 15*4(sp);    /* Restore temporaries.*/\
        lw t3, 14*4(sp);    /* Restore temporaries.*/\
/*#`endnif N100_CFG_REGNUM_IS_16 */\
        lw t2, 13*4(sp);    /* Restore temporaries.*/\
        lw t1, 12*4(sp);    /* Restore temporaries.*/\
        lw t0, 11*4(sp);    /* Restore temporaries.*/\
/*#`ifndef N100_CFG_REGNUM_IS_16 */\
        lw a7, 10*4(sp);    /* Restore other arguments.*/\
        lw a6, 9*4(sp);    /* Restore other arguments.*/\
/*#`endnif N100_CFG_REGNUM_IS_16 */\
        lw a5, 8*4(sp);    /* Restore other arguments.*/\
        lw a4, 7*4(sp);    /* Restore other arguments.*/\
        lw a3, 6*4(sp);    /* Restore other arguments.*/\
        lw a1, 4*4(sp);       /* Get saved mcause,*/\
        lw a0, 3*4(sp);       /* Get saved mepc.*/\
        bgez a1, 1f;            /*ignore saving xstatus if exception happens*/\
        /*la a2,standard_clic_mnxti_handler; if define standard_clic_mnxti_handler, ignore saving xstatus*/\
        /*bnez a2,trap_vector_ignore_xstatus_save;*/\
        /*lw a2, 5*4(sp);    Get saved xstatus*/\
        /*csrw CSR_XSTATUS, a2;   Restore previous context.*/\
trap_vector_ignore_xstatus_save:\
1:      csrw mcause, a1;         /* Restore previous context.*/\
        csrw mepc, a0 ;          /* Restore previous context.*/\
        lw a2, 2*4(sp);         /*Restore original a2 value.*/\
        lw a0, 1*4(sp) ;      /* Restore original a1 value.*/\
        lw a1, 0*4(sp);       /* Restore original a0 value.*/\
        addi sp, sp, 20*4;/* Reclaim stack space.*/\
        mret;\
  write_tohost:                                                         \
        /*Bob added code to enable the interrupt enables: begin*/       \
        csrw mscratch, 0x1;/*This is to tell testbench this point*/        \
        li a0, MSTATUS_MIE;                                             \
        csrs mstatus, a0;                                               \
        /*Bob added code to enable the interrupt enables: end*/         \
        sw TESTNUM, tohost, t1;                                         \
        j write_tohost;                                                 \
        /* Bob add IRQ handler here: begin */                       \
  ifetch_error_handler:                                                         \
  load_error_handler:                                                         \
  store_error_handler:                                                         \
  misaligned_fetch_handler:                                                         \
        csrr a0, mbadaddr;                                              \
        j trap_vector_restore_rountine;\
  illegal_instruction_handler:\
        csrr a0, mbadaddr;                                              \
        la a0, illegal_instruction_handler_pit;\
        beqz a0, trap_vector_restore_rountine;                                                    \
        jr a0;\
  misaligned_load_handler:                                               \
  misaligned_store_handler:                                              \
  ebreak_handler:                                                         \
        csrr a0, mbadaddr;                                              \
        lw ra, 18*4(sp);       /* Restore return address*/\
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
        lw t6, 17*4(sp);    /* Restore temporaries.*/\
        lw t5, 16*4(sp);    /* Restore temporaries.*/\
        lw t4, 15*4(sp);    /* Restore temporaries.*/\
        lw t3, 14*4(sp);    /* Restore temporaries.*/\
/*#`endnif N100_CFG_REGNUM_IS_16*/\
        lw t2, 13*4(sp);    /* Restore temporaries.*/\
        lw t1, 12*4(sp);    /* Restore temporaries.*/\
        lw t0, 11*4(sp);    /* Restore temporaries.*/\
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
        lw a7, 10*4(sp);    /* Restore other arguments.*/\
        lw a6, 9*4(sp);    /* Restore other arguments.*/\
/*#`endnif N100_CFG_REGNUM_IS_16*/\
        lw a5, 8*4(sp);    /* Restore other arguments.*/\
        lw a4, 7*4(sp);    /* Restore other arguments.*/\
        lw a3, 6*4(sp);    /* Restore other arguments.*/\
       /* lw a2, 5*4(sp);     doesn't need to restore xstatus in ebreak.*/\
        lw a1, 4*4(sp);       /* Get saved mcause,*/\
        lw a0, 3*4(sp);       /* Get saved mepc.*/\
        csrw mcause, a1;         /* Restore previous context.*/\
        addi a0,a0,0x04;                                                \
        csrw mepc, a0 ;          /* Restore previous context.*/\
        lw a2, 2*4(sp) ;      /* Restore original a2 value.*/\
        lw a0, 1*4(sp) ;      /* Restore original a0 value.*/\
        lw a1, 0*4(sp);       /* Restore original a1 value.*/\
        addi sp, sp, 20*4;/* Reclaim stack space.*/\
/*swith to machine mode*/\
        li a0, MSTATUS_MPP;\
        csrs mstatus, a0;                                                     \
        mret;\
.align 2;\
  vector_irq_handler:                                                         \
  clic_label:                                                         \
        addi sp, sp, -10*4;     \
        sw a0, 0*4(sp);           /* Save a0.*/ \
        sw a1, 1*4(sp);           /* Save a1.*/ \
        sw a2, 2*4(sp);           /* Save a1.*/ \
        csrr a0, mcause;         /* Get mcause of interrupted context.*/ \
        sw a0,3*4(sp);       /* Save a0.*/ \
        csrr a1, mepc;           /* Get mepc of interrupt context.*/ \
        sw a1, 4*4(sp);       /* Save mepc.*/ \
        /*csrr a2, CSR_XSTATUS; Get xstatus of interrupt context.*/ \
        /*sw a2, 5*4(sp);     Save xstatus*/\
        csrsi mstatus,  0x8;/*enable interrupt*/\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
   csrrw a2, CSR_MSCRATCHCSW, a1;        \
   csrrw a2, CSR_MSCRATCHCSWL, a1;        \
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
/*#`ifdef N100_CFG_SHARE_MULDIV */\
        div a0,a1,a0;\
/*#`endif N100_CFG_SHARE_MULDIV */\
/*#`ifdef N100_CFG_INDEP_MULDIV */\
        div a0,a1,a0;\
/*#`endif N100_CFG_INDEP_MULDIV */\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        nop;\
        csrci mstatus,  0x8; /*disable interrupt*/\
        /*lw a2, 5*4(sp);        Get saved xstatus.*/\
        /*csrw CSR_XSTATUS, a2 ;           Restore previous context.*/\
        lw a1, 4*4(sp);      /* Get saved mepc.*/\
        csrw mepc, a1 ;          /* Restore previous context.*/\
        lw a0, 3*4(sp) ;      /* Get saved mcause*/\
        csrw mcause, a0;         /* Restore previous context.*/\
        JUDGE_MCAUSE_VECTOR_HANDLER_CLOSE_IRQ;\
        j trap_rountine1;\
  close_soft_irq: \
        li a0,  0x1000;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  close_timer_irq: \
        li a0,0x1001;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  close_bwe_irq: \
        li a0,0x1002;       \
        csrw mscratch, a0;/*use to stop corresponding interrupt when counting to 32*/ \
        j  trap_rountine1; \
  vector_handler_close_irq3_irq: \
        li a0,0x1003;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq4_irq: \
        li a0,0x1004;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq5_irq: \
        li a0,0x1005;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq6_irq: \
        li a0,0x1006;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq7_irq: \
        li a0,0x1007;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq8_irq: \
        li a0,0x1008;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq9_irq: \
        li a0,0x1009;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq10_irq: \
        li a0,0x100a;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq11_irq: \
        li a0,0x100b;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq12_irq: \
        li a0,0x100c;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq13_irq: \
        li a0,0x100d;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq14_irq: \
        li a0,0x100e;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq15_irq: \
        li a0,0x100f;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq16_irq: \
        li a0,0x1010;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq17_irq: \
        li a0,0x1011;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq18_irq: \
        li a0,0x1012;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq19_irq: \
        li a0,0x1013;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq20_irq: \
        li a0,0x1014;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq21_irq: \
        li a0,0x1015;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq22_irq: \
        li a0,0x1016;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq23_irq: \
        li a0,0x1017;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq24_irq: \
        li a0,0x1018;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq25_irq: \
        li a0,0x1019;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq26_irq: \
        li a0,0x101a;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq27_irq: \
        li a0,0x101b;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq28_irq: \
        li a0,0x101c;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq29_irq: \
        li a0,0x101d;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq30_irq: \
        li a0,0x101e;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  vector_handler_close_irq31_irq: \
        li a0,0x101f;       \
        csrw mscratch, a0; \
        j  trap_rountine1; \
  trap_rountine1:\
        lw a2, 2*4(sp);       /* Restore original a2 value.*/\
        lw a1, 1*4(sp);       /* Restore original a1 value.*/\
        lw a0, 0*4(sp);       /* Restore original a0 value.*/\
        addi sp, sp, 10*4;/* Reclaim stack space.*/\
        mret;   /*jump back to the saved mepc*/                                \
  .align 12; \
  common_base_handler:        \
    addi sp, sp, -20*4;      \
    sw a1, 0*4(sp);           /* Save a1.*/ \
    csrr a1, mcause;         /* Get mcause of interrupted context.*/ \
    sw a0,1*4(sp);       /* Save a0.*/ \
    csrr a0, mepc;           /* Get mepc of interrupt context.*/ \
    sw a2,2*4(sp);       /* Save a2.*/ \
    la a2,standard_clic_mnxti_handler; /*if define standard_clic_mnxti_handler, ignore saving xstatus*/\
    bnez a2,ignore_xstatus_save;\
    /*csrr a2,CSR_XSTATUS; Get xstatus of interrupt context.*/\
    /*sw a2, 5*4(sp);     Save xstatus of interrupted context.*/ \
ignore_xstatus_save: \
    sw a0, 3*4(sp);       /* Save mepc.*/ \
    sw a1, 4*4(sp);       /* Save mcause of interrupted context.*/ \
    sw a3, 6*4(sp);    /* Save other argument registers.*/ \
    sw a4, 7*4(sp);    /* Save other argument registers.*/ \
    sw a5, 8*4(sp);    /* Save other argument registers.*/ \
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
    sw a6, 9*4(sp);    /* Save other argument registers.*/ \
    sw a7, 10*4(sp);    /* Save other argument registers.*/ \
/*#`endnif N100_CFG_REGNUM_IS_16 */\
    sw t0, 11*4(sp);    /* Save temporaries.*/ \
    sw t1, 12*4(sp);    /* Save temporaries.*/ \
    sw t2, 13*4(sp);    /* Save temporaries.*/ \
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
    sw t3, 14*4(sp);    /* Save temporaries.*/ \
    sw t4, 15*4(sp);    /* Save temporaries.*/ \
    sw t5, 16*4(sp);    /* Save temporaries.*/ \
    sw t6, 17*4(sp);    /* Save temporaries.*/ \
/*#`endnif N100_CFG_REGNUM_IS_16*/\
    sw ra, 18*4(sp);       /* 1 return address (5)*/ \
    la t1, clic_user_trap_vector; /* If clic_user_trap_vector is defined, jump to clic_user_trap_vector */ \
    beqz t1, 1f;             \
	jr t1;                   \
  1:                           \
    la t1, user_trap_vector; /* If user_trap_vector is defined, jump to user_trap_vector */ \
    beqz t1, 2f;             \
	jr t1;                   \
  2:                           \
    bgez a1, trap_vector;     /* Handle synchronous exception. (3)*/ \
    csrr a0, mtvec;                         \
    andi a0, a0, 0x3f;\
    li a1, 0x3;\
    bne a0,a1,trap_vector; /*if mtvec[5:0]!=0b000011 which means it's in clint mode, jump to trap_vector*/\
reset_vector:                                                           \
        /*Bruce allocate stack point end address*/          \
		.option push;                                       \
		.option norelax;                                    \
		la gp, __global_pointer$;                             \
		.option pop;                                           \
        la t0, _sp;                                                      \
        mv sp, t0;                                                      \
        /* Bob Initialize t1 and t2 here: Begin */                       \
        mv t1, x0;                                                  \
        mv t2, x0;                                                  \
        /* Bob Initialize t1 and t2 here: End */                       \
        RISCV_MULTICORE_DISABLE;                                        \
        /*INIT_SPTBR;*/                                                     \
        /*INIT_PMP;*/                                                       \
        /*DELEGATE_NO_TRAPS;*/                                              \
        /*li TESTNUM, 0; */                                                 \
        /*Bob added code to enable the interrupt enables: begin*/              \
        /*li a0, MSTATUS_MIE;*/                                                   \
        /*csrs mstatus, a0;  */                                                   \
        li a0, 0xFFFFFFFF;                                                   \
        csrs mie, a0;                                                     \
        /*Bob added code to enable the interrupt enables: End*/              \
        /*la t0,  nmi_interrupt;*/\
        /*csrw CSR_MNVEC, t0;*/\
        la t0, common_base_handler;                                             \
        csrw mtvec, t0;                                                 \
        la t0, mtvt_base;                                             \
        csrw CSR_MTVT, t0;                                                 \
        /*csrr t1, CSR_MISC_CTL;*/                                             \
        /*li t2, 0x200;        */                                             \
        /*or t1,t1,t2;         */                                               \
        /*csrw CSR_MISC_CTL,t1;*/                                                  \
        csrw mscratch, 0x5;/*This is to tell testbench this point*/ \
        /*CHECK_XLEN;*/                                                     \
        /* if an stvec_handler is defined, delegate exceptions to it */ \
        /*Close NMI force*/\
        /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/\
        li  t0 , 0x00050000 ; \
        csrw 0x340 , t0 ;     \
        /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/\
post_mtvec:                                            \
        /* Set MPIE and MPP*/              \
        li a0, MSTATUS_MPIE | MSTATUS_MPP;                                                   \
        csrs mstatus, a0;                                                     \
        init;                                                           \
        EXTRA_INIT;                                                     \
        EXTRA_INIT_TIMER;                                               \
        INIT_CLIC;                                                  \
        li t0, 0xffffffff;                                              \
        csrw mie,t0;                                                    \
        /*#`ifdef N100_CFG_HAS_SCP*/                                   \
        /*csrsi CSR_SCPCTRL, 0x1;  */                                  \
        /*#`endif N100_CFG_HAS_SCP*/                                   \
        la t0, 1f;                                                      \
        csrw mepc, t0;                                                  \
        csrr a0, mhartid;                                               \
        mret;                                                           \
1:

//-----------------------------------------------------------------------
// End Macro
//-----------------------------------------------------------------------

#define RVTEST_CODE_END                                                 \
        unimp

//-----------------------------------------------------------------------
// Pass/Fail Macro
//-----------------------------------------------------------------------

#define RVTEST_PASS                                                     \
        fence;                                                          \
        la t0, _sp;                                                      \
        mv sp, t0;                                                      \
        li gp, 1;                                                  \
        ecall; \
        nop ;\
        nop  


#define TESTNUM tp
#define RVTEST_FAIL                                                     \
        fence;                                                          \
        li TESTNUM, 0;                                                  \
        ecall

//-----------------------------------------------------------------------
// Data Section Macro
//-----------------------------------------------------------------------

#define EXTRA_DATA

#define RVTEST_DATA_BEGIN                                               \
        EXTRA_DATA                                                      \
        .pushsection .tohost,"aw",@progbits;                            \
        .align 6; .global tohost; tohost: .dword 0;                     \
        .align 6; .global fromhost; fromhost: .dword 0;                 \
        .popsection;                                                    \
        .align 4; .global begin_signature; begin_signature:

#define RVTEST_DATA_END .align 4; .global end_signature; end_signature:

#endif
