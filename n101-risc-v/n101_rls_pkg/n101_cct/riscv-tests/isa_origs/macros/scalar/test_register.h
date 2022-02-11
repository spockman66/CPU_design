// See LICENSE for license details.

#ifndef TEST_REGISTER_H
#define TEST_REGISTER_H

#define mcycle	                0xb00 //MRW
#define minstret       	        0xb02 //MRW
#define mhpmcounter3	        0xb03 //MRW
#define mhpmcounter4	        0xb04 //MRW
#define mhpmcounter5	        0xb05 //MRW
#define mhpmcounter6	        0xb06 //MRW
#define mcycleh	                0xb80 //MRW
#define minstreth	            0xb82 //MRW
#define mhpmcounter3h	        0xb83 //MRW
#define mhpmcounter4h	        0xb84 //MRW
#define mhpmcounter5h	        0xb85 //MRW
#define mhpmcounter6h	        0xb86 //MRW
#define mhpmevent3	            0x323 //MRW
#define mhpmevent4	            0x324 //MRW
#define mhpmevent5	            0x325 //MRW
#define mhpmevent6	            0x326 //MRW
#define mstatus                 0x300 //mrw
#define misa                    0x301 //mrw
#define medeleg                 0x302 //mrw
#define mideleg                 0x303 //mrw
#define mie                     0x304 //mrw
#define mtvec                   0x305 //mrw
#define mcounteren	            0x306 //MRW
#define mtvt                    0x307//MRW
#define mcountinhibit           0x320 //MRW
#define mscratch                0x340 //mrw
#define mepc                    0x341 //mrw
#define mcause                  0x342 //mrw
#define mtval                   0x343 //mrw
#define mip                     0x344 //mrw
#define mnxti                   0x345 //mrw
#define mintstatus              0x346 //mrw
#define mscratchcsw             0x348 //mrw
#define mscratchcswl            0x349 //mrw
#define cycle	                0xc00 //URO
#define time	                0xc01 //URO
#define instret	                0xc02 //URO
#define hpmcounter3	            0xc03 //URO
#define hpmcounter4	            0xc04 //URO
#define hpmcounter5	            0xc05 //URO
#define hpmcounter6	            0xc06 //URO
#define cycleh	                0xc80 //URO
#define timeh	                0xc81 //URO
#define instreth     	        0xc82 //URO
#define hpmcounter3h	        0xc83 //URO
#define hpmcounter4h	        0xc84 //URO
#define hpmcounter5h	        0xc85 //URO
#define hpmcounter6h	        0xc86 //URO
#define mpft_ctl	            0x7c5 //MRW
#define mmisc_ctl	            0x7d0 //MRW
#define mcounterwen	            0x7ce //MRW
#define mcounterinten	        0x7cf //MRW
#define mcountermask_m	        0x7d1 //MRW
#define mcountermask_u	        0x7d3 //MRW
#define mcounterovf	            0x7d4 //MRW1C
#define sleepvalue              0x811 //MRW
#define wfe	                    0x810 //MRW
#define mmsc_cfg                0xfc2 //MRW
#define tinfo                   0x7a4 //MRO
#define mcountinhibit           0x320 //MRW
#define mtvt2                   0x7ec //MRW
#define dscratch1               0x7b3 // D
#define dexc2dbg                0x7e0 // D
#define ddcause                 0x7e1 // D
//ECC
#define milmb                   0x7c0 //MRW
#define mdlmb                   0x7c1 //MRW
#define mecc_code               0x7c2 //MRW

// TMR
#define mtimel                  0x`N100_CFG_TMR_BASE_ADDR` + 0x0000
#define mtimeh                  0x`N100_CFG_TMR_BASE_ADDR` + 0x0004
#define mtimecmpl               0x`N100_CFG_TMR_BASE_ADDR` + 0x0008
#define mtimecmph               0x`N100_CFG_TMR_BASE_ADDR` + 0x000c
#define mstop                   0x`N100_CFG_TMR_BASE_ADDR` + 0x0ff8
#define msip                    0x`N100_CFG_TMR_BASE_ADDR` + 0x0ffc

// N extension
#define ustatus                 0x000 // URW
#define uie                     0x004 // URW
#define utvec                   0x005 // URW
#define uscratch                0x040 // URW
#define uepc                    0x041 // URW
#define ucause                  0x042 // URW
#define utval                   0x043 // URW
#define uip                     0x044 // URW
#define unxti                   0x045 // MRW
#define uintstatus              0x046 // URW
#define jlunxti                 0x847 // URW
#define utvt2                   0x848 // URW
#define pushucause              0x849 // URW
#define pushuepc                0x84a // URW


// zaixin: n100 self-define csr 
#define istatus                              0x310  //mrw
#define nstatus                              0x311  //mrw
#define mivec                                0x312  //mrw
//#define mnvec                                0x313  //mrw
#define msubmode                             0x314  //mro
#define mscratch1                            0x340  //mrw
#define mnpc                                 0x351  //mrw
#define mipc                                 0x352  //mrw
#define dbgstop                              0xbfc  //mrw
#define wfi_mode                             0x811  //mrw
#define txevt                                0x812  //mrw
#define tx_evt                               0x812  //mrw

// zaixin :add trap csr

#define mnvec                                0x7c3  //mrw
#define mxstatus                             0x7c4  //mrw
#define mdcause                              0x7c9  //mrw
#define msavestatus                          0x7d6  //mrw
#define msaveepc1                            0x7d7  //mrw
#define msavecause1                          0x7d8  //mrw
#define msaveepc2                            0x7d9  //mrw
#define msavecause2                          0x7da  //mrw
#define msavedcause1                         0x7db  //mrw
#define msavedcause2                         0x7dc  //mrw

#define uitb                                 0x800  //urw
#define mpft_ctl                             0x7c5  //mrw
#define mmisc_ctl                            0x7d0  //mrw

#define sleepvalue                           0x811  //mrw

#define mfake_dum                            0x7f2  //mrw
#define mfake_gen                            0x7f3  //mrw
#define mmisc_ctl1                           0x7cb  //mrw
#define mlstep_ctrl                          0x7e8  //mrw
#define mlstep_forc                          0x7e9  //mrw

//zaixin: defines config poriority address
#define MSIP_IRQ_ID     3
#define MTIP_IRQ_ID     7
#define PLIC_IRQ_ID     11    

// LZB: add defines for debug etrigger mode
#define ETRIGGER_TYPE       (5<<28)
#define ETRIGGER_DMODE      (1<<27)
#define ETRIGGER_ACTION     (0<<0)
#define ETRIGGER_ACTION_DBG (1<<0)
#define ETRIGGER_M          (1<<9)
#define ETRIGGER_S          (1<<7)
#define ETRIGGER_U          (1<<6)

// LZB: add defines for debug itrigger mode
#define ITRIGGER_TYPE       (4<<28)
#define ITRIGGER_DMODE      (1<<27)
#define ITRIGGER_ACTION     (0<<0)
#define ITRIGGER_ACTION_DBG (1<<0)
#define ITRIGGER_M          (1<<9)
#define ITRIGGER_S          (1<<7)
#define ITRIGGER_U          (1<<6)
#define ITRIGGER_ID1_VLD    (1<<0)
#define ITRIGGER_ID1_TMR    (7<<1)
#define ITRIGGER_ID2_VLD    (1<<16)
#define ITRIGGER_ID1_SFT    (3<<17)

// LZB: add defines for debug icount mode
#define ICOUNT_TYPE         (3<<28)
#define ICOUNT_DMODE        (1<<27)
#define ICOUNT_ACTION       (0<<0)
#define ICOUNT_ACTION_DBG   (1<<0)
#define ICOUNT_C            (1<<10)
#define ICOUNT_M            (1<<9)
#define ICOUNT_S            (1<<7)
#define ICOUNT_U            (1<<6)

// LZB: add defines for decause
#define DCAUSE_PMP_IFETCH   2
#define DCAUSE_PMP_LOAD     2
#define DCAUSE_PMP_STORE    2
#define DCAUSE_BUS_ERR      3
#define DCAUSE_MTVAL        0

// LZB: add defines for decause
#define MSA                 (1<<6)

// LZB: add defines for cause code mask
#define CAUSE_MASK          0xfff

// LZB:  
#define TEST_NUM            tp

// LZB: add defines for CLIC/TMR CSR
#define clicip    0xBD0
#define clicie    0xBD1
#define cliclvl   0xBD2
#define clicedge  0xBD3
#define clicinfo  0xBD4
#define sftip     0xBD8
#define timecmpl  0xBD9
#define timel     0xBDA
#define stop      0xBDB

//zaixin: add some macros read field
#define MSTATUS_MIE_R(test_reg1,test_reg2)\
    csrr test_reg1 , mstatus;\
    li   test_reg2 , 0x8 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 3;\

#define MSTATUS_MPIE_R(test_reg1,test_reg2)\
    csrr test_reg1 , mstatus ;\
    li   test_reg2 , 0x80 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 7 ;\

#define MSTATUS_MPS_R(test_reg1,test_reg2)\
    csrr test_reg1 , mstatus ;\
    li   test_reg2 , 0x300 ;\
    and  test_reg2 , test_reg2 , test_reg1 ;\
    srli test_reg2 , test_reg2 , 8 ;\

#define MSTATUS_MPP_R(test_reg1,test_reg2)\
    csrr test_reg1 , mstatus ;\
    li   test_reg2 , 0x1800 ; \
    and  test_reg2 , test_reg2 , test_reg1 ;\
    srli test_reg2 , test_reg2 , 11 ;\

#define MSAVESTATUS_MPIE1_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x1 ;\
    and  test_reg2 , test_reg2 , test_reg1 ;\
    srli test_reg2 , test_reg2 , 0 ;\

#define MSAVESTATUS_MPP1_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus;\
    li   test_reg2 , 0x6;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 1 ;\

#define MSAVESTATUS_PPFT_EN1_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x8 ;\
    and  test_reg2 , test_reg2 , test_reg1 ;\
    srli test_reg2 , test_reg2 , 3 ;\

#define MSAVESTATUS_PIME1_R(test_reg1,test_reg2)     \
    csrr test_reg1 , msavestatus ;                     \
    li   test_reg2 , 0x10 ;                             \
    and  test_reg2 , test_reg2 , test_reg1 ;           \
    srli test_reg2 , test_reg2 , 4 ;                   \

#define MSAVESTATUS_PDME1_R(test_reg1,test_reg2)     \
    csrr test_reg1 , msavestatus ;                     \
    li   test_reg2 , 0x20 ;                             \
    and  test_reg2 , test_reg2 , test_reg1 ;           \
    srli test_reg2 , test_reg2 , 5 ;                   \

#define MSAVESTATUS_PTYP1_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0xC0 ;\
    and  test_reg2 , test_reg2 , test_reg1; \
    srli test_reg2 , test_reg2 , 6;\

#define MSAVESTATUS_MPIE2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x100 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 8;\

#define MSAVESTATUS_MPP2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x600;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 9;\

#define MSAVESTATUS_PPFT_EN2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x800 ;\
    and  test_reg2 , test_reg2 , test_reg1 ;\
    srli test_reg2 , test_reg2 , 11 ;\

#define MSAVESTATUS_PIME2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x1000 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 12;\

#define MSAVESTATUS_PDME2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0x2000 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 13;\

#define MSAVESTATUS_PTYP2_R(test_reg1,test_reg2)\
    csrr test_reg1 , msavestatus ;\
    li   test_reg2 , 0xC000 ;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 14 ;\

#define MXSTATUS_PFT_EN_R(test_reg1,test_reg2)\
    csrr test_reg1 , mxstatus;\
    li   test_reg2 , 0x1;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 0;\

#define MXSTATUS_PPFT_EN_R(test_reg1,test_reg2)\
    csrr test_reg1 , mxstatus;\
    li   test_reg2 , 0x2;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 1;\

#define MXSTATUS_IME_R(test_reg1,test_reg2)\
    csrr test_reg1 , mxstatus;\
    li   test_reg2 , 0x4;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 2 ;\

#define MXSTATUS_PIME_R(test_reg1,test_reg2)\
    csrr test_reg1 , mxstatus;\
    li   test_reg2 , 0x8;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 3;\

#define MXSTATUS_DME_R(test_reg1,test_reg2)\
    csrr test_reg1 , mxstatus;\
    li   test_reg2 , 0x10;\
    and  test_reg2 , test_reg2 , test_reg1;\
    srli test_reg2 , test_reg2 , 4;\

#define MXSTATUS_PDME_R(test_reg1,test_reg2)         \
    csrr test_reg1 , mxstatus ;                        \
    li   test_reg2 , 0x20 ;                            \
    and  test_reg2 , test_reg2 , test_reg1 ;           \
    srli test_reg2 , test_reg2 , 5 ;                   \

#define MXSTATUS_TYP_R(test_reg1,test_reg2)          \
    csrr test_reg1 , mxstatus ;                        \
    li   test_reg2 , 0xc0 ;                            \
    and  test_reg2 , test_reg2 , test_reg1 ;           \
    srli test_reg2 , test_reg2 , 6 ;                   \

#define MXSTATUS_PTYP_R(test_reg1,test_reg2)         \
    csrr test_reg1 , mxstatus ;                        \
    li   test_reg2 , 0x300 ;                           \
    and  test_reg2 , test_reg2 , test_reg1 ;           \
    srli test_reg2 , test_reg2 , 8 ;                   \

//zaixin: config0 MPIE2 <= MPIE1 <= mstatus.MPIE <= mstatus.MIE <= 0
#define CONFIG_POINT0(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MSTATUS_MIE_R(s0 , s1); \
    MSTATUS_MPIE_R(s0 , a2); \
    MSAVESTATUS_MPIE1_R(s0 , a3); \
    MSAVESTATUS_MPIE2_R(s0 , a4); \
    li t2 , test_num; \

//zaixin :check0 MPIE2 <= MPIE1 <= mstatus.MPIE <= mstatus.MIE <= 0
#define CHECK_POINT0(test_num,test_point) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MSTATUS_MIE_R(s0 , a5); \
    MSTATUS_MPIE_R(s0 , s6); \
    MSAVESTATUS_MPIE1_R(s0 , a0); \
    MSAVESTATUS_MPIE2_R(s0 , a1); \
    point##test_num##0: ;\
    bne a5 , x0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config1 MPP2 <= MPP1 <= mstatus.MPP <= interrupted_mode <= NMI/exception mode
#define CONFIG_POINT1(test_num, test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MSTATUS_MPP_R(s0 , s1); \
    MSAVESTATUS_MPP1_R(s0 , a2); \
    MSAVESTATUS_MPP2_R(s0 , a3); \
    li t2 , test_num; \

//zaixin :check1 MPP2 <= MPP1 <= mstatus.MPP <= interrupted_mode <= NMI/exception mode
#define CHECK_POINT1(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MSTATUS_MPP_R(s0 , a4); \
    MSAVESTATUS_MPP1_R(s0 , a5); \
    MSAVESTATUS_MPP2_R(s0 , s6); \
    point##test_num##0: ;\
    li s0 , imode; \
    bne a4 , s0 , fail ; \
    point##test_num##1: ;\
    bne a5 , s1 , fail ;\
    point##test_num##2: ; \
    bne s6 , a2 , fail;\
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config2 PPFT_EN2 <= PPFT_EN1 <= mxstatus.PPFT_EN <= mxstatus.PFT_EN <= 0/1
#define CONFIG_POINT2(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MXSTATUS_PFT_EN_R(s0 , s1); \
    MXSTATUS_PPFT_EN_R(s0 , a2); \
    MSAVESTATUS_PPFT_EN1_R(s0 , a3); \
    MSAVESTATUS_PPFT_EN2_R(s0 , a4); \
    li t2 , test_num; \

//zaixin :check2 PPFT_EN2 <= PPFT_EN1 <= mxstatus.PPFT_EN <= mxstatus.PFT_EN <= 0/1
#define CHECK_POINT2(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_PFT_EN_R(s0 , a5); \
    MXSTATUS_PPFT_EN_R(s0 , s6); \
    MSAVESTATUS_PPFT_EN1_R(s0 , a0); \
    MSAVESTATUS_PPFT_EN2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config3 PPFT_EN2 <= PPFT_EN1 <= mxstatus.PPFT_EN <= mxstatus.PFT_EN <= 0/1
#define CONFIG_POINT3(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrc test_csr , t2; \
    MXSTATUS_PFT_EN_R(s0 , s1); \
    MXSTATUS_PPFT_EN_R(s0 , a2); \
    MSAVESTATUS_PPFT_EN1_R(s0 , a3); \
    MSAVESTATUS_PPFT_EN2_R(s0 , a4); \
    li t2 , test_num; \

//zaixin :check3 PPFT_EN2 <= PPFT_EN1 <= mxstatus.PPFT_EN <= mxstatus.PFT_EN <= 0/1
#define CHECK_POINT3(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_PFT_EN_R(s0 , a5); \
    MXSTATUS_PPFT_EN_R(s0 , s6); \
    MSAVESTATUS_PPFT_EN1_R(s0 , a0); \
    MSAVESTATUS_PPFT_EN2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \

//zaixin: config4 PIME2 <= PIME1 <= mxstatus.PIME <= mxstatus.IME <= 0/1
#define CONFIG_POINT4(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MXSTATUS_IME_R(s0 , s1); \
    MXSTATUS_PIME_R(s0 , a2); \
    MSAVESTATUS_PIME1_R(s0 , a3); \
    MSAVESTATUS_PIME2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check4 PIME2 <= PIME1 <= mxstatus.PIME <= mxstatus.IME <= 0/1
#define CHECK_POINT4(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_IME_R(s0 , a5); \
    MXSTATUS_PIME_R(s0 , s6); \
    MSAVESTATUS_PIME1_R(s0 , a0); \
    MSAVESTATUS_PIME2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config5 PIME2 <= PIME1 <= mxstatus.PIME <= mxstatus.IME <= 0/1
#define CONFIG_POINT5(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrc test_csr , t2; \
    MXSTATUS_IME_R(s0 , s1); \
    MXSTATUS_PIME_R(s0 , a2); \
    MSAVESTATUS_PIME1_R(s0 , a3); \
    MSAVESTATUS_PIME2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check5 PIME2 <= PIME1 <= mxstatus.PIME <= mxstatus.IME <= 0/1
#define CHECK_POINT5(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_IME_R(s0 , a5); \
    MXSTATUS_PIME_R(s0 , s6); \
    MSAVESTATUS_PIME1_R(s0 , a0); \
    MSAVESTATUS_PIME2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config6 PDME2 <= PDME1 <= mxstatus.PDME <= mxstatus.DME <= 0/1
#define CONFIG_POINT6(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MXSTATUS_DME_R(s0 , s1); \
    MXSTATUS_PDME_R(s0 , a2); \
    MSAVESTATUS_PDME1_R(s0 , a3); \
    MSAVESTATUS_PDME2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check6 PDME2 <= PDME1 <= mxstatus.PDME <= mxstatus.DME <= 0/1
#define CHECK_POINT6(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_DME_R(s0 , a5); \
    MXSTATUS_PDME_R(s0 , s6); \
    MSAVESTATUS_PDME1_R(s0 , a0); \
    MSAVESTATUS_PDME2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config7 PDME2 <= PDME1 <= mxstatus.PDME <= mxstatus.DME <= 0/1
#define CONFIG_POINT7(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrc test_csr , t2; \
    MXSTATUS_DME_R(s0 , s1); \
    MXSTATUS_PDME_R(s0 , a2); \
    MSAVESTATUS_PDME1_R(s0 , a3); \
    MSAVESTATUS_PDME2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check7 PDME2 <= PDME1 <= mxstatus.PDME <= mxstatus.DME <= 0/1
#define CHECK_POINT7(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_DME_R(s0 , a5); \
    MXSTATUS_PDME_R(s0 , s6); \
    MSAVESTATUS_PDME1_R(s0 , a0); \
    MSAVESTATUS_PDME2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config8 PTYP2 <= PTYP1 <= mxstatus.PTYP <= mxstatus.TYP <= 1/2
#define CONFIG_POINT8(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrs test_csr , t2; \
    MXSTATUS_TYP_R(s0 , s1); \
    MXSTATUS_PTYP_R(s0 , a2); \
    MSAVESTATUS_PTYP1_R(s0 , a3); \
    MSAVESTATUS_PTYP2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check8 PTYP2 <= PTYP1 <= mxstatus.PTYP <= mxstatus.TYP <= 1/2
#define CHECK_POINT8(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_TYP_R(s0 , a5); \
    MXSTATUS_PTYP_R(s0 , s6); \
    MSAVESTATUS_PTYP1_R(s0 , a0); \
    MSAVESTATUS_PTYP2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


//zaixin: config9 PTYP2 <= PTYP1 <= mxstatus.PTYP <= mxstatus.TYP <= 1/2
#define CONFIG_POINT9(test_num , test_csr , setbit) \
    li t2 , setbit; \
    csrc test_csr , t2; \
    MXSTATUS_TYP_R(s0 , s1); \
    MXSTATUS_PTYP_R(s0 , a2); \
    MSAVESTATUS_PTYP1_R(s0 , a3); \
    MSAVESTATUS_PTYP2_R(s0 , a4);\
    li t2,test_num;\

//zaixin :check9 PTYP2 <= PTYP1 <= mxstatus.PTYP <= mxstatus.TYP <= 1/2
#define CHECK_POINT9(test_num,test_point,imode) \
    checkpoint_##test_point##_##test_num: ; \
    csrr t0, mcause ; \
    li t1, CAUSE_BREAKPOINT; \
    beq t0, t1, switch2mmode; \
    li t1, CAUSE_ILLEGAL_INSTRUCTION; \
    bne t0, t1, fail; \
    MXSTATUS_TYP_R(s0 , a5); \
    MXSTATUS_PTYP_R(s0 , s6); \
    MSAVESTATUS_PTYP1_R(s0 , a0); \
    MSAVESTATUS_PTYP2_R(s0 , a1); \
    point##test_num##0: ;\
    li s0 , imode ; \
    bne a5 , s0 , fail ; \
    point##test_num##1: ;\
    bne s6 , s1 , fail ;\
    point##test_num##2: ; \
    bne a0 , a2 , fail;\
    point##test_num##3: ;\
    bne a1 , a3 , fail; \
    csrr t0, mepc; \
    la t1, bad##test_num ;\
    beq t0, t1, mret_exception; \
    j fail; \


#define ENTRY_EXCEPTION(test_num) \
    bad##test_num: \
      .word 0 ; \
      j fail ; \

#define MTVEC_HANDLER \
.align 8 ;\
mtvec_handler:; \
  csrr t0, mcause ;\
  li t1, CAUSE_USER_ECALL;\
  beq t1, t0, write_tohost;\
  li t1, CAUSE_SUPERVISOR_ECALL;\
  beq t1, t0, write_tohost;\
  li t1, CAUSE_MACHINE_ECALL;\
  beq t1, t0, write_tohost;\
  li t1, CAUSE_BREAKPOINT;\
  beq t0, t1, 2f;\
  csrr t0 , mepc;\
  j 1f;\
  j fail;\
1:;\
  addi t0, t0, 8;\
  csrw mepc, t0;\
  mret;\
2:;\
  li t1, MSTATUS_MPP;\
  csrs mstatus, t1;\
  csrr t0, mepc;\
  addi t0, t0, 4;\
  csrw mepc, t0;\
  mret;\


#define CONFIG_ALL_MCLIC_IE(status) \
    CONFIG_CLIC_IE(status,0);\
    CONFIG_CLIC_IE(status,1);\
    CONFIG_CLIC_IE(status,2);\
    CONFIG_CLIC_IE(status,3);\
    CONFIG_CLIC_IE(status,4);\
    CONFIG_CLIC_IE(status,5);\
    CONFIG_CLIC_IE(status,6);\
    CONFIG_CLIC_IE(status,7);\
    CONFIG_CLIC_IE(status,8);\
    CONFIG_CLIC_IE(status,9);\
    CONFIG_CLIC_IE(status,10);\
    CONFIG_CLIC_IE(status,11);\
    CONFIG_CLIC_IE(status,12);\
    CONFIG_CLIC_IE(status,13);\
    CONFIG_CLIC_IE(status,14);\
    CONFIG_CLIC_IE(status,15);\
    CONFIG_CLIC_IE(status,16);\
    CONFIG_CLIC_IE(status,17);\
    CONFIG_CLIC_IE(status,18);\
    CONFIG_CLIC_IE(status,19);\
    CONFIG_CLIC_IE(status,20);\
    CONFIG_CLIC_IE(status,21);\
    CONFIG_CLIC_IE(status,22);\
    CONFIG_CLIC_IE(status,23);\
    CONFIG_CLIC_IE(status,24);\
    CONFIG_CLIC_IE(status,25);\
    CONFIG_CLIC_IE(status,26);\
    CONFIG_CLIC_IE(status,27);\
    CONFIG_CLIC_IE(status,28);\
    CONFIG_CLIC_IE(status,29);\
    CONFIG_CLIC_IE(status,30);\
    CONFIG_CLIC_IE(status,31);\
    CONFIG_CLIC_IE(status,32);\
    CONFIG_CLIC_IE(status,33);\
    CONFIG_CLIC_IE(status,34);\
    CONFIG_CLIC_IE(status,35);\
    CONFIG_CLIC_IE(status,36);\
    CONFIG_CLIC_IE(status,37);\
    CONFIG_CLIC_IE(status,38);\
    CONFIG_CLIC_IE(status,39);\
    CONFIG_CLIC_IE(status,40);\
    CONFIG_CLIC_IE(status,41);\
    CONFIG_CLIC_IE(status,42);\
    CONFIG_CLIC_IE(status,43);\
    CONFIG_CLIC_IE(status,44);\
    CONFIG_CLIC_IE(status,45);\
    CONFIG_CLIC_IE(status,46);\
    CONFIG_CLIC_IE(status,47);\
    CONFIG_CLIC_IE(status,48);\
    CONFIG_CLIC_IE(status,49);\
    CONFIG_CLIC_IE(status,50);\
    CONFIG_CLIC_IE(status,51);\
    CONFIG_CLIC_IE(status,52);\
    CONFIG_CLIC_IE(status,53);\
    CONFIG_CLIC_IE(status,54);\
    CONFIG_CLIC_IE(status,55);\
    CONFIG_CLIC_IE(status,56);\
    CONFIG_CLIC_IE(status,57);\
    CONFIG_CLIC_IE(status,58);\
    CONFIG_CLIC_IE(status,59);\
    CONFIG_CLIC_IE(status,60);\
    CONFIG_CLIC_IE(status,61);\
    CONFIG_CLIC_IE(status,62);\
    CONFIG_CLIC_IE(status,63);\
    CONFIG_CLIC_IE(status,64);\
    CONFIG_CLIC_IE(status,65);\
    CONFIG_CLIC_IE(status,66);\
    CONFIG_CLIC_IE(status,67);\
    CONFIG_CLIC_IE(status,68);\
    CONFIG_CLIC_IE(status,69);\
    CONFIG_CLIC_IE(status,70);\


#define  OPEN_STACK        \
        .pushsection .data ;\
        .align 2           ;\
        test_irqdata_begin:;\
        .zero (1023*4)     ;\
        test_irqdata_end:  ;\
        .word 0            ;\
        .popsection        ;\
        la  sp, test_irqdata_end ;\


#define PMP_ADDR_PRO(base_addr,size) ((base_addr >> 2) | ((size-1) >>3))


#define  SAVE_CONTEXT    \
        sw   x1 , 0*4(sp);\
        sw   x2 , 1*4(sp);\
        sw   x3 , 2*4(sp);\
        sw   x4 , 3*4(sp);\
        sw   x5 , 4*4(sp);\
        sw   x6 , 5*4(sp);\
        sw   x7 , 6*4(sp);\
        sw   x8 , 7*4(sp);\
        sw   x9 , 8*4(sp);\
        sw   x10 , 9*4(sp);\
        sw   x11 , 10*4(sp);\
        sw   x12 , 11*4(sp);\
        sw   x13 , 12*4(sp);\
        sw   x14 , 13*4(sp);\
        sw   x15 , 14*4(sp);\
/*#`ifdef N100_CFG_REGNUM_IS_32*/\
        sw   x16 , 15*4(sp);\
        sw   x17 , 16*4(sp);\
        sw   x18 , 17*4(sp);\
        sw   x19 , 18*4(sp);\
        sw   x20 , 19*4(sp);\
        sw   x21 , 20*4(sp);\
        sw   x22 , 21*4(sp);\
        sw   x23 , 22*4(sp);\
        sw   x24 , 23*4(sp);\
        sw   x25 , 24*4(sp);\
        sw   x26 , 25*4(sp);\
        sw   x27 , 26*4(sp);\
        sw   x28 , 27*4(sp);\
        sw   x29 , 28*4(sp);\
        sw   x30 , 29*4(sp);\
        sw   x31 , 30*4(sp);\
/*#`endif N100_CFG_REGNUM_IS_32*/\

#define  RESTORE_CONTEXT \
        lw   x1 , 0*4(sp);\
        lw   x2 , 1*4(sp);\
        lw   x3 , 2*4(sp);\
        lw   x4 , 3*4(sp);\
        lw   x5 , 4*4(sp);\
        lw   x6 , 5*4(sp);\
        lw   x7 , 6*4(sp);\
        lw   x8 , 7*4(sp);\
        lw   x9 , 8*4(sp);\
        lw   x10 , 9*4(sp);\
        lw   x11 , 10*4(sp);\
        lw   x12 , 11*4(sp);\
        lw   x13 , 12*4(sp);\
        lw   x14 , 13*4(sp);\
        lw   x15 , 14*4(sp);\
/*#`ifndef N100_CFG_REGNUM_IS_16*/\
        lw   x16 , 15*4(sp);\
        lw   x17 , 16*4(sp);\
        lw   x18 , 17*4(sp);\
        lw   x19 , 18*4(sp);\
        lw   x20 , 19*4(sp);\
        lw   x21 , 20*4(sp);\
        lw   x22 , 21*4(sp);\
        lw   x23 , 22*4(sp);\
        lw   x24 , 23*4(sp);\
        lw   x25 , 24*4(sp);\
        lw   x26 , 25*4(sp);\
        lw   x27 , 26*4(sp);\
        lw   x28 , 27*4(sp);\
        lw   x29 , 28*4(sp);\
        lw   x30 , 29*4(sp);\
        lw   x31 , 30*4(sp);\
/*#`endnif N100_CFG_REGNUM_IS_16*/\

#define  SAVE_MIPC_ISTATUS \
        csrr x5 , 0x352 ;  \
        sw   x5 , 30*4(sp);\
        csrr x5 , 0x310 ;  \
        sw   x5 , 31*4(sp); \

#define  RESTORE_MIPC_ISTATUS \
        lw   x5 , 30*4(sp) ; \
        csrw 0x352 , x5 ;    \
        lw   x5 , 31*4(sp);  \
        csrw 0x310 , x5;     \

#define  SAVE_MEPC_MCAUSE \
        csrr x5 , mcause ;  \
        sw   x5 , 31*4(sp);\
        csrr x5 , mepc ;  \
        sw   x5 , 32*4(sp); \

#define  RESTORE_MEPC_MCAUSE \
        lw   x5 , 31*4(sp) ; \
        csrw mcause , x5 ;    \
        lw   x5 , 32*4(sp);  \
        csrw mepc , x5;     \


#define USER_IRQ_TVEC \
 .align 6;           \
user_irq_trap_tvec:; \
        addi sp, sp, -33*4;\
        SAVE_CONTEXT;\
        SAVE_MEPC_MCAUSE;\
        csrr t2, mcause;\
        blez t2, user_irq_tvec;\
        li s0 , 0x1fff;\
        and t2, t2, s0;\
        li s0 , 0xfff;\
        beq t2 , s0 , nmi_handler; \
        li s0, CAUSE_USER_ECALL;\
        beq t2, s0, write_tohost;\
        li s0, CAUSE_SUPERVISOR_ECALL;\
        beq t2, s0, write_tohost;\
        li s0, CAUSE_MACHINE_ECALL;\
        beq t2, s0, write_tohost;\
        li s0, CAUSE_FETCH_ACCESS;\
        beq t2, s0, fail;\
        li s0, CAUSE_LOAD_ACCESS;\
        beq t2, s0, fail;\
        li s0, CAUSE_STORE_ACCESS;\
        beq t2, s0, fail;\
        li s0, CAUSE_MISALIGNED_FETCH;\
        beq t2, s0, fail;\
        li s0, CAUSE_BREAKPOINT;\
        beq t2, s0, mtvec_handler;\
        la t2, mtvec_handler;\
        beqz t2, 1f;\
        jr t2;\
        1:;\
        csrr t2, mcause;\
        bgez t2, handle_exception;\
        INTERRUPT_HANDLER;\
.align 2; \
user_irq_tvec:\
        csrr t2, mcause;\
        li s0, 0x800003ff;\
        and t2, t2, s0;\
        li s0, 0x80000003;\
        beq t2, s0, 1f;\
        li s0, 0x80000007;\
        beq t2, s0, 2f;\
        li s0, 0x8000000b;\
        beq t2, s0, 3f;\
        j fail;\
        1:;\
        li s0,  0x3;\
        csrw mscratch, s0;\
        j 4f;\
        2:;\
        li s0,  0x4;\
        csrw mscratch, s0;\
        j 4f;\
        3:;\
        li s0,  0x2;\
        csrw mscratch, s0;\
        4:;\
        RESTORE_MEPC_MCAUSE;\
        RESTORE_CONTEXT;\
        addi sp, sp, 33*4;\
        mret;\
nmi_handler:;\
        li s0 , 0x6;\
        csrw mscratch , s0;\
        RESTORE_MEPC_MCAUSE;\
        RESTORE_CONTEXT;\
        addi sp, sp, 33*4;\
        mret;\




#define CLOSE_ODS             \
        li  t0 , 0x000c0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_ODS              \
        li  t0 , 0x000cffff ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_IDS             \
        li  t0 , 0x000d0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_IDS              \
        li  t0 , 0x000dffff ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_ODSC             \
        li  t0 , 0x000e0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_ODSC              \
        li  t0 , 0x000effff ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_IDSC             \
        li  t0 , 0x000f0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_IDSC              \
        li  t0 , 0x000fffff ; \
        csrw 0x340 , t0 ;     \


#define CLOSE_ODST             \
        li  t0 , 0x001f0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_ODST              \
        li  t0 , 0x001fffff ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_IDST             \
        li  t0 , 0x002f0000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_IDST              \
        li  t0 , 0x002fffff ; \
        csrw 0x340 , t0 ;     \


#define  OPEN_FORCE_INTERRUPT \
        li  t0 , 0x0001ffff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x0002ffff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x0003ffff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x0004ffff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x0005ffff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x0006ffff ; \
        csrw 0x340 , t0;      \
        li  t0 , 0x0006ff00 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000a0010 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000a0011 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000a0012 ; \
        csrw 0x340 , t0 ;     \

#define  CLOSE_FORCE_INTERRUPT \
        li  t0 , 0x00010000 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x00020000;  \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x00030000;  \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x00040000;  \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x00050000 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x00060000 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000600ff ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000b000f ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000b0010 ; \
        csrw 0x340 , t0 ;     \
        li  t0 , 0x000b0011 ; \
        csrw 0x340 , t0 ;     \

#define CONFIG_PULSE_INT   \
        li  t0 , 0x000a0000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_EXT_FORCE_INT   \
        li  t0 , 0x00010000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_SOF_FORCE_INT   \
        li  t0 , 0x00020000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_TIM_FORCE_INT   \
        li  t0 , 0x00030000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_DBG_FORCE_INT   \
        li  t0 , 0x00040000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_NMI_FORCE_INT   \
        li  t0 , 0x00050000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_EXC_FORCE_INT   \
        li  t0 , 0x00060000 ; \
        csrw 0x340 , t0 ;     \

#define CLOSE_BWE_FORCE_INT   \
        li  t0 ,0x000affff+17;\
        csrw 0x340 , t0 ;     \

#define CLOSE_PMOV_FORCE_INT   \
        li  t0 ,0x000affff+18;\
        csrw 0x340 , t0 ;     \

#define CLOSE_EVT_FORCE_INT   \
        li  t0 , 0x000600ff ; \
        csrw 0x340 , t0 ;     \


#define CLOSE_DM_FORCE         \
        li  t0 , 0x00880000 ; \
        csrw 0x340 , t0 ;     \


#define OPEN_EXT_FORCE_INT   \
        li  t0 , 0x0001ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_SOF_FORCE_INT   \
        li  t0 , 0x0002ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_TIM_FORCE_INT   \
        li  t0 , 0x0003ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_DBG_FORCE_INT   \
        li  t0 , 0x0004ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_NMI_FORCE_INT   \
        li  t0 , 0x0005ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_EXC_FORCE_INT   \
        li  t0 , 0x0006ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_EVT_FORCE_INT   \
        li  t0 , 0x0006ff00 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_BWE_FORCE_INT   \
        li  t0 ,0x000a0000+17; \
        csrw 0x340 , t0 ;     \

#define OPEN_PMOV_FORCE_INT   \
        li  t0 ,0x000a0000+18; \
        csrw 0x340 , t0 ;     \

#define CLOSE_TIME_FORCE_INT   \
        li  t0 , 0x00090000 ; \
        csrw 0x340 , t0 ;     \

#define OPEN_TIME_FORCE_INT   \
        li  t0 , 0x0009ffff ; \
        csrw 0x340 , t0 ;     \

#define OPEN_DM_FORCE         \
        li  t0 , 0x0088ffff ; \
        csrw 0x340 , t0 ;     \

#define DM_FORCE_EN           \
        li  t0 , 0x00000007 ; \
        csrw 0x340 , t0 ;     \

#define DM_RELEASE_EN         \
        li  t0 , 0x00000008 ; \
        csrw 0x340 , t0 ;     \

#define DM_QUICK_RELEASE      \
        li  t0 , 0x00000009 ; \
        csrw 0x340 , t0 ;     \

#define DM_QUICK_RELEASE1     \
        li  t0 , 0x0000000b ; \
        csrw 0x340 , t0 ;     \

#define FORCE_RSTHALT_PUlSE   \
        li  t0 , 0x0000000a ; \
        csrw 0x340 , t0 ;     \

#define CLEAN_EXT_INT        \
        csrw 0x340, 0x2;     \

#define CLEAN_TMR_INT        \
        csrw 0x340, 0x4;     \

#define CLEAN_SFT_INT        \
        csrw 0x340, 0x3;     \

#define CLEAN_NMI_INT        \
        csrw 0x340, 0x6;     \

#define CLEAN_BWE_INT        \
        csrw 0x340, 0x11;     \

#define CLEAN_PMOV_INT       \
        csrw 0x340, 0x12;     \

#define CHECK_WFI_WAKEUP_NO_UPDATE_SCRATCH1(test_num) \
test##test_num:;\
  csrwi wfi_mode, 0;\
  csrwi mscratch, 0;\
  wfi;\
  csrr t2, mscratch;\
  bnez t2, end ;\


#define CHECK_WFI_WAKEUP_NO_UPDATE_SCRATCH1_TIM(test_num) \
test##test_num:;\
  csrwi wfi_mode, 0;\
  csrwi mscratch, 0;\
  wfi;\
  csrr t2, mscratch;\
  li s0 , 0x1001;\
  bne t2, s0, end ;\


#define CHECK_WFI_WAKEUP_UPDATE_SCRATCH1(test_num) \
test##test_num:;\
  csrwi wfi_mode, 0; \
  csrwi mscratch, 0; \
  wfi ; \
  csrr t2, mscratch; \
  beqz t2, end; \

#define CONFIG_CLINT_INTMODE \
        csrrci x8, mtvec, 0x3; \

#define FORCE_EXTERNAL_CLIC_IRQ \
        li t0, 0x8ffff;\
        csrw 0x340, t0;\

#define RELEASE_EXTERNAL_CLIC_IRQ \
        li t0, 0x7ffff;\
        csrw 0x340, t0;\

#define FORCE_CLIC_IRQ(irq_id) \
        li  t0 , (0x00080000+irq_id) ; \
        csrw 0x340 , t0 ;     \
        
#define FORCE_CLIC_UIRQ(irq_id) \
        li  t0 , (0x00080000+irq_id) ; \
        csrw uscratch, t0 ;     \
        
#define CONFIG_UCLIC_INTMODE \
        li   x8, 0x3f;   \
        csrrc x9, utvec, x8; \
        csrrsi x8, utvec, 0x3; \

#define CONFIG_CLIC_INTMODE \
        li   x8, 0x3f;   \
        csrrc x9, mtvec, x8; \
        csrrsi x8, mtvec, 0x3; \

#define CONFIG_CLIC_CFG(nmbits, nlbits, shv) \
        li   x8, (nmbits*32 + nlbits*2 + shv); \
        li   x9, 0x`N100_CFG_CLIC_BASE_ADDR` + 0x0000;\
        sb   x8, 0(x9);\

#define WORD_CONFIG_CLIC_CFG(nmbits, nlbits, shv) \
        li   x8, (nmbits*32 + nlbits*2 + shv); \
        li   x9, 0x`N100_CFG_CLIC_BASE_ADDR` + 0x0000;\
        sw   x8, 0(x9);\

#define CONFIG_CLIC_THOD(clic_thod)     \
        li   x8 , clic_thod;                  \
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x0008;                      \
        sb   x8 , 3(x9)    ;                       \

#define WORD_CONFIG_CLIC_THOD(clic_thod)     \
        li   x8 , clic_thod<<24;                  \
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x0008;                      \
        sw   x8 , 3(x9)    ;                       \

#define WORD_CONFIG_CLICINT(ctrl, clic_irq_id)\
        li   x8, ctrl; \
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1000;     \
        sw   x8, clic_irq_id*4(x9);

#define CONFIG_CLIC_IP(clic_ip, clic_irq_id) \
        li   x8 , clic_ip;       \
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1000;     \
        sb   x8 , clic_irq_id*4(x9) ;         \

#define CONFIG_CLIC_IE(clic_ie, clic_irq_id) \
        li   x8 , clic_ie;       \
        /*li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1001; */    \
        sb   x8 , clic_irq_id*4(x9) ;         \
 
#define CONFIG_CLIC_ATTR(edge_mode,trig_mode,shv, clic_irq_id) \
        li   x8 , edge_mode << clic_irq_id;       \
        csrw cliclvl , x8;     \
        li   x8 , trig_mode << clic_irq_id;       \
        csrw clicedge , x8;     \

#define CONFIG_UCLIC_ATTR(edge_mode,trig_mode,shv, clic_irq_id) \
        li   x8 ,(edge_mode*4 + trig_mode*2 + shv);       \
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1002;     \
        sb   x8 , clic_irq_id*4(x9) ;         \

#define CONFIG_CLIC_CTRL(clic_ctrl, clic_irq_id)    \
        li   x8 , clic_ctrl;\
        li   x9 , 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1003; \
        sb   x8 , clic_irq_id*4(x9) ; \

#define DELAY(time,num) \
        li t0, time ;\
		li t1, 0 ; \
		delay_loop_##num:; \
		addi t1, t1, 1;\
		bne t0, t1, delay_loop_##num;\

#define DISABLE_ALL_MCLIC_IE \
    CONFIG_CLIC_IE(0,0);\
    CONFIG_CLIC_IE(0,1);\
    CONFIG_CLIC_IE(0,2);\
    CONFIG_CLIC_IE(0,3);\
    CONFIG_CLIC_IE(0,4);\
    CONFIG_CLIC_IE(0,5);\
    CONFIG_CLIC_IE(0,6);\
    CONFIG_CLIC_IE(0,7);\
    CONFIG_CLIC_IE(0,8);\
    CONFIG_CLIC_IE(0,9);\
    CONFIG_CLIC_IE(0,10);\
    CONFIG_CLIC_IE(0,11);\
    CONFIG_CLIC_IE(0,12);\
    CONFIG_CLIC_IE(0,13);\
    CONFIG_CLIC_IE(0,14);\
    CONFIG_CLIC_IE(0,15);\
    CONFIG_CLIC_IE(0,16);\
    CONFIG_CLIC_IE(0,17);\
    CONFIG_CLIC_IE(0,18);\
    CONFIG_CLIC_IE(0,19);\
    CONFIG_CLIC_IE(0,20);\
    CONFIG_CLIC_IE(0,21);\
    CONFIG_CLIC_IE(0,22);\
    CONFIG_CLIC_IE(0,23);\
    CONFIG_CLIC_IE(0,24);\
    CONFIG_CLIC_IE(0,25);\
    CONFIG_CLIC_IE(0,26);\
    CONFIG_CLIC_IE(0,27);\
    CONFIG_CLIC_IE(0,28);\
    CONFIG_CLIC_IE(0,29);\
    CONFIG_CLIC_IE(0,30);\
    CONFIG_CLIC_IE(0,31);\
    CONFIG_CLIC_IE(0,32);\
    CONFIG_CLIC_IE(0,33);\
    CONFIG_CLIC_IE(0,34);\
    CONFIG_CLIC_IE(0,35);\
    CONFIG_CLIC_IE(0,36);\
    CONFIG_CLIC_IE(0,37);\
    CONFIG_CLIC_IE(0,38);\
    CONFIG_CLIC_IE(0,39);\
    CONFIG_CLIC_IE(0,40);\
    CONFIG_CLIC_IE(0,41);\
    CONFIG_CLIC_IE(0,42);\
    CONFIG_CLIC_IE(0,43);\
    CONFIG_CLIC_IE(0,44);\
    CONFIG_CLIC_IE(0,45);\
    CONFIG_CLIC_IE(0,46);\
    CONFIG_CLIC_IE(0,47);\
    CONFIG_CLIC_IE(0,48);\
    CONFIG_CLIC_IE(0,49);\
    CONFIG_CLIC_IE(0,50);\
    CONFIG_CLIC_IE(0,51);\
    CONFIG_CLIC_IE(0,52);\
    CONFIG_CLIC_IE(0,53);\
    CONFIG_CLIC_IE(0,54);\
    CONFIG_CLIC_IE(0,55);\
    CONFIG_CLIC_IE(0,56);\
    CONFIG_CLIC_IE(0,57);\
    CONFIG_CLIC_IE(0,58);\
    CONFIG_CLIC_IE(0,59);\
    CONFIG_CLIC_IE(0,60);\
    CONFIG_CLIC_IE(0,61);\
    CONFIG_CLIC_IE(0,62);\
    CONFIG_CLIC_IE(0,63);\
    CONFIG_CLIC_IE(0,64);\
    CONFIG_CLIC_IE(0,65);\
    CONFIG_CLIC_IE(0,66);\
    CONFIG_CLIC_IE(0,67);\
    CONFIG_CLIC_IE(0,68);\
    CONFIG_CLIC_IE(0,69);\
    CONFIG_CLIC_IE(0,70);\


#define DISABLE_ALL_UCLIC_IE \
    CONFIG_CLIC_IE(0,71);\
    CONFIG_CLIC_IE(0,72);\
    CONFIG_CLIC_IE(0,73);\
    CONFIG_CLIC_IE(0,74);\
    CONFIG_CLIC_IE(0,75);\
    CONFIG_CLIC_IE(0,76);\
    CONFIG_CLIC_IE(0,77);\
    CONFIG_CLIC_IE(0,78);\
    CONFIG_CLIC_IE(0,79);\
    CONFIG_CLIC_IE(0,80);\


#define CSR_MRW_WARL_CHK(csr_name,test_idx, warl_value)\
        csrr t0, csr_name;\
        li  t2 , 0xffffffff; \
        csr_mmode_wr_##csr_name##test_idx: ; \
             csrw csr_name, t2; \
             j csr_mmode_rd_##csr_name##test_idx;    \
             j fail ;              \
        csr_mmode_rd_##csr_name##test_idx: ;          \
             csrr   t1 , csr_name; \
             j csr_mmode_rdata_chk_##csr_name##test_idx;                \
             j fail ;              \
        csr_mmode_rdata_chk_##csr_name##test_idx: ;\
             li  t2 , warl_value;\
             bne  t1 , t2 , fail;  \
#`ifdef N100_CFG_HAS_UMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        li  t2 , 0xffffffff; \
        csr_umode_wr_##csr_name##test_idx: ; \
             csrw csr_name, t2; \
             j fail ;              \
        csr_umode_rd_##csr_name##test_idx: ;          \
             csrr   t1 , csr_name; \
             j fail ;              \
        SWITCH_TO_MMODE;\
#`endif N100_CFG_HAS_UMODE \
        csrw csr_name, t0;\

#define  CSR_MRO_RL_CHK(csr_name,test_idx) \
        li  t2 , 0xffffffff; \
        csr_mmode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_mmode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j 1f ;\
             j fail ;              \
        1:;\
#`ifdef N100_CFG_HAS_UMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        li  t2 , 0xffffffff; \
        csr_umode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_umode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j fail ;              \
        SWITCH_TO_MMODE;\
#`endif N100_CFG_HAS_UMODE \

#define  CSR_ILLEGAL_CSR_CHK(csr_name,test_idx) \
        li  t2 , 0xffffffff; \
        csr_mmode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_mmode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j fail ;              \
        1:;\
#`ifdef N100_CFG_HAS_UMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        li  t2 , 0xffffffff; \
        csr_umode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_umode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j fail ;              \
        SWITCH_TO_MMODE;\
#`endif N100_CFG_HAS_UMODE \

#define  CSR_MRO_WRIGNORE_CHK(csr_name,test_idx) \
        csrr t0,csr_name;\
        li  t2 , 0xffffffff; \
        csr_mmode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j csr_mmode_rd_##csr_name##test_idx;\
             j fail ;              \
        csr_mmode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j csr_mmode_rdata_chk_##csr_name##test_idx;\
             j fail ;              \
        csr_mmode_rdata_chk_##csr_name##test_idx: ;          \
            bne t0,t1,fail;\
#`ifdef N100_CFG_HAS_UMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        li  t2 , 0xffffffff; \
        csr_umode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_umode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j fail ;              \
        SWITCH_TO_MMODE;\
#`endif N100_CFG_HAS_UMODE \

#define  CSR_INFOMRO_WRIGNORE_CHK(csr_name,test_idx,info_data) \
        csrr t0,csr_name;\
        li  t2 , 0xffffffff; \
        csr_mmode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j csr_mmode_rd_##csr_name##test_idx;\
             j fail ;              \
        csr_mmode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j csr_mmode_rdata_chk_##csr_name##test_idx;\
             j fail ;              \
        csr_mmode_rdata_chk_##csr_name##test_idx: ;          \
            bne t0,t1,fail;\
            li t0, info_data;\
            bne t0,t1,fail;\
#`ifdef N100_CFG_HAS_UMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        li  t2 , 0xffffffff; \
        csr_umode_wr_##csr_name##test_idx: ; \
             csrw  csr_name, t2;  \
             j fail ;              \
        csr_umode_rd_##csr_name##test_idx: ;          \
             csrr   t1 ,csr_name; \
             j fail ;              \
        SWITCH_TO_MMODE;\
#`endif N100_CFG_HAS_UMODE \

#define USER_RESTORE_CONTEXT                        \
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
        lw a2, 2*4(sp);         /*Restore original a2 value.*/\
        lw a0, 1*4(sp) ;      /* Restore original a1 value.*/\
        lw a1, 0*4(sp);       /* Restore original a0 value.*/\
        addi sp, sp, 20*4;/* Reclaim stack space.*/\

#define USER_TRAP                        \
        user_trap_vector: ;              \
        csrr t2, mcause ;                \
        li s0, CAUSE_MASK;               \
		and t2, t2, s0;                  \
        li s0, CAUSE_USER_ECALL ;        \
        beq t2, s0, write_tohost ;       \
        li s0, CAUSE_SUPERVISOR_ECALL ;  \
        beq t2, s0, write_tohost ;       \
        li s0, CAUSE_MACHINE_ECALL ;     \
        beq t2, s0, write_tohost ;       \
        /*li s0, CAUSE_BREAKPOINT ;*/    \
        /*beq t2, s0, 2f ;         */    \
        la t2, mtvec_handler ;           \
        beqz t2, 1f ;                    \
        jr t2 ;                          \
      1: ;                               \
        csrr t2, mcause ;                \
        bgez t2, handle_exception;       \
        INTERRUPT_HANDLER;               
//      2: ;                               \
//        li t0, MSTATUS_MPP;              \
//        csrs mstatus, t0;                \
//        csrr t0, mepc ;                  \
//        addi t0, t0, 8 ;                 \
//        csrw mepc, t0 ;                  \
//        USER_RESTORE_CONTEXT;            \
//        mret ;                           \
        

#define SWITCH_TO_UMODE_MRET(test_status) \
        li t0, 0xffffffff ; \
        csrs pmpaddr0, t0 ; \
        li t0, 0xff ; \
        csrs pmpcfg0, t0 ; \
        li t0, MSTATUS_MPP ; \
        csrc test_status, t0 ; \
        mret ; \

#define SWITCH_TO_UMODE_PMP( test_status, test_mpc ) \
  li t0, MSTATUS_MPP;                                \
  csrc test_status, t0;                              \
  la t0, 1f;                                         \
  csrw test_mpc, t0;                                 \
  mret;                                              \
1:

#define SWITCH_TO_UMODE(test_status , test_mpc , test_pmpaddr, test_pmpcfg) \
        li t0, test_pmpaddr ; \
        csrs pmpaddr0, t0 ; \
        li t0, test_pmpcfg ; \
        csrs pmpcfg0, t0 ; \
        li t0, MSTATUS_MPP ; \
        csrc test_status, t0 ; \
        la t0 , 1f ; \
        csrw test_mpc , t0 ; \
        csrr t0, mcause;\
        li t1, 0x7fffffff;\
        and t0,t0,t1;\
        csrw mcause, t0;\
        mret ; \
        1: ;  \

#define SWITCH_TO_MMODE \
        ebreak ; \

#define WAIT_INT \
        wfi; \


#define  SAVE_MNPC_NSTATUS     \
        csrr x5 , mnpc ;       \
        sw   x5 , 30*4(sp);    \
        csrr x5 , nstatus ;    \
        sw   x5 , 31*4(sp);    \

#define  RESTORE_MNPC_NSTATUS  \
        lw   x5 , 30*4(sp) ;   \
        csrw mnpc , x5 ;       \
        lw   x5 , 31*4(sp);    \
        csrw nstatus , x5;     \

#define  TEST_CSR_RW(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
        csrr t1 , test_csr; \
        j 1f ; \
        j fail ; \
        1: ; \
        li t2 , test_write ; \
        bne t1 , t2 , fail; \
 
#define  TEST_CSR_CNT(test_num1 , test_num2 , test_csr , test_write, increase) \
        li  t2 , test_write ; \
        csrw   test_csr , t2; \
        nop;                  \
        nop;                  \
        csrr t1 , test_csr;   \
        addi t2 , t2 , increase; \
        bne t1 , t2 , fail; \
        j 1f ; \
        j fail ; \
        1: ; \

#define  TEST_CSR_RW_NOCMP(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \

#define  TEST_CSR_RWEQ0(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             bnez      t1 , fail;  \
             beqz      t2 , fail;  \

#define  TEST_CSR_ROEQ0(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             bnez      t1 , fail;  \

#define  TEST_CSR_RW1C(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             bnez      t1 , fail;  \

#define  TEST_CSR_RO_W(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             li  t2 , test_write ; \
             beq  t1 , t2 , fail;  \



#define  TEST_CSR_RW_txevt(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             bne  t1 , x0 , fail;  \



#define  TEST_CSR_RW_REG(test_num1 , test_num2 , test_csr , test_x) \
        bad##test_num1: ; \
             csrw   test_csr , test_x; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             bne  t1 , test_x , fail;  \


#define  TEST_CSR_RW_BGE(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw   test_csr , t2; \
             j bad##test_num2 ;    \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \
             li  t2 , test_write ; \
             bge  t2 , t1 , fail;  \

#define  TEST_CSR_RO(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw  test_csr , t2;  \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ;                       \

#define  TEST_CSR_MRO(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw  test_csr , t2;  \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j 1f ;                \
             j fail ;              \
        1: ; 

#define  TEST_CSR_NRW(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw  test_csr , t2;  \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j fail ;              \
        1: ;                       \

#define  TEST_CSR_NO(test_num1 , test_num2 , test_csr , test_write) \
        li  t2 , test_write ; \
        bad##test_num1: ; \
             csrw  test_csr , t2;  \
             j fail ;              \
        bad##test_num2: ;          \
             csrr   t1 , test_csr; \
             j fail ;              \

#define  CMP_EQ(test_csr , base_reg , code... ) \
        SWITCH_TO_MMODE \
        code ; \
        csrr   t1 , test_csr; \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        SWITCH_TO_MMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        csrr   base_reg , test_csr; \
        bne  t1 , base_reg , fail ; \

#define  CMP_GRT(test_csr , base_reg , code... ) \
        SWITCH_TO_MMODE \
        code ; \
        csrr   t1 , test_csr; \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        SWITCH_TO_MMODE \
        SWITCH_TO_UMODE(mstatus , mepc , 0xffffffff , 0xff) \
        csrr   base_reg , test_csr; \
        bge  base_reg , t1 , 1f ; \
        j   fail ; \
        1:     ; \

#define  ACCESS_REG(TEST_REG)                   \
        mv t0, TEST_REG                        ;\
        mv TEST_REG, t0                        ;\

#define  ACCESS_REG_EXCP(TEST_REG)                   \
        mv t0, TEST_REG                        ;\
#`ifdef N100_CFG_REGNUM_IS_16                   \
        j fail                                 ;\
#`endif N100_CFG_REGNUM_IS_16                   \
        mv TEST_REG, t0                        ;\
#`ifdef N100_CFG_REGNUM_IS_16                   \
        j fail                                 ;\
#`endif N100_CFG_REGNUM_IS_16                   \

#define  LWSW(ls, rs1, rs2, num1, num2) \
        li rs1, num1; \
        li rs2, num2; \
        ls rs1, 0(rs2); \

#define  LW_AFTER_32NOP(rs1, rs2, test_reg) \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        nop;              \
        li rs2, test_reg; \
        lw rs1, 0(rs2);   \

#define  CSR_TRAP_HANDLER \
        .align 8 ; \
        mtvec_handler: ; \
        csrr t0, mcause ; \
        li t1, CAUSE_ILLEGAL_INSTRUCTION; \
        bne t0, t1, fail ; \
        csrr t0, mepc ; \
        la t1, bad0;  \
        beq t0, t1, 1f ; \
        la t1, bad1 ; \
        beq t0, t1, 1f ; \
        la t1, bad2 ; \
        beq t0, t1, 1f ; \
        la t1, bad3 ; \
        beq t0, t1, 1f; \
        la t1, bad4 ; \
        beq t0, t1, 1f ; \
        la t1, bad5 ; \
        beq t0, t1, 1f ; \
        la t1, bad6 ; \
        beq t0, t1, 1f ; \
        la t1, bad7 ; \
        beq t0, t1, 1f ; \
        la t1, bad8 ; \
        beq t0, t1, 1f ; \
        la t1, bad9 ; \
        beq t0, t1, 1f ; \
        la t1, bad10 ; \
        beq t0, t1, 1f ; \
        la t1, bad11 ; \
        beq t0, t1, 1f ; \
        la t1, bad12 ; \
        beq t0, t1, 1f ; \
        la t1, bad13 ; \
        beq t0, t1, 1f ; \
        la t1, bad14 ; \
        beq t0, t1, 1f ; \
        la t1, bad15 ; \
        beq t0, t1, 1f ; \
        la t1, bad16 ; \
        beq t0, t1, 1f ; \
        la t1, bad17 ; \
        beq t0, t1, 1f ; \
        la t1, bad18 ; \
        beq t0, t1, 1f ; \
        la t1, bad19 ;\
        beq t0, t1, 1f ; \
        la t1, bad20 ; \
        beq t0, t1, 1f ; \
        la t1, bad21 ; \
        beq t0, t1, 1f ; \
        la t1, bad22 ; \
        beq t0, t1, 1f ; \
        la t1, bad23 ; \
        beq t0, t1, 1f ; \
        la t1, bad24 ; \
        beq t0, t1, 1f ; \
        la t1, bad25 ; \
        beq t0, t1, 1f ; \
        la t1, bad26 ; \
        beq t0, t1, 1f ; \
        la t1, bad27 ; \
        beq t0, t1, 1f ; \
        la t1, bad28 ; \
        beq t0, t1, 1f ; \
        la t1, bad29 ; \
        beq t0, t1, 1f ; \
        la t1, bad30 ; \
        beq t0, t1, 1f ; \
        la t1, bad31 ; \
        beq t0, t1, 1f ; \
        la t1, bad32 ; \
        beq t0, t1, 1f ; \
        la t1, bad33 ; \
        beq t0, t1, 1f ; \
        la t1, bad34 ; \
        beq t0, t1, 1f ; \
        la t1, bad35 ; \
        beq t0, t1, 1f; \
        la t1, bad36 ; \
        beq t0, t1, 1f ; \
        la t1, bad37 ; \
        beq t0, t1, 1f ; \
        la t1, bad38 ; \
        beq t0, t1, 1f ; \
        la t1, bad39 ; \
        beq t0, t1, 1f ; \
        j fail ; \
    1: ; \
        addi t0, t0, 8 ;\
        csrw mepc, t0 ; \
        mret ; \
    2:  ; \


#define CONFIG_UMODE_IRQ \
         DISABLE_ALL_MCLIC_IE; \
         DISABLE_ALL_UCLIC_IE; \
         CLOSE_FORCE_INTERRUPT;  \
         CONFIG_CLIC_CFG(1,2,0); \
         CONFIG_CLIC_INTMODE; \
         CONFIG_UCLIC_INTMODE;   \
         CONFIG_CLIC_THOD(0);    \
         CONFIG_UCLIC_ATTR(0,0,0,71); \
         CONFIG_CLIC_CTRL(101,71); \
         CONFIG_CLIC_IE(1,71); \

#define CONFIG_MMODE_IRQ        \
         DISABLE_ALL_MCLIC_IE;  \
         DISABLE_ALL_UCLIC_IE;  \
         CLOSE_FORCE_INTERRUPT; \
         CONFIG_CLIC_CFG(1,2,0);\
         CONFIG_CLIC_INTMODE;   \
         CONFIG_CLIC_THOD(0) ;  \
         CONFIG_CLIC_ATTR(0,0,0,21); \
         CONFIG_CLIC_CTRL(101,21); \
         CONFIG_CLIC_IE(1,21);    \

#define CONFIG_MIE_0 \
        csrci mstatus, MSTATUS_MIE;\

#define CONFIG_MIE_1 \
        csrsi mstatus, MSTATUS_MIE;\

#define CONFIG_UIE_0 \
        csrci ustatus, USTATUS_UIE;\

#define CONFIG_UIE_1 \
        csrsi ustatus, USTATUS_UIE;\

#define CONFIG_MPIE_0 \
        li a0 , MSTATUS_MPIE;\
        csrc mstatus, a0;\

#define CONFIG_MPIE_1 \
        li a0 , MSTATUS_MPIE;\
        csrs mstatus, a0; \

#define CONFIG_UPIE_0 \
        li a0 , USTATUS_UPIE;\
        csrc ustatus, a0;\

#define CONFIG_UPIE_1 \
        li a0 , USTATUS_UPIE;\
        csrs ustatus, a0;\


#define CONFIG_U_IRQ(en) \
        CONFIG_CLIC_IE(en,71);\

#define CONFIG_M_IRQ(en) \
        CONFIG_CLIC_IE(en,21);\

#define CONFIG_EVT_1 \
        OPEN_EVT_FORCE_INT; \

#define CONFIG_EVT_0 \
        CLOSE_EVT_FORCE_INT; \

#define CONFIG_WFE(en) \
        csrwi wfe , en ; \

//-----------------------------------------------------------------------
// PMP Test Macro
//-----------------------------------------------------------------------
// SET_PMP
// Usage: 
// arg1: pmp_entry, indicates which entry to be set, valid value includes: pmpaddr0-pmpaddr3
// arg2: addr, used to set address 
// arg3: cfg
#define SET_PMP( pmp_entry, addr, cfg ) \
  li t0, MASK_XLEN(addr); \
  csrw pmp_entry, t0; \
  li t0, MASK_XLEN(cfg); \
  csrs pmpcfg0, t0; 

#define SET_PMP_1( pmp_entry, addr, cfg ) \
  li t0, MASK_XLEN(addr); \
  csrw pmp_entry, t0; \
  li t0, MASK_XLEN(cfg); \
  csrs pmpcfg1, t0; 

#define SET_PMP_BY_LABEL( pmp_entry, pmpcfg, start_label, end_label ) \
  la t0, end_label       ;\
  la t1, start_label     ;\
  sub t2, t0, t1         ;\
  li t0, 1               ;\
  sub t2, t2, t0         ;\
  srli t2, t2, 3         ;\
  srli t1, t1, 2         ;\
  or t2, t1, t2          ;\
  csrw pmp_entry, t2     ;\
  li t0, pmpcfg      ;\
  csrs pmpcfg0, t0       ; 

// WBIT_FAIL: W bit is not set, write to entry should fail
#define WBIT_FAIL( testnum, entry_num, testround , str1, str2 ) \
write_to_entry ## entry_num ## _ ## str1:              \
  li TESTNUM, testnum;                                 \
  lw t0, jump_to_ ## str2;                             \
  la a2, entry ## entry_num ## _ ## str1;              \
wbit_test ## testround:                                \
  sw t0, 0(a2);                                        \
  j fail;                                              \
  j read_from_entry ## entry_num ## _ ## str1;         

// WBIT_SUCCESS: W bit is set, write to entry should succeed
#define WBIT_SUCCESS( testnum, entry_num, testround , str1, str2 ) \
write_to_entry ## entry_num ## _ ## str1:              \
  li TESTNUM, testnum;                                 \
  lw t0, jump_to_ ## str2;                             \
  la a2, entry ## entry_num ## _ ## str1;              \
wbit_test ## testround:                                \
  sw t0, 0(a2);                                        \
  j read_from_entry ## entry_num ## _ ## str1;         \
  j fail;                                              

// RBIT_FAIL: R bit is not set, read from entry should fail
#define RBIT_FAIL( testnum, entry_num, testround , str1, str2 ) \
read_from_entry ## entry_num ## _ ## str1:                   \
  li TESTNUM, testnum;                               \
  lw t0, jump_to_ ## str2;                             \
  la a2, entry ## entry_num ## _ ## str1;             \
rbit_test ## testround:                                \
  lw t1, 0(a2);                                        \
  nop;                                                 \
  j fail;                                              \
  j jump_to_entry ## entry_num ## _ ## str1; 

// RBIT_SUCCESS: R bit is not set, read from entry should succeed
#define RBIT_SUCCESS( testnum, entry_num, testround , str1, str2 ) \
read_from_entry ## entry_num ## _ ## str1:                   \
  li TESTNUM, testnum;                               \
  lw t0, jump_to_ ## str2;                             \
  la a2, entry ## entry_num ## _ ## str1;             \
rbit_test ## testround:                                \
  lw t1, 0(a2);                                        \
  nop;                                                 \
  j jump_to_entry ## entry_num ## _ ## str1;           \
  j fail;                                              

// XBIT: jump to tested pmp entry to excute
#define XBIT( testnum, entry_num, testround , str1, str2 ) \
jump_to_entry ## entry_num ## _ ## str1:              \
  li TESTNUM, testnum;                               \
  la a3, ## str2;                                   \
  la a4, fail;                                         \
  la a5, entry ## entry_num ## _ ## str1;              \
xbit_test ## testround:                                \
  jr a5;                                            \
  nop;                                               \
  j fail;                                            \
jump_to_ ## str2:                                   \
  jr a3;                                            

// XBIT: jump to tested pmp entry to excute
#define XBIT_FOR_MPRV( testnum, entry_num, testround , str1, str2, str3 ) \
jump_to_entry ## entry_num ## _ ## str1:              \
  li TESTNUM, testnum;                               \
  la a3, jump_to_ ## str2;                            \
  la a4, fail;                                         \
  la a5, entry ## entry_num ## _ ## str1;              \
xbit_test ## testround:                                \
  jr a5;                                            \
  nop;                                               \
  j fail;                                            \
jump_to_ ## str2:                                    \
  nop;                                               \
  nop;                                               \
  nop;                                               \
  nop;                                               \
  j str3;

/////////////////// PMP exception handler macro //////////////////////
// pmp_ifetch_error_handler
// LZB: use pmp_ifecth_error_handler instead of ifetch_error_handler to handle pmp ifetch error
#define PMP_IFETCH_ERROR( test_entry_num, end_entry_num, offset1, offset2 ) \
pmp_ifetch_error_handler:                                            \
  csrr t2, mepc;                                                     \
  la s0, entry ## test_entry_num ## _start;                          \
  beq t2, s0, 1f;                                                    \
  la s0, entry ## test_entry_num ## _end;                            \
  beq t2, s0, 2f;                                                    \
  j fail;                                                            \
1:                                                                   \
  la t2, entry ## end_entry_num ## _start + ## offset1;              \
  csrw mepc, t2;                                                     \
  j 3f;                                                              \
2:                                                                   \
  la t2, entry ## end_entry_num ## _start + ## offset2;              \
  csrw mepc, t2;                                                     \
  j 3f;                                                              \
3:                                                                   \
  USER_LOAD_CONTXT;                                                  \
  mret;

// pmp_load_error_handler
// LZB: use pmp_load_error_handler instead of ifetch_error_handler to handle pmp load error
#define PMP_LOAD_ERROR( testround0, testround1, offset0 ) \
pmp_load_error_handler:                                     \
  csrr t2, mepc;                                            \
  la s0, rbit_test ## testround0;                           \
  beq t2, s0, 1f;                                           \
  la s0, rbit_test ## testround1;                           \
  beq t2, s0, 1f;                                           \
  j fail;                                                   \
1:                                                          \
  addi t2, s0, ## offset0;                                  \
  csrw mepc, t2;                                            \
  USER_LOAD_CONTXT;                                         \
  mret;

// pmp_store_error_handler
// LZB: use pmp_store_error_handler instead of store_error_handler to handle pmp store error
#define PMP_STORE_ERROR( testround0, testround1, offset0 ) \
pmp_store_error_handler:                                   \
  csrr t2, mepc;                                           \
  la s0, wbit_test ## testround0;                          \
  beq t2, s0, 1f;                                          \
  la s0, wbit_test ## testround1;                          \
  beq t2, s0, 1f;                                          \
  j fail;                                                  \
1:                                                         \
  addi t2, t2, ## offset0;                                 \
  csrw mepc, t2;                                           \
  USER_LOAD_CONTXT;                                        \
  mret;

// PMP exception handler
#define PMP_MTVEC_HANDLER( offset0, offset1, offset2, offset3 ) \
mtvec_handler:                                               \
  j synchronous_exception;                                   \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
  j fail;                                                    \
synchronous_exception:                                       \
  csrr t2, mcause;                                           \
  li s0 , CAUSE_MASK;                                            \
  and t2, t2, s0;                                            \
  li s0, CAUSE_BREAKPOINT;                                   \
  beq t2, s0, 2f;                                            \
  li s0, CAUSE_MISALIGNED_LOAD;                              \
  beq t2, s0, 3f;                                            \
  li s0, CAUSE_MISALIGNED_STORE;                             \
  beq t2, s0, 4f;                                            \
  li s0, CAUSE_ILLEGAL_INSTRUCTION;                          \
  beq t2, s0, 1f;                                            \
  j fail;                                                    \
1:                                                           \
  csrr t2, mepc;                                             \
  addi t2, t2, ## offset0;                                   \
  csrw mepc, t2;                                             \
  j 5f;                                                      \
2:                                                           \
  li s0, MSTATUS_MPP;                                        \
  csrs mstatus, s0;                                          \
  csrr t2, mepc;                                             \
  addi t2, t2, ## offset1;                                   \
  csrw mepc, t2;                                             \
  j 5f;                                                      \
3:                                                           \
  csrr t2, mepc;                                             \
  addi t2, t2, ## offset2;                                   \
  csrw mepc, t2;                                             \
  j 5f;                                                      \
4:                                                           \
  csrr t2, mepc;                                             \
  addi t2, t2, ## offset3;                                   \
  csrw mepc, t2;                                             \
  j 5f;                                                      \
5:                                                           \
  USER_LOAD_CONTXT;                                          \
 mret;

// user_trap_vector for PMP test
// LZB: change mtvec to support user_trap_vector, use user_trap_vector to handle pmp exception other than trap_vector
// LZB: in user_trap_vector, use pmp_xx_error_handler instead of ifetch_error_handler, to support pmp exception test wihout change other test code
#define PMP_USER_TRAP_VECTOR                                                        \
  .align 6;                                                                         \
user_trap_vector:                                                                   \
        /* save context */                                                          \
		USER_STORE_CONTXT;                                                          \
        /* if it is an irq, jump to user_irq_handler */                             \
        csrr t2, mcause;                                                            \
		blez t2, user_irq_handler;                                                  \
        li s0, CAUSE_MASK;                                                          \
		and t2, t2, s0;                                                             \
        /* if it is a nmi, jump to user_nmi_handler */                              \
        li s0 , CAUSE_NMI;                                                          \
        beq t2 , s0 , user_nmi_handler;                                             \
        /* else, it is an exception, judge it */                                    \
        li s0, CAUSE_USER_ECALL;                                                    \
        beq t2, s0, write_tohost;                                                   \
                                                                                    \
        li s0, CAUSE_SUPERVISOR_ECALL;                                              \
        beq t2, s0, write_tohost;                                                   \
                                                                                    \
        li s0, CAUSE_MACHINE_ECALL;                                                 \
        beq t2, s0, write_tohost;                                                   \
        /* LZB: use pmp_ifecth_error_handler instead of ifetch_error_handler */     \
        li s0, CAUSE_FETCH_ACCESS;                                                  \
        beq t2, s0, pmp_ifetch_error_handler;                                       \
		/* LZB: use pmp_load_error_handler instead of load_error_handler */         \
        li s0, CAUSE_LOAD_ACCESS;                                                   \
        beq t2, s0, pmp_load_error_handler;                                         \
		/* LZB: use pmp_store_error_handler instead of store_error_handler */       \
        li s0, CAUSE_STORE_ACCESS;                                                  \
        beq t2, s0, pmp_store_error_handler;                                        \
        li s0, CAUSE_MISALIGNED_FETCH;                                              \
        beq t2, s0, user_misaligned_fetch_handler;                                  \
		/* LZB: when CAUSE_BREAKPOINT hanppens, jump to mtvec_handler */            \
        li s0, CAUSE_BREAKPOINT;                                                    \
        beq t2, s0, mtvec_handler;                                                  \
        /* if an mtvec_handler is defined, jump to it */                            \
        la t2, mtvec_handler;                                                       \
        beqz t2, 1f;                                                                \
        jr t2;                                                                      \
        /* was it an interrupt or an exception? */                                  \
  1:    csrr t2, mcause;                                                            \
        bgez t2, handle_exception;                                                  \
        INTERRUPT_HANDLER;                                                          \
  .align 2;                                                                         \
user_irq_handler:                                         ; \
  csrr t2, mcause                                         ; \
  li s0, 0x800003ff                                       ; \
  and t2, t2, s0                                          ; \
  li s0, CAUSE_IRQ_M_SFT                                  ; \
  beq t2, s0, 1f                                          ; \
  li s0, CAUSE_IRQ_M_TMR                                  ; \
  beq t2, s0, 2f                                          ; \
  li s0, CAUSE_IRQ_M_EXT                                  ; \
  beq t2, s0, 3f                                          ; \
  li s0, CAUSE_IRQ_M_BWE                                  ; \
  beq t2, s0, 4f                                          ; \
  li s0, CAUSE_IRQ_M_PMOV                                 ; \
  beq t2, s0, 5f                                          ; \
  j fail                                                  ; \
1:                                                        ; \
  li s0,  0x3                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
2:                                                        ; \
  li s0,  0x4                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
3:                                                        ; \
  li s0,  0x2                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
4:                                                        ; \
  li s0,  0x11                                            ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
5:                                                        ; \
  li s0,  0x12                                            ; \
  csrw mscratch, s0                                       ; \
6:                                                        ; \
  USER_LOAD_CONTXT                                        ; \
  mret                                                    ; \
user_nmi_handler:                   \
  USER_LOAD_CONTXT;                 \
  mret;                             \
  .align 2;                         \
user_misaligned_fetch_handler:      \
  CLEAN_NMI_INT;                    \
  USER_LOAD_CONTXT;                 \
  mret;                             \


#define SET_MPRV                                                                    \
  li t0, MSTATUS_MPRV;                                                              \
  csrs mstatus, t0;

#define PMP_USER_IRQ_VECTOR                                                    \
.align 6;                                                                      \
user_irq_trap_vector:                                                          \
        /* save context */                                                     \
		USER_STORE_CONTXT;                                                     \
        /* if it is an irq, jump to user_irq_handler */                        \
        csrr t2, mcause;                                                       \
		blez t2, pmp_irq_handler;                                              \
        li s0, CAUSE_MASK;                                                     \
		and t2, t2, s0;                                                        \
        /* if it is a nmi, jump to user_nmi_handler */                         \
        li s0 , CAUSE_NMI;                                                     \
        beq t2 , s0 , pmp_nmi_handler;                                         \
        /* else, it is an exception, judge it */                               \
        li s0, CAUSE_USER_ECALL;                                               \
        beq t2, s0, write_tohost;                                              \
        li s0, CAUSE_SUPERVISOR_ECALL;                                         \
        beq t2, s0, write_tohost;                                              \
        li s0, CAUSE_MACHINE_ECALL;                                            \
        beq t2, s0, write_tohost;                                              \
        /* LZB: use pmp_ifecth_error_handler instead of ifetch_error_handler */\
        li s0, CAUSE_FETCH_ACCESS;                                             \
        beq t2, s0, pmp_ifetch_error_handler;                                  \
		/* LZB: use pmp_load_error_handler instead of load_error_handler */    \
        li s0, CAUSE_LOAD_ACCESS;                                              \
        beq t2, s0, pmp_load_error_handler;                                    \
		/* LZB: use pmp_store_error_handler instead of store_error_handler */  \
        li s0, CAUSE_STORE_ACCESS;                                             \
        beq t2, s0, pmp_store_error_handler;                                   \
        li s0, CAUSE_MISALIGNED_FETCH;                                         \
        beq t2, s0, pmp_misaligned_fetch_handler;                              \
		/* LZB: when CAUSE_BREAKPOINT hanppens, jump to mtvec_handler */       \
        li s0, CAUSE_BREAKPOINT;                                               \
        beq t2, s0, mtvec_handler;                                             \
        /* if an mtvec_handler is defined, jump to it */                       \
        la t2, mtvec_handler;                                                  \
        beqz t2, 1f;                                                           \
        jr t2;                                                                 \
        /* was it an interrupt or an exception? */                             \
  1:    csrr t2, mcause;                                                       \
        bgez t2, handle_exception;                                             \
        INTERRUPT_HANDLER;

#define PMP_USER_IRQ_HANDLER(str0)  \
  .align 2;                         \
pmp_irq_handler:                    \
  csrr t2, mcause;                  \
  li s0, 0x800003ff;                \
  and t2, t2, s0;                   \
  li s0, CAUSE_IRQ_M_SFT;           \
  beq t2, s0, 1f;                   \
  li s0, CAUSE_IRQ_M_TMR;           \
  beq t2, s0, 2f;                   \
  li s0, CAUSE_IRQ_M_EXT;           \
  beq t2, s0, 3f;                   \
  j fail;                           \
                                    \
1:                                  \
  CLEAN_SFT_INT;                    \
  csrr  t2, mepc;                   \
  la    s0, ## str0 ## +4;          \
  bne   t2, s0, 4f;                 \
                                    \
  j entry1_test_begin;              \
                                    \
/* after testing PMP, jump back */  \
back_to_irq_id1_handler:            \
  nop;                              \
  nop;                              \
  nop;                              \
  nop;                              \
/* # before return, change mepc  */ \
  la t2, jump_to_test_end;          \
  csrw mepc, t2;                    \
  j 4f;                             \
                                    \
2:                                  \
  CLEAN_TMR_INT;                    \
  j 4f;                             \
3:                                  \
  CLEAN_EXT_INT;                    \
4:                                  \
  USER_LOAD_CONTXT;                 \
  mret;                             \

#define PMP_USER_NMI_HANDER        \
  .align 2;                        \
pmp_nmi_handler:                   \
  USER_LOAD_CONTXT;                 \
  mret;                             

#define PMP_USER_MAF_HANDER        \
  .align 2;                         \
pmp_misaligned_fetch_handler:      \
  CLEAN_NMI_INT;                    \
  USER_LOAD_CONTXT;                 \
  mret;                             \

// USER_NMI_HANDLER
#define USER_NMI_HANDLER( str0, str1, str2 ) \
user_nmi_vector:                              \
  USER_STORE_CONTXT;                                     \
/* unforce nmi_irq */                                    \
  CLOSE_NMI_FORCE_INT;                                  \
/* check mnpc */                                         \
  csrr t0, mnpc;                                         \
  la t1, nmi_test0;                                      \
  beq t0, t1, 1f;                                        \
/* since nmi_irq is generated when PC=nmi_test0 or   */  \
/*  PC=nmi_test0+4, double check is implemented here  */ \
  la t1, nmi_test0 + 4;                                  \
/* if nmi_irq is generated during other time, just return */ \
  beq t0, t1, 1f;                                        \
  j 2f;                                                  \
                                                         \
1:                                                       \
  j str0;                                                \
  nop;                                                   \
  nop;                                                   \
  nop;                                                   \
## str1:                                                 \
  la t0, ## str2;                                        \
  csrw mnpc, t0;                                         \
  j 2f;                                                  \
2:                                                       \
  USER_LOAD_CONTXT;                                      \
  mret;

//-----------------------------------------------------------------------
// Coverage Improve Test Macro
//-----------------------------------------------------------------------
// use real address
#define MEM_B2B_ACCESS( test_addr, val1, val2, val3, val4, testround ) \
  li t0, test_addr;                                                \
  li t1, val1;                                                     \
  li t2, val2;                                                     \
  li a0, val3;                                                     \
  li a1, val4;                                                     \
                                                                   \
  RAW ## testround:                                                \
    sw t1, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne t1, a2, fail;                                              \
  WAW ## testround:                                                \
    sw t2, 0(t0);                                                  \
    sw a0, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne a0, a2, fail;                                              \
                                                                   \
  WAR ## testround:                                                \
    lw t2, 0(t0);                                                  \
    sw a1, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne a1, a2, fail;                                              

#define MEM_ACCESS( test_addr, val1, val2, val3, val4, val5 )  \
  li t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li t2, val4;                                                      \
  li a1, val3;                                                      \
  li a2, val2;                                                      \
  li a3, val1;                                                      \
  li s0, val5;                                                      \
  sw t1, 0(t0);                                                     \
  lw a0, 0(t0);                                                     \
  bne t1, a0, fail;                                                 \
  sb t2, 0(t0);                                                     \
  sb a1, 1(t0);                                                     \
  sb a2, 2(t0);                                                     \
  sb a3, 3(t0);                                                     \
  lbu a0, 0(t0);                                                    \
  bne t2, a0, fail;                                                 \
  lbu a0, 1(t0);                                                    \
  bne a1, a0, fail;                                                 \
  lbu a0, 2(t0);                                                    \
  bne a2, a0, fail;                                                 \
  lbu a0, 3(t0);                                                    \
  bne a3, a0, fail;                                                 \
  lw a0, 0(t0);                                                     \
  bne s0, a0, fail;

#define MEM_BYTE_ACCESS( test_addr, val1, val2, val3, val4, val5 )  \
  li t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li t2, val4;                                                      \
  li a0, val3;                                                      \
  li a1, val2;                                                      \
  li a2, val1;                                                      \
  li s0, val5;                                                      \
  sw t1, 0(t0);                                                     \
  lw a3, 0(t0);                                                     \
  bne t1, a3, fail;                                                 \
  sb t2, 0(t0);                                                     \
  sb a0, 1(t0);                                                     \
  sb a1, 2(t0);                                                     \
  sb a2, 3(t0);                                                     \
  lbu a3, 0(t0);                                                    \
  bne t2, a3, fail;                                                 \
  lbu a3, 1(t0);                                                    \
  bne a0, a3, fail;                                                 \
  lbu a3, 2(t0);                                                    \
  bne a1, a3, fail;                                                 \
  lbu a3, 3(t0);                                                    \
  bne a2, a3, fail;                                                 \
  lw a3, 0(t0);                                                     \
  bne s0, a3, fail;

#define MEM_HWORD_ACCESS( test_addr, val1, val2, val3)              \
  li t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li a0, val2;                                                      \
  li a1, val1;                                                      \
  li a2, val3;                                                      \
  sw t1, 0(t0);                                                     \
  lw t2, 0(t0);                                                     \
  bne t1, t2, fail;                                                 \
  sh a0, 0(t0);                                                     \
  sh a1, 2(t0);                                                     \
  lhu t2, 0(t0);                                                    \
  bne a0, t2, fail;                                                 \
  lhu t2, 2(t0);                                                    \
  bne a1, t2, fail;                                                 \
  lw t2, 0(t0);                                                     \
  bne a2, t2, fail;                                                 

// use label
#define MEM_B2B_ACCESS_L( test_addr, val1, val2, val3, val4, testround ) \
  la t0, test_addr;                                                \
  li t1, val1;                                                     \
  li t2, val2;                                                     \
  li a0, val3;                                                     \
  li a1, val4;                                                     \
                                                                   \
  RAW ## testround:                                                \
    sw t1, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne t1, a2, fail;                                              \
  WAW ## testround:                                                \
    sw t2, 0(t0);                                                  \
    sw a0, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne a0, a2, fail;                                              \
                                                                   \
  WAR ## testround:                                                \
    lw t2, 0(t0);                                                  \
    sw a1, 0(t0);                                                  \
    lw a2, 0(t0);                                                  \
	bne a1, a2, fail;                                              

#define MEM_ACCESS_L( test_addr, val1, val2, val3, val4, val5 )     \
  la t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li t2, val4;                                                      \
  li a0, val3;                                                      \
  li a1, val2;                                                      \
  li a2, val1;                                                      \
  li s0, val5;                                                      \
  sw t1, 0(t0);                                                     \
  lw a3, 0(t0);                                                     \
  bne t1, a3, fail;                                                 \
  sb t2, 0(t0);                                                     \
  sb a0, 1(t0);                                                     \
  sb a1, 2(t0);                                                     \
  sb a2, 3(t0);                                                     \
  lbu a3, 0(t0);                                                    \
  bne t2, a3, fail;                                                 \
  lbu a3, 1(t0);                                                    \
  bne a0, a3, fail;                                                 \
  lbu a3, 2(t0);                                                    \
  bne a1, a3, fail;                                                 \
  lbu a3, 3(t0);                                                    \
  bne a2, a3, fail;                                                 \
  lw a3, 0(t0);                                                     \
  bne s0, a3, fail;

#define MEM_BYTE_ACCESS_L( test_addr, val1, val2, val3, val4, val5 )\
  la t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li t2, val4;                                                      \
  li a0, val3;                                                      \
  li a1, val2;                                                      \
  li a2, val1;                                                      \
  li s0, val5;                                                      \
  sw t1, 0(t0);                                                     \
  lw a3, 0(t0);                                                     \
  bne t1, a3, fail;                                                 \
  sb t2, 0(t0);                                                     \
  sb a0, 1(t0);                                                     \
  sb a1, 2(t0);                                                     \
  sb a2, 3(t0);                                                     \
  lbu a3, 0(t0);                                                    \
  bne t2, a3, fail;                                                 \
  lbu a3, 1(t0);                                                    \
  bne a0, a3, fail;                                                 \
  lbu a3, 2(t0);                                                    \
  bne a1, a3, fail;                                                 \
  lbu a3, 3(t0);                                                    \
  bne a2, a3, fail;                                                 \
  lw a3, 0(t0);                                                     \
  bne s0, a3, fail;

#define MEM_HWORD_ACCESS_L( test_addr, val1, val2, val3)            \
  la t0, test_addr;                                                 \
  li t1, 0x00000000;                                                \
  li t2, val2;                                                      \
  li a0, val1;                                                      \
  li a1, val3;                                                      \
  sw t1, 0(t0);                                                     \
  lw a2, 0(t0);                                                     \
  bne t1, a2, fail;                                                 \
  sh t2, 0(t0);                                                     \
  sh a0, 2(t0);                                                     \
  lhu a2, 0(t0);                                                    \
  bne a2, t2, fail;                                                 \
  lhu a2, 2(t0);                                                    \
  bne a0, a2, fail;                                                 \
  lw a2, 0(t0);                                                     \
  bne a1, a2, fail;                                                 

//-----------------------------------------------------------------------
// check CSR registers after exit debug mode, only in M-mode 
//-----------------------------------------------------------------------
#define DBG_MODE_EXIT_CHK( excp_cause, label, testreg, testreg1 )  \
/* # check MTVAL */                                         \
  csrr a1, mtval;                                           \
  bne a1, testreg, label;                                   \
/* # check MPP */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPP;                                       \
  and a1, a1, a0;                                           \
  bne a1, a0, label;                                        \
/* # check MPIE */                                          \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPIE;                                      \
  and a1, a1, a0;                                           \
  beq x0, a1, label;                                        \
/* # check MIE */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MIE;                                       \
  and a1, a1, a0;                                           \
  bne x0, a1, label;                                        \
/* # check mepc */                                          \
  csrr a1, mepc;                                            \
  bne testreg1, a1, label;                                  \
/* # check mcause */                                        \
  li a0, excp_cause;                                        \
  csrr a1, mcause;                                          \
  bne a0, a1, label;                                        \
/* # check mxstatus */                                      \
  li a0, 0xc0;                                              \
  csrr a1, mxstatus;                                        \
  and a0, a0, a1;                                           \
  li a1, 0x80;                                              \
  bne a0, a1, label;

//-----------------------------------------------------------------------
// check CSR registers after exit debug mode(entering debug mode via exception), only in M-mode,  
//-----------------------------------------------------------------------
#define EXCP_DBG_MODE_EXIT_CHK( excp_cause, label, testreg, testreg1 )  \
/* # check MTVAL */                                         \
  csrr a1, mtval;                                           \
  bne a1, testreg, label;                                   \
/* # check MPP */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPP;                                       \
  and a1, a1, a0;                                           \
  bne a1, a0, label;                                        \
/* # check MPIE */                                          \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPIE;                                      \
  and a1, a1, a0;                                           \
  beq x0, a1, label;                                        \
/* # check MIE */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MIE;                                       \
  and a1, a1, a0;                                           \
  bne x0, a1, label;                                        \
/* # check mepc */                                          \
  csrr a1, mepc;                                            \
  bne testreg1, a1, label;                                  \
/* # check mcause */                                        \
  li a0, excp_cause;                                        \
  csrr a1, mcause;                                          \
  bne a0, a1, label;                                        \
/* # check mxstatus */                                      \
  li a0, 0xc0;                                              \
  csrr a1, mxstatus;                                        \
  and a0, a0, a1;                                           \
  li a1, 0x0;                                               \
  bne a0, a1, label;

//-----------------------------------------------------------------------
// check CSR registers after exit debug mode(entering debug mode via irq), only in M-mode, not check mepc 
//-----------------------------------------------------------------------
#define IRQ_DBG_MODE_EXIT_CHK0( excp_cause, label, testreg )    \
/* # check MTVAL */                                         \
  csrr a1, mtval;                                           \
  bne a1, testreg, label;                                   \
/* # check MPP */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPP;                                       \
  and a1, a1, a0;                                           \
  bne a1, a0, label;                                        \
/* # check MPIE */                                          \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPIE;                                      \
  and a1, a1, a0;                                           \
  beq x0, a1, label;                                        \
/* # check MIE */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MIE;                                       \
  and a1, a1, a0;                                           \
  bne x0, a1, label;                                        \
/* # check mepc */                                          \
/*  csrr a1, mepc;  */                                      \
/*  bne testreg1, a1, label; */                             \
/* # check mcause */                                        \
  li a0, excp_cause;                                        \
  csrr a1, mcause;                                          \
  bne a0, a1, label;                                        \
/* # check mxstatus */                                      \
  li a0, 0xc0;                                              \
  csrr a1, mxstatus;                                        \
  and a0, a0, a1;                                           \
  li a1, 0x0;                                              \
  bne a0, a1, label;

//-----------------------------------------------------------------------
// check CSR registers after exit debug mode(entering debug mode via irq), only in M-mode, check mepc 
//-----------------------------------------------------------------------
#define IRQ_DBG_MODE_EXIT_CHK1( excp_cause, label, testreg, testreg1)    \
/* # check MTVAL */                                         \
  csrr a1, mtval;                                           \
  bne a1, testreg, label;                                   \
/* # check MPP */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPP;                                       \
  and a1, a1, a0;                                           \
  bne a1, a0, label;                                        \
/* # check MPIE */                                          \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPIE;                                      \
  and a1, a1, a0;                                           \
  beq x0, a1, label;                                        \
/* # check MIE */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MIE;                                       \
  and a1, a1, a0;    ,                                       \
  bne x0, a1, label;                                        \
/* # check mepc */                                          \
  csrr a1, mepc;                                            \
  bne testreg1, a1, label;                                  \
/* # check mcause */                                        \
  li a0, excp_cause;                                        \
  csrr a1, mcause;                                          \
  bne a0, a1, label;                                        \
/* # check mxstatus */                                      \
  li a0, 0xc0;                                              \
  csrr a1, mxstatus;                                        \
  and a0, a0, a1;                                           \
  li a1, 0x0;                                              \
  bne a0, a1, label;

//-----------------------------------------------------------------------
// check CSR registers after exit debug mode(entering debug mode via irq), only in M-mode, not check mepc 
//-----------------------------------------------------------------------
#define IRQ_DBG_MODE_EXIT_CHK_NMI( excp_cause, label, testreg )    \
/* # check MTVAL */                                         \
  csrr a1, mtval;                                           \
  bne a1, testreg, label;                                   \
/* # check MPP */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MPP;                                       \
  and a1, a1, a0;                                           \
  bne a1, a0, label;                                        \
/* # check MPIE */                                          \
/*  csrr a1, mstatus;*/                                     \
/*  li a0, MSTATUS_MPIE;*/                                  \
/*  and a1, a1, a0;*/                                       \
/*  beq x0, a1, label;*/                                    \
/* # check MIE */                                           \
  csrr a1, mstatus;                                         \
  li a0, MSTATUS_MIE;                                       \
  and a1, a1, a0;                                           \
  bne x0, a1, label;                                        \
/* # check mepc */                                          \
/*  csrr a1, mepc;  */                                      \
/*  bne testreg1, a1, label; */                             \
/* # check mcause */                                        \
  li a0, excp_cause;                                        \
  csrr a1, mcause;                                          \
  bne a0, a1, label;                                        \
/* # check mxstatus */                                      \
  li a0, 0xc0;                                              \
  csrr a1, mxstatus;                                        \
  and a0, a0, a1;                                           \
  li a1, 0x0;                                              \
  bne a0, a1, label;

//-----------------------------------------------------------------------
// Load context 
//-----------------------------------------------------------------------
#define USER_LOAD_CONTXT                                    \
  lw t0, 0*4(sp);                                           \
  lw t1, 1*4(sp);                                           \
  lw t2, 2*4(sp);                                           \
  lw s0, 3*4(sp);                                           \
  lw s1, 4*4(sp);                                           \
  lw a0, 5*4(sp);                                           \
  lw a1, 6*4(sp);                                           \
  lw a2, 7*4(sp);                                           \
  lw a3, 8*4(sp);                                           \
  lw a4, 9*4(sp);                                           \
  lw a5, 10*4(sp);                                          \
  addi sp, sp, 11*4;                                        \

//-----------------------------------------------------------------------
// Store context 
//-----------------------------------------------------------------------
#define USER_STORE_CONTXT                                   \
  addi sp, sp, -11*4;                                       \
  sw t0, 0*4(sp);                                           \
  sw t1, 1*4(sp);                                           \
  sw t2, 2*4(sp);                                           \
  sw s0, 3*4(sp);                                           \
  sw s1, 4*4(sp);                                           \
  sw a0, 5*4(sp);                                           \
  sw a1, 6*4(sp);                                           \
  sw a2, 7*4(sp);                                           \
  sw a3, 8*4(sp);                                           \
  sw a4, 9*4(sp);                                           \
  sw a5, 10*4(sp);                                          \



//-----------------------------------------------------------------------
// Load context 
//-----------------------------------------------------------------------
#define EUSER_LOAD_CONTXT                                    \
  lw t0, 11*4(sp);                                          \
  lw t1, 12*4(sp);                                          \
  lw t2, 13*4(sp);                                          \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/\
  lw s0, 14*4(sp);                                          \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/\
  csrw  mcause , t0;                                        \
  csrw  mepc , t1;                                          \
  csrw  mstatus , t2;                                       \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/\
  csrw  mxstatus , s0;                                      \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/\
  lw t0, 0*4(sp);                                           \
  lw t1, 1*4(sp);                                           \
  lw t2, 2*4(sp);                                           \
  lw s0, 3*4(sp);                                           \
  lw s1, 4*4(sp);                                           \
  lw a0, 5*4(sp);                                           \
  lw a1, 6*4(sp);                                           \
  lw a2, 7*4(sp);                                           \
  lw a3, 8*4(sp);                                           \
  lw a4, 9*4(sp);                                           \
  lw a5, 10*4(sp);                                          \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/                     \
  addi sp, sp, 15*4;                                        \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/                     \
                                                            \
  /*#`ifdef N100_CFG_EXCPSAVE_LEVEL_2*/                    \
  addi sp, sp, 14*4;                                        \
  /*#`endif N100_CFG_EXCPSAVE_LEVEL_2*/                    

//-----------------------------------------------------------------------
// Store context 
//-----------------------------------------------------------------------



#define EUSER_STORE_CONTXT                                   \
  /*#`ifdef N100_CFG_EXCPSAVE_LEVEL_2*/                     \
  addi sp, sp, -14*4;                                       \
  /*#`endif N100_CFG_EXCPSAVE_LEVEL_2*/                     \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/                    \
  addi sp, sp, -15*4;                                       \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/                    \
  sw t0, 0*4(sp);                                           \
  sw t1, 1*4(sp);                                           \
  sw t2, 2*4(sp);                                           \
  sw s0, 3*4(sp);                                           \
  sw s1, 4*4(sp);                                           \
  sw a0, 5*4(sp);                                           \
  sw a1, 6*4(sp);                                           \
  sw a2, 7*4(sp);                                           \
  sw a3, 8*4(sp);                                           \
  sw a4, 9*4(sp);                                           \
  sw a5, 10*4(sp);                                          \
  csrr t0 , mcause;                                         \
  csrr t1 , mepc;                                           \
  csrr t2 , mstatus;                                        \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/\
  csrr s0 , mxstatus;                                           \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/\
  sw t0, 11*4(sp);                                          \
  sw t1, 12*4(sp);                                          \
  sw t2, 13*4(sp);                                          \
  /*#`ifndef N100_CFG_EXCPSAVE_LEVEL_2*/\
  sw s0, 14*4(sp);                                          \
  /*#`endnif N100_CFG_EXCPSAVE_LEVEL_2*/\

//-----------------------------------------------------------------------
// Use Ebreak to switch to M-mode from U-mode
//-----------------------------------------------------------------------
#define EBREAK_MMODE_SWITH(testreg0, testreg1)              \
  li testreg0, MSTATUS_MPP;                                 \
  csrs mstatus, testreg0;                                   \
  csrr testreg1, mepc;                                      \
  addi testreg1, testreg1, 4;                               \
  csrw mepc, testreg1;

#define UNIVERSAL_TRAP_VECTOR                               \
  .align 6;                                                 \
user_trap_vector:                                         ; \
		USER_STORE_CONTXT;                                ; \
		csrr t2, mcause                                   ; \
		blez t2, user_irq_handler                         ; \
        li s0 , CAUSE_MASK                                ; \
		and t2, t2, s0                                    ; \
        li s0 , CAUSE_NMI                                 ; \
        beq t2 , s0 , user_nmi_handler                    ; \
        li s0, CAUSE_USER_ECALL                           ; \
        beq t2, s0, write_tohost                          ; \
        li s0, CAUSE_SUPERVISOR_ECALL                     ; \
        beq t2, s0, write_tohost                          ; \
        li s0, CAUSE_MACHINE_ECALL                        ; \
        beq t2, s0, write_tohost                          ; \
        la t2, mtvec_handler                              ; \
        beqz t2, 1f                                       ; \
        jr t2                                             ; \
  1:                                                      ; \
        csrr t2, mcause                                   ; \
        bgez t2, handle_exception                         ; \
        INTERRUPT_HANDLER                                 ; 


#define UNIVERSAL_IRQ_HANDLER                               \
.align 2;                                                   \
user_irq_handler:                                         ; \
  csrr t2, mcause                                         ; \
  li s0, 0x800003ff                                       ; \
  and t2, t2, s0                                          ; \
  li s0, CAUSE_IRQ_M_SFT                                  ; \
  beq t2, s0, 1f                                          ; \
  li s0, CAUSE_IRQ_M_TMR                                  ; \
  beq t2, s0, 2f                                          ; \
  li s0, CAUSE_IRQ_M_EXT                                  ; \
  beq t2, s0, 3f                                          ; \
  li s0, CAUSE_IRQ_M_BWE                                  ; \
  beq t2, s0, 4f                                          ; \
  li s0, CAUSE_IRQ_M_PMOV                                 ; \
  beq t2, s0, 5f                                          ; \
  j fail                                                  ; \
1:                                                        ; \
  li s0,  0x3                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
2:                                                        ; \
  li s0,  0x4                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
3:                                                        ; \
  li s0,  0x2                                             ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
4:                                                        ; \
  li s0,  0x11                                            ; \
  csrw mscratch, s0                                       ; \
  j 6f                                                    ; \
5:                                                        ; \
  li s0,  0x12                                            ; \
  csrw mscratch, s0                                       ; \
6:                                                        ; \
  USER_LOAD_CONTXT                                        ; \
  mret                                                    ; 

#define UNIVERSAL_NMI_HANDLER                               \
.align 2;                                                   \
user_nmi_handler:                                         ; \
  CLEAN_NMI_INT                                           ; \
  USER_LOAD_CONTXT                                        ; \
  mret                                                    ; 

#define CLOSE_CLIC                                                      \
  li   x8, 0;                                                           \
  /*li   x9, 0x`N100_CFG_CLIC_BASE_ADDR` + 0x1001;           */                                       \
  /*sb   x8, 0(x9) ;                                         */             \
  /*sb   x8, 4(x9) ;                                         */             \
  /*sb   x8, 8(x9) ;                                         */             \
  /*sb   x8, 12(x9) ;                                        */              \
  /*sb   x8, 16(x9) ;                                        */              \
  /*sb   x8, 20(x9) ;                                        */              \
  /*sb   x8, 24(x9) ;                                        */              \
  /*sb   x8, 28(x9) ;                                        */              \
  /*sb   x8, 32(x9) ;                                        */              \
  /*sb   x8, 36(x9) ;                                        */              \
  /*sb   x8, 40(x9) ;                                        */              \
  /*sb   x8, 44(x9) ;                                        */              \
  /*sb   x8, 48(x9) ;                                        */              \
  /*sb   x8, 52(x9) ;                                        */              \
  /*sb   x8, 56(x9) ;                                        */              \
  /*sb   x8, 60(x9) ;                                        */              \
  /*sb   x8, 64(x9) ;                                        */              \
  /*sb   x8, 68(x9) ;                                        */              \
  /*sb   x8, 72(x9) ;                                        */              \
  /*sb   x8, 76(x9) ;                                        */              \
  /*sb   x8, 80(x9) ;                                        */              \
  /*sb   x8, 84(x9) ;                                        */              \
  /*sb   x8, 88(x9) ;                                        */              \
  /*sb   x8, 92(x9) ;                                        */              \
  /*sb   x8, 96(x9) ;                                        */              \
  /*sb   x8, 100(x9) ;                                       */               \
  /*sb   x8, 104(x9) ;                                       */               \
  /*sb   x8, 108(x9) ;                                       */               \
  /*sb   x8, 112(x9) ;                                       */               \
  /*sb   x8, 116(x9) ;                                       */               \
  /*sb   x8, 120(x9) ;                                       */               \
  /*sb   x8, 124(x9) ;                                       */               \
  /*sb   x8, 128(x9) ;                                       */               \
  /*sb   x8, 132(x9) ;                                       */               \
  /*sb   x8, 136(x9) ;                                       */               \
  /*sb   x8, 140(x9) ;                                       */               \
  /*sb   x8, 144(x9) ;                                       */               \
  /*sb   x8, 148(x9) ;                                       */               \
  /*sb   x8, 152(x9) ;                                       */               \
  /*sb   x8, 156(x9) ;                                       */               \
  /*sb   x8, 160(x9) ;                                       */               \
  /*sb   x8, 164(x9) ;                                       */               \
  /*sb   x8, 168(x9) ;                                       */               \
  /*sb   x8, 172(x9) ;                                       */               \
  /*sb   x8, 176(x9) ;                                       */               \
  /*sb   x8, 180(x9) ;                                       */               \
  /*sb   x8, 184(x9) ;                                       */               \
  /*sb   x8, 188(x9) ;                                       */               \
  /*sb   x8, 192(x9) ;                                       */               \
  /*sb   x8, 196(x9) ;                                       */               \
  /*sb   x8, 200(x9) ;                                       */               \
  /*sb   x8, 204(x9) ;                                       */               \
  /*sb   x8, 208(x9) ;                                       */               \
  /*sb   x8, 212(x9) ;                                       */               \
  /*sb   x8, 216(x9) ;                                       */               \
  /*sb   x8, 220(x9) ;                                       */               \
  /*sb   x8, 224(x9) ;                                       */               \
  /*sb   x8, 228(x9) ;                                       */               \
  /*sb   x8, 232(x9) ;                                       */               \
  /*sb   x8, 236(x9) ;                                       */               \
  /*sb   x8, 240(x9) ;                                       */               \
  /*sb   x8, 244(x9) ;                                       */               \
  /*sb   x8, 248(x9) ;                                       */               \
  /*sb   x8, 252(x9) ;                                       */               \
  /*sb   x8, 256(x9) ;                                       */               \
  /*sb   x8, 260(x9) ;                                       */               \
  /*sb   x8, 264(x9) ;                                       */               \
  /*sb   x8, 268(x9) ;                                       */               \
  /*sb   x8, 272(x9) ;                                       */               \
  /*sb   x8, 276(x9) ;                                       */               \
  /*sb   x8, 280(x9) ;                                       */               

#define CHECK_IETRIG_MTVAL(label, j_label)                  \
  la t2, label                                            ; \
  csrr s0, mtval                                          ; \
  bne t2, s0, j_label                                     ; \

#define CHECK_ICOUNT_MTVAL(label, j_label)                  \
  la t2, label                                            ; \
  csrr s0, mtval                                          ; \
  beq t2, s0, j_label                                     ; \

#define CHECK_MCTRL_MTVAL(label, j_label)                  \
  la t2, label                                            ; \
  csrr s0, mtval                                          ; \
  beq t2, s0, j_label                                     ; \



#endif
