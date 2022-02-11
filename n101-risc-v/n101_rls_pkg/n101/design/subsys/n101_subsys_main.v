 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















  `include "n101_defines.v"


module n101_subsys_main(

  
  input  [`N101_PC_SIZE-1:0] reset_vector,

  
  input  mtime_toggle_a,
   `ifdef N101_DBG_TIMEOUT 
  input  dbg_toggle_a,
    `endif 
  
  input  por_rst_n,

  
  input  sys_rst_n,
        
  
  input  sys_clk,
      
      

  input  evt_i,
  input  nmi_i,

  `ifdef N101_HAS_SCP 
  input  trng_i,
  `endif

  output core_wfi_mode,
  output core_sleep_value,

  input  jtag_tck,
  input  jtag_tms,
  input  jtag_tdi,
  output jtag_tdo,
  output jtag_tdo_drv,

  output jtag_TMS_out,
  output jtag_DRV_TMS,
  
  output jtag_BK_TMS  ,
  output tap_rst_n   ,

  output sysrstreq,
  output dmactive,
  output dmactive_flag,

`ifdef N101_HAS_LOCKSTEP
  output lockstep_mis,
`endif

  input  io_pads_gpio_0_i_ival,
  output io_pads_gpio_0_o_oval,
  output io_pads_gpio_0_o_oe,
  output io_pads_gpio_0_o_ie,
  output io_pads_gpio_0_o_pue,
  output io_pads_gpio_0_o_ds,
  input  io_pads_gpio_1_i_ival,
  output io_pads_gpio_1_o_oval,
  output io_pads_gpio_1_o_oe,
  output io_pads_gpio_1_o_ie,
  output io_pads_gpio_1_o_pue,
  output io_pads_gpio_1_o_ds,
  input  io_pads_gpio_2_i_ival,
  output io_pads_gpio_2_o_oval,
  output io_pads_gpio_2_o_oe,
  output io_pads_gpio_2_o_ie,
  output io_pads_gpio_2_o_pue,
  output io_pads_gpio_2_o_ds,
  input  io_pads_gpio_3_i_ival,
  output io_pads_gpio_3_o_oval,
  output io_pads_gpio_3_o_oe,
  output io_pads_gpio_3_o_ie,
  output io_pads_gpio_3_o_pue,
  output io_pads_gpio_3_o_ds,
  input  io_pads_gpio_4_i_ival,
  output io_pads_gpio_4_o_oval,
  output io_pads_gpio_4_o_oe,
  output io_pads_gpio_4_o_ie,
  output io_pads_gpio_4_o_pue,
  output io_pads_gpio_4_o_ds,
  input  io_pads_gpio_5_i_ival,
  output io_pads_gpio_5_o_oval,
  output io_pads_gpio_5_o_oe,
  output io_pads_gpio_5_o_ie,
  output io_pads_gpio_5_o_pue,
  output io_pads_gpio_5_o_ds,
  input  io_pads_gpio_6_i_ival,
  output io_pads_gpio_6_o_oval,
  output io_pads_gpio_6_o_oe,
  output io_pads_gpio_6_o_ie,
  output io_pads_gpio_6_o_pue,
  output io_pads_gpio_6_o_ds,
  input  io_pads_gpio_7_i_ival,
  output io_pads_gpio_7_o_oval,
  output io_pads_gpio_7_o_oe,
  output io_pads_gpio_7_o_ie,
  output io_pads_gpio_7_o_pue,
  output io_pads_gpio_7_o_ds,
  input  io_pads_gpio_8_i_ival,
  output io_pads_gpio_8_o_oval,
  output io_pads_gpio_8_o_oe,
  output io_pads_gpio_8_o_ie,
  output io_pads_gpio_8_o_pue,
  output io_pads_gpio_8_o_ds,
  input  io_pads_gpio_9_i_ival,
  output io_pads_gpio_9_o_oval,
  output io_pads_gpio_9_o_oe,
  output io_pads_gpio_9_o_ie,
  output io_pads_gpio_9_o_pue,
  output io_pads_gpio_9_o_ds,
  input  io_pads_gpio_10_i_ival,
  output io_pads_gpio_10_o_oval,
  output io_pads_gpio_10_o_oe,
  output io_pads_gpio_10_o_ie,
  output io_pads_gpio_10_o_pue,
  output io_pads_gpio_10_o_ds,
  input  io_pads_gpio_11_i_ival,
  output io_pads_gpio_11_o_oval,
  output io_pads_gpio_11_o_oe,
  output io_pads_gpio_11_o_ie,
  output io_pads_gpio_11_o_pue,
  output io_pads_gpio_11_o_ds,
  input  io_pads_gpio_12_i_ival,
  output io_pads_gpio_12_o_oval,
  output io_pads_gpio_12_o_oe,
  output io_pads_gpio_12_o_ie,
  output io_pads_gpio_12_o_pue,
  output io_pads_gpio_12_o_ds,
  input  io_pads_gpio_13_i_ival,
  output io_pads_gpio_13_o_oval,
  output io_pads_gpio_13_o_oe,
  output io_pads_gpio_13_o_ie,
  output io_pads_gpio_13_o_pue,
  output io_pads_gpio_13_o_ds,
  input  io_pads_gpio_14_i_ival,
  output io_pads_gpio_14_o_oval,
  output io_pads_gpio_14_o_oe,
  output io_pads_gpio_14_o_ie,
  output io_pads_gpio_14_o_pue,
  output io_pads_gpio_14_o_ds,
  input  io_pads_gpio_15_i_ival,
  output io_pads_gpio_15_o_oval,
  output io_pads_gpio_15_o_oe,
  output io_pads_gpio_15_o_ie,
  output io_pads_gpio_15_o_pue,
  output io_pads_gpio_15_o_ds,
  input  io_pads_gpio_16_i_ival,
  output io_pads_gpio_16_o_oval,
  output io_pads_gpio_16_o_oe,
  output io_pads_gpio_16_o_ie,
  output io_pads_gpio_16_o_pue,
  output io_pads_gpio_16_o_ds,
  input  io_pads_gpio_17_i_ival,
  output io_pads_gpio_17_o_oval,
  output io_pads_gpio_17_o_oe,
  output io_pads_gpio_17_o_ie,
  output io_pads_gpio_17_o_pue,
  output io_pads_gpio_17_o_ds,
  input  io_pads_gpio_18_i_ival,
  output io_pads_gpio_18_o_oval,
  output io_pads_gpio_18_o_oe,
  output io_pads_gpio_18_o_ie,
  output io_pads_gpio_18_o_pue,
  output io_pads_gpio_18_o_ds,
  input  io_pads_gpio_19_i_ival,
  output io_pads_gpio_19_o_oval,
  output io_pads_gpio_19_o_oe,
  output io_pads_gpio_19_o_ie,
  output io_pads_gpio_19_o_pue,
  output io_pads_gpio_19_o_ds,
  input  io_pads_gpio_20_i_ival,
  output io_pads_gpio_20_o_oval,
  output io_pads_gpio_20_o_oe,
  output io_pads_gpio_20_o_ie,
  output io_pads_gpio_20_o_pue,
  output io_pads_gpio_20_o_ds,
  input  io_pads_gpio_21_i_ival,
  output io_pads_gpio_21_o_oval,
  output io_pads_gpio_21_o_oe,
  output io_pads_gpio_21_o_ie,
  output io_pads_gpio_21_o_pue,
  output io_pads_gpio_21_o_ds,
  input  io_pads_gpio_22_i_ival,
  output io_pads_gpio_22_o_oval,
  output io_pads_gpio_22_o_oe,
  output io_pads_gpio_22_o_ie,
  output io_pads_gpio_22_o_pue,
  output io_pads_gpio_22_o_ds,
  input  io_pads_gpio_23_i_ival,
  output io_pads_gpio_23_o_oval,
  output io_pads_gpio_23_o_oe,
  output io_pads_gpio_23_o_ie,
  output io_pads_gpio_23_o_pue,
  output io_pads_gpio_23_o_ds,
  input  io_pads_gpio_24_i_ival,
  output io_pads_gpio_24_o_oval,
  output io_pads_gpio_24_o_oe,
  output io_pads_gpio_24_o_ie,
  output io_pads_gpio_24_o_pue,
  output io_pads_gpio_24_o_ds,
  input  io_pads_gpio_25_i_ival,
  output io_pads_gpio_25_o_oval,
  output io_pads_gpio_25_o_oe,
  output io_pads_gpio_25_o_ie,
  output io_pads_gpio_25_o_pue,
  output io_pads_gpio_25_o_ds,
  input  io_pads_gpio_26_i_ival,
  output io_pads_gpio_26_o_oval,
  output io_pads_gpio_26_o_oe,
  output io_pads_gpio_26_o_ie,
  output io_pads_gpio_26_o_pue,
  output io_pads_gpio_26_o_ds,
  input  io_pads_gpio_27_i_ival,
  output io_pads_gpio_27_o_oval,
  output io_pads_gpio_27_o_oe,
  output io_pads_gpio_27_o_ie,
  output io_pads_gpio_27_o_pue,
  output io_pads_gpio_27_o_ds,
  input  io_pads_gpio_28_i_ival,
  output io_pads_gpio_28_o_oval,
  output io_pads_gpio_28_o_oe,
  output io_pads_gpio_28_o_ie,
  output io_pads_gpio_28_o_pue,
  output io_pads_gpio_28_o_ds,
  input  io_pads_gpio_29_i_ival,
  output io_pads_gpio_29_o_oval,
  output io_pads_gpio_29_o_oe,
  output io_pads_gpio_29_o_ie,
  output io_pads_gpio_29_o_pue,
  output io_pads_gpio_29_o_ds,
  input  io_pads_gpio_30_i_ival,
  output io_pads_gpio_30_o_oval,
  output io_pads_gpio_30_o_oe,
  output io_pads_gpio_30_o_ie,
  output io_pads_gpio_30_o_pue,
  output io_pads_gpio_30_o_ds,
  input  io_pads_gpio_31_i_ival,
  output io_pads_gpio_31_o_oval,
  output io_pads_gpio_31_o_oe,
  output io_pads_gpio_31_o_ie,
  output io_pads_gpio_31_o_pue,
  output io_pads_gpio_31_o_ds,

  input   io_pads_qspi_sck_i_ival,
  output  io_pads_qspi_sck_o_oval,
  output  io_pads_qspi_sck_o_oe,
  output  io_pads_qspi_sck_o_ie,
  output  io_pads_qspi_sck_o_pue,
  output  io_pads_qspi_sck_o_ds,
  input   io_pads_qspi_dq_0_i_ival,
  output  io_pads_qspi_dq_0_o_oval,
  output  io_pads_qspi_dq_0_o_oe,
  output  io_pads_qspi_dq_0_o_ie,
  output  io_pads_qspi_dq_0_o_pue,
  output  io_pads_qspi_dq_0_o_ds,
  input   io_pads_qspi_dq_1_i_ival,
  output  io_pads_qspi_dq_1_o_oval,
  output  io_pads_qspi_dq_1_o_oe,
  output  io_pads_qspi_dq_1_o_ie,
  output  io_pads_qspi_dq_1_o_pue,
  output  io_pads_qspi_dq_1_o_ds,
  input   io_pads_qspi_dq_2_i_ival,
  output  io_pads_qspi_dq_2_o_oval,
  output  io_pads_qspi_dq_2_o_oe,
  output  io_pads_qspi_dq_2_o_ie,
  output  io_pads_qspi_dq_2_o_pue,
  output  io_pads_qspi_dq_2_o_ds,
  input   io_pads_qspi_dq_3_i_ival,
  output  io_pads_qspi_dq_3_o_oval,
  output  io_pads_qspi_dq_3_o_oe,
  output  io_pads_qspi_dq_3_o_ie,
  output  io_pads_qspi_dq_3_o_pue,
  output  io_pads_qspi_dq_3_o_ds,
  input   io_pads_qspi_cs_0_i_ival,
  output  io_pads_qspi_cs_0_o_oval,
  output  io_pads_qspi_cs_0_o_oe,
  output  io_pads_qspi_cs_0_o_ie,
  output  io_pads_qspi_cs_0_o_pue,
  output  io_pads_qspi_cs_0_o_ds,

  input  test_mode 

  );

  `ifdef N101_TRACE_ITF
  wire trace_ivalid;
  wire trace_iexception;
  wire trace_interrupt;
  wire [`N101_XLEN-1:0] trace_cause;
  wire [`N101_XLEN-1:0] trace_tval;
  wire [`N101_XLEN-1:0] trace_iaddr;
  wire [`N101_XLEN-1:0] trace_instr;
  wire [1:0] trace_priv;
  `endif



     
  `ifndef N101_MEM_CLOCK_RATIO 
     
  wire clk_bus = sys_clk;
     
  wire bus_clk_en = 1'b1;
  `endif
     

     
  `ifdef N101_MEM_CLOCK_RATIO 
  wire sys_clk_div;
  wire clk_bus = sys_clk_div;


     `ifndef FPGA_SOURCE
         integer ratio_num;

         initial begin
             ratio_num = $urandom_range(1,3);
         end

         wire [4-1:0] ratio_cnt_r;
         wire ratio_cnt_inc = 1'b1;
         wire ratio_cnt_clr = (ratio_cnt_r == ratio_num[3:0]);
         wire ratio_cnt_ena = ratio_cnt_inc | ratio_cnt_clr;
         wire [4-1:0] ratio_cnt_nxt = ratio_cnt_clr ? 4'b0 : (ratio_cnt_r + 1'b1);
         n101_gnrl_dfflr #(4) ratio_cnt_dfflr (ratio_cnt_ena, ratio_cnt_nxt, ratio_cnt_r, sys_clk, sys_rst_n);

         wire bus_clk_en = ratio_cnt_clr;

         n101_clkgate u_ratio_clkgate(
           .clk_in   (sys_clk        ),
           .clkgate_bypass(test_mode  ),
           .clock_en (bus_clk_en),
           .clk_out  (sys_clk_div)
         );

     `else
         assign bus_clk_en = 1'b1;
         assign sys_clk_div = sys_clk;
     `endif

  `endif
     



   wire  qspi0_irq; 
   wire  qspi1_irq;
   wire  qspi2_irq;

   wire  uart0_irq;                
   wire  uart1_irq;                

   wire  pwm0_irq_0;
   wire  pwm0_irq_1;
   wire  pwm0_irq_2;
   wire  pwm0_irq_3;

   wire  pwm1_irq_0;
   wire  pwm1_irq_1;
   wire  pwm1_irq_2;
   wire  pwm1_irq_3;

   wire  pwm2_irq_0;
   wire  pwm2_irq_1;
   wire  pwm2_irq_2;
   wire  pwm2_irq_3;

   wire  i2c_mst_irq;

   wire  gpio_irq_0;
   wire  gpio_irq_1;
   wire  gpio_irq_2;
   wire  gpio_irq_3;
   wire  gpio_irq_4;
   wire  gpio_irq_5;
   wire  gpio_irq_6;
   wire  gpio_irq_7;
   wire  gpio_irq_8;
   wire  gpio_irq_9;
   wire  gpio_irq_10;
   wire  gpio_irq_11;
   wire  gpio_irq_12;
   wire  gpio_irq_13;
   wire  gpio_irq_14;
   wire  gpio_irq_15;
   wire  gpio_irq_16;
   wire  gpio_irq_17;
   wire  gpio_irq_18;
   wire  gpio_irq_19;
   wire  gpio_irq_20;
   wire  gpio_irq_21;
   wire  gpio_irq_22;
   wire  gpio_irq_23;
   wire  gpio_irq_24;
   wire  gpio_irq_25;
   wire  gpio_irq_26;
   wire  gpio_irq_27;
   wire  gpio_irq_28;
   wire  gpio_irq_29;
   wire  gpio_irq_30;
   wire  gpio_irq_31;


   wire [`N101_CLIC_IRQ_NUM-1:0] clic_irq_i;

   n101_subsys_clic_alloc u_n101_subsys_clic_alloc(
    .clic_irq_i             (clic_irq_i),

    .gpio_irq_0             (gpio_irq_0 ),
    .gpio_irq_1             (gpio_irq_1 ),
    .gpio_irq_2             (gpio_irq_2 ),
    .gpio_irq_3             (gpio_irq_3 ),
    .gpio_irq_4             (gpio_irq_4 ),
    .gpio_irq_5             (gpio_irq_5 ),
    .gpio_irq_6             (gpio_irq_6 ),
    .gpio_irq_7             (gpio_irq_7 ),
    .gpio_irq_8             (gpio_irq_8 ),
    .gpio_irq_9             (gpio_irq_9 ),
    .gpio_irq_10            (gpio_irq_10),
    .gpio_irq_11            (gpio_irq_11),
    .gpio_irq_12            (gpio_irq_12),
    .gpio_irq_13            (gpio_irq_13),
    .gpio_irq_14            (gpio_irq_14),
    .gpio_irq_15            (gpio_irq_15),

    .gpio_irq_16            (gpio_irq_16),
    .gpio_irq_17            (gpio_irq_17),
    .gpio_irq_18            (gpio_irq_18),
    .gpio_irq_19            (gpio_irq_19),
    .gpio_irq_20            (gpio_irq_20),
    .gpio_irq_21            (gpio_irq_21),
    .gpio_irq_22            (gpio_irq_22),
    .gpio_irq_23            (gpio_irq_23),
    .gpio_irq_24            (gpio_irq_24),
    .gpio_irq_25            (gpio_irq_25),
    .gpio_irq_26            (gpio_irq_26),
    .gpio_irq_27            (gpio_irq_27),
    .gpio_irq_28            (gpio_irq_28),
    .gpio_irq_29            (gpio_irq_29),
    .gpio_irq_30            (gpio_irq_30),
    .gpio_irq_31            (gpio_irq_31),

    .clk                    (clk_bus  ),
    .rst_n                  (sys_rst_n) 
  );

     




      `ifdef N101_HAS_FIO 
  
  wire                         fio_icb_cmd_valid;
  wire [`N101_FIO_ADDR_WIDTH-1:0]   fio_icb_cmd_addr; 
  wire                         fio_icb_cmd_read; 
  wire                         fio_icb_cmd_mmode; 
  wire                         fio_icb_cmd_dmode; 
  wire [`N101_XLEN-1:0]        fio_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      fio_icb_cmd_wmask;
  
  
  wire                         fio_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        fio_icb_rsp_rdata;
      `endif

  `ifdef N101_HAS_PPI 
  
  
  
  
      `ifdef N101_PPI_TYPE_ICB 
  
  wire                         ppi_icb_cmd_valid;
  wire                         ppi_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   ppi_icb_cmd_addr; 
  wire                         ppi_icb_cmd_read; 
  wire [`N101_XLEN-1:0]        ppi_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      ppi_icb_cmd_wmask;
  
  
  wire                         ppi_icb_rsp_valid;
  wire                         ppi_icb_rsp_ready;
  wire                         ppi_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        ppi_icb_rsp_rdata;
      `endif

      `ifdef N101_PPI_TYPE_APB 
  wire [`N101_PPI_ADDR_WIDTH-1:0]   ppi_apb_paddr;
  wire                         ppi_apb_pwrite;
  wire                         ppi_apb_psel;
  wire                         ppi_apb_penable;
  wire [`N101_XLEN-1:0]        ppi_apb_pwdata;
  wire [`N101_XLEN-1:0]        ppi_apb_prdata;
  wire                         ppi_apb_pready ; 
  wire                         ppi_apb_pslverr;
      `endif
  `endif

  `ifndef N101_HAS_PPI 
     
  
  wire                         biu2ppi_icb_cmd_valid;
  wire                         biu2ppi_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   biu2ppi_icb_cmd_addr; 
  wire                         biu2ppi_icb_cmd_read; 
  wire [`N101_XLEN-1:0]        biu2ppi_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      biu2ppi_icb_cmd_wmask;
  
  
  wire                         biu2ppi_icb_rsp_valid;
  wire                         biu2ppi_icb_rsp_ready;
  wire                         biu2ppi_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        biu2ppi_icb_rsp_rdata;
     
  `endif



  `ifdef N101_HAS_MEM_ITF 
      `ifdef N101_MEM_TYPE_ICB 
  wire                         mem_icb_cmd_valid;
  wire                         mem_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   mem_icb_cmd_addr; 
  wire                         mem_icb_cmd_read; 
  wire [`N101_XLEN-1:0]        mem_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      mem_icb_cmd_wmask;
  wire [1:0]                   mem_icb_cmd_size;
  wire [3:0]                   mem_icb_cmd_hprot;
  
  wire                         mem_icb_rsp_valid;
  wire                         mem_icb_rsp_ready;
  wire                         mem_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        mem_icb_rsp_rdata;
      `endif

      `ifdef N101_MEM_TYPE_AHBL 
     

  wire [1:0]                     mem_ahbl_htrans;   
  wire                           mem_ahbl_hwrite;   
  wire [`N101_ADDR_SIZE    -1:0] mem_ahbl_haddr;    
  wire [2:0]                     mem_ahbl_hsize;    
  wire [3:0]                     mem_ahbl_hprot; 
  wire [1:0]                     mem_ahbl_master;
  wire                           mem_ahbl_hlock;   
  wire [2:0]                     mem_ahbl_hburst;   
  wire [`N101_XLEN    -1:0]      mem_ahbl_hwdata;   
  wire [`N101_XLEN    -1:0]      mem_ahbl_hrdata;   
  wire [1:0]                     mem_ahbl_hresp;    
  wire                           mem_ahbl_hready;   
  `ifdef N101_HAS_BUS_PARITY
  wire [1:0]                     mem_ahbl_hcmdbpty;
  wire [3:0]                     mem_ahbl_hwdatabpty;
  wire [3:0]                     mem_ahbl_haddrbpty;
  wire [3:0]                     mem_ahbl_hrdatabpty;
  wire                           mem_ahbl_hrspbpty;
  wire                           mem_ahbl_phfatal;
  `endif
     
      `endif
  `endif







  
  
  
     `ifdef N101_HAS_ILM 

   `ifdef N101_LM_ITF_TYPE_AHBL 
      
  wire             ilm_hmastlock;
  wire [1:0]       ilm_htrans;   
  wire [`N101_ILM_ADDR_WIDTH-1:0]ilm_haddr;    
  wire [2:0]       ilm_hsize;    
  wire [`N101_ILM_DATA_WIDTH-1:0]ilm_hrdata;   
  wire [1:0]       ilm_hresp;    
  wire             ilm_hready;   
  wire             ilm_hwrite;   
  wire [3:0]       ilm_hprot; 
  wire [2:0]       ilm_hburst;   
  wire [`N101_ILM_DATA_WIDTH    -1:0]ilm_hwdata;   
  `ifdef N101_HAS_BUS_PARITY
  wire [1:0]       ilm_hcmdbpty;
  wire [3:0]       ilm_hwdatabpty;
  wire [3:0]       ilm_haddrbpty;
  wire [3:0]       ilm_hrdatabpty;
  wire             ilm_hrspbpty;
  wire             ilm_phfatal;
  `endif
  `endif
  
      `endif


  
  
  
     `ifdef N101_HAS_DLM 

  `ifdef N101_LM_ITF_TYPE_AHBL 
      
  wire             dlm_hmastlock;
  wire [1:0]       dlm_htrans;   
  wire [`N101_DLM_ADDR_WIDTH    -1:0]dlm_haddr;    
  wire [2:0]       dlm_hsize;    
  wire             dlm_hwrite;   
  wire [`N101_DLM_DATA_WIDTH    -1:0]dlm_hwdata;   
  wire [`N101_DLM_DATA_WIDTH    -1:0]dlm_hrdata;   
  wire [1:0]       dlm_hresp;    
  wire             dlm_hready;   
  wire [3:0]       dlm_hprot; 
  wire [2:0]       dlm_hburst;   
  wire [1:0]       dlm_master;   
  `ifdef N101_HAS_BUS_PARITY
  wire [1:0]       dlm_hcmdbpty;
  wire [3:0]       dlm_hwdatabpty;
  wire [3:0]       dlm_haddrbpty;
  wire [3:0]       dlm_hrdatabpty;
  wire             dlm_hrspbpty;
  wire             dlm_phfatal;
  `endif
  `endif
  
      `endif

     

     

  `ifdef N101_HAS_NICE 

  wire                        nice_clk          ;
  wire                        nice_active	     ;

  wire                        nice_mem_holdup   ;

  wire                        nice_req_valid    ;
  wire                        nice_req_ready    ;
  wire [`N101_XLEN-1:0]       nice_req_inst     ;
  wire [`N101_XLEN-1:0]       nice_req_rs1      ;
  wire [`N101_XLEN-1:0]       nice_req_rs2      ;
  wire                        nice_req_mmode    ;
  wire                        nice_1cyc_type    ;
  wire [`N101_XLEN-1:0]       nice_1cyc_rdat    ;	
  wire                        nice_1cyc_err     ;
  wire                        nice_rsp_valid    ;
  wire                        nice_rsp_ready    ;
  wire [`N101_XLEN-1:0]       nice_rsp_rdat     ;
  wire                        nice_rsp_err      ;
  wire                        nice_icb_cmd_valid;
  wire                        nice_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]  nice_icb_cmd_addr ;
  wire                        nice_icb_cmd_read ;
  wire [`N101_XLEN-1:0]       nice_icb_cmd_wdata;
  wire [1:0]                  nice_icb_cmd_size ;
  wire                        nice_icb_cmd_mmode;
  wire                        nice_icb_rsp_valid;
  wire                        nice_icb_rsp_ready;
  wire [`N101_XLEN-1:0]       nice_icb_rsp_rdata;
  wire                        nice_icb_rsp_err  ;

  `endif

     




 
 
 
 
 
 
  wire core_clk;
  wire core_clk_aon;

  reg core_clk_aon_en_r;

     
  `ifndef FPGA_SOURCE
         reg random_clken;

         initial begin
             random_clken = $urandom_range(0,1);
         end

  `else
         wire random_clken = 1'b0;
  `endif
     

  wire core_clk_en = 
     
      random_clken | 
     
      (~core_wfi_mode);

  wire evt_i_real ;
  wire nmi_i_real;
`ifdef N101_HAS_CLIC
  wire irq_i_real;
`endif
  wire aon_wake_up_detct =  (
                                  evt_i_real
                                | nmi_i_real
	   `ifndef FPGA_SOURCE
          
                    `ifdef N101_HAS_CLIC
                                | irq_i_real
                    `endif
	   `endif
                              );



  wire core_clk_aon_en =
     
                        random_clken | 
     
                        ((core_wfi_mode & core_sleep_value) ?
                                  aon_wake_up_detct
                              : 1'b1);

  reg evt_i_r;
  reg nmi_i_r;
`ifdef N101_HAS_CLIC
  reg irq_i_d1;
  reg irq_i_d2;
  reg irq_i_d3;
`endif

  wire deep_sleep = (core_wfi_mode & core_sleep_value);

  always@(posedge sys_clk or negedge sys_rst_n)
  begin
      if(~sys_rst_n) begin
        evt_i_r  <= 1'b0;
        nmi_i_r <= 1'b0;
`ifdef N101_HAS_CLIC
        irq_i_d1  <= 1'b0;
        irq_i_d2 <= 1'b0;
        irq_i_d3 <= 1'b0;
`endif
      end
      else begin
        evt_i_r   <= deep_sleep & evt_i;
        nmi_i_r   <= deep_sleep & nmi_i;
`ifdef N101_HAS_CLIC
        irq_i_d1   <= (|clic_irq_i);
        irq_i_d2 <= irq_i_d1;
        irq_i_d3 <= irq_i_d2;
`endif
      end
  end

  assign evt_i_real  = evt_i | evt_i_r;
  assign nmi_i_real  = nmi_i | nmi_i_r;
`ifdef N101_HAS_CLIC
  assign irq_i_real  = (|clic_irq_i) | irq_i_d1 | irq_i_d2 | irq_i_d3;
`endif

  n101_clkgate u_core_clkgate(
    .clk_in   (sys_clk      ),
    .clkgate_bypass(test_mode  ),
    .clock_en (core_clk_en),
    .clk_out  (core_clk)
  );

  n101_clkgate u_core_aon_clkgate(
    .clk_in   (sys_clk      ),
    .clkgate_bypass(test_mode  ),
    .clock_en (core_clk_aon_en),
    .clk_out  (core_clk_aon)
  );

  `ifdef N101_HAS_NICE 
    `ifndef N101_NICE_UVC
  n101_clkgate u_nice_clkgate(
    .clk_in   (sys_clk      ),
    .clkgate_bypass(test_mode  ),
    .clock_en (nice_active),
    .clk_out  (nice_clk)
  );
    `endif
  `endif










     
 `ifdef N101_HAS_ICACHE 
  wire                           icache_tag0_cs;  
  wire                           icache_tag0_we;  
  wire [`N101_ICACHE_TAG_RAM_AW-1:0] icache_tag0_addr; 
  wire [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag0_wdata;          
  wire [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag0_rdata;
  wire                       clk_icache_tag0;

  wire                           icache_data0_cs;  
  wire                           icache_data0_we;  
  wire [`N101_ICACHE_DATA_RAM_AW-1:0] icache_data0_addr; 
  wire [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data0_wdata;          
  wire [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data0_rdata;
  wire                       clk_icache_data0;

  `ifdef N101_ICACHE_2WAYS
  wire                           icache_tag1_cs;  
  wire                           icache_tag1_we;  
  wire [`N101_ICACHE_TAG_RAM_AW-1:0] icache_tag1_addr; 
  wire [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag1_wdata;          
  wire [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag1_rdata;
  wire                       clk_icache_tag1;

  wire                           icache_data1_cs;  
  wire                           icache_data1_we;  
  wire [`N101_ICACHE_DATA_RAM_AW-1:0] icache_data1_addr; 
  wire [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data1_wdata;          
  wire [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data1_rdata;
  wire                       clk_icache_data1;
  `endif
  `endif

  `ifdef N101_LM_ITF_TYPE_SRAM 
  wire              ilm_cs;  
  wire [`N101_ILM_RAM_AW-1:0] ilm_addr; 
  wire [`N101_ILM_RAM_MW-1:0] ilm_byte_we;
  wire [`N101_ILM_RAM_DW-1:0] ilm_wdata;          
  wire [`N101_ILM_RAM_DW-1:0] ilm_rdata;
  wire              clk_ilm_ram;
  `endif

  `ifdef N101_LM_ITF_TYPE_SRAM 
  wire              dlm_cs;  
  wire [`N101_DLM_RAM_AW-1:0] dlm_addr; 
  wire [`N101_DLM_RAM_MW-1:0] dlm_byte_we;
  wire [`N101_DLM_RAM_DW-1:0] dlm_wdata;          
  wire [`N101_DLM_RAM_DW-1:0] dlm_rdata;
  wire              clk_dlm_ram;
  `endif

     
     

     
     
     

    `ifndef N101_TMR_PRIVATE 
  wire mtip;
  wire msip;
    `endif
     

  
  
  
      `ifdef N101_HAS_LM_SLAVE

  `ifdef N101_LM_SALVE_AHBL 
   wire                       slv_huser         = 1'b0;
   wire                       slv_hsel          = 1'b0;   
   wire [1:0]                 slv_htrans        = 2'b0;   
   wire                       slv_hwrite        = 1'b0;   
   wire [`N101_ADDR_SIZE-1:0] slv_haddr         = 32'h0;    
   wire [2:0]                 slv_hsize         = 3'h0;    
   wire [`N101_XLEN-1:0]      slv_hwdata        = 32'h0;   

   wire  [`N101_XLEN-1:0]     slv_hrdata        ;   
   wire [1:0]                 slv_hresp         ;    
   wire                       slv_hready_in     = 1'b0;   
   wire                       slv_hready_out    ;   
  `endif

  `ifdef N101_LM_SALVE_ICB 
  
  wire                       slv_icb_cmd_valid = 0; 
  wire                       slv_icb_cmd_ready = 0; 
  wire [`N101_ADDR_SIZE-1:0] slv_icb_cmd_addr  = 0;
  wire                       slv_icb_cmd_read  = 0; 
  wire [`N101_XLEN-1:0]      slv_icb_cmd_wdata = 0; 
  wire [ 4-1:0]              slv_icb_cmd_wmask = 0; 
  wire [ 2-1:0]              slv_icb_cmd_size  = 0; 

  wire                       slv_icb_rsp_valid = 0; 
  wire                       slv_icb_rsp_ready = 0; 
  wire                       slv_icb_rsp_err   = 0;   
  wire [`N101_XLEN-1:0]      slv_icb_rsp_rdata = 0; 
  `endif
      `endif

`ifdef N101_HAS_BUS_PARITY
  wire bptylvl =1'b1;

n101_subsys_bpty u_n101_subsys_bpty(

  .bptylvl         (bptylvl         ),
  `ifdef N101_HAS_ILM
  `ifdef N101_LM_ITF_TYPE_AHBL 
  .ilm_htrans      (ilm_htrans      ), 
  .ilm_hwrite      (ilm_hwrite      ),
  .ilm_hmastlock   (ilm_hmastlock   ),
  .ilm_hwdata      (ilm_hwdata      ),   
  .ilm_haddr       (ilm_haddr       ),    
  .ilm_hsize       (ilm_hsize       ), 
  .ilm_hburst      (ilm_hburst      ),
  .ilm_hprot       (ilm_hprot       ), 
  .ilm_hrdata      (ilm_hrdata      ),   
  .ilm_hresp       (ilm_hresp       ), 
  .ilm_hready      (ilm_hready      ),   
       `ifdef N101_HAS_BUS_PARITY
  .ilm_hcmdbpty    (ilm_hcmdbpty    ),
  .ilm_hwdatabpty  (ilm_hwdatabpty  ),
  .ilm_haddrbpty   (ilm_haddrbpty   ),
  .ilm_hrdatabpty  (ilm_hrdatabpty  ),
  .ilm_hrspbpty    (ilm_hrspbpty    ),
  .ilm_phfatal     (ilm_phfatal     ),
       `endif
  `endif
  `endif

  `ifdef N101_HAS_DLM
  `ifdef N101_LM_ITF_TYPE_AHBL 
  .dlm_htrans      (dlm_htrans      ),   
  .dlm_hwrite      (dlm_hwrite      ),
  .dlm_hmastlock   (dlm_hmastlock   ),
  .dlm_hwdata      (dlm_hwdata      ),   
  .dlm_haddr       (dlm_haddr       ),    
  .dlm_hsize       (dlm_hsize       ),
  .dlm_hburst      (dlm_hburst      ), 
  .dlm_hprot       (dlm_hprot       ),  
  .dlm_master      (dlm_master      ),
  .dlm_hrdata      (dlm_hrdata      ),   
  .dlm_hresp       (dlm_hresp       ), 
  .dlm_hready      (dlm_hready      ),   
       `ifdef N101_HAS_BUS_PARITY
  .dlm_hcmdbpty    (dlm_hcmdbpty    ),
  .dlm_hwdatabpty  (dlm_hwdatabpty  ),
  .dlm_haddrbpty   (dlm_haddrbpty   ),
  .dlm_hrdatabpty  (dlm_hrdatabpty  ),
  .dlm_hrspbpty    (dlm_hrspbpty    ),
  .dlm_phfatal     (dlm_phfatal     ),
       `endif
  `endif
  `endif

  `ifdef N101_HAS_MEM_ITF
  `ifdef N101_MEM_TYPE_AHBL 
  .htrans          (mem_ahbl_htrans    ),   
  .hwrite          (mem_ahbl_hwrite    ),
  .hmastlock       (mem_ahbl_hlock     ),
  .hwdata          (mem_ahbl_hwdata    ),   
  .haddr           (mem_ahbl_haddr     ),    
  .hsize           (mem_ahbl_hsize     ), 
  .hburst          (mem_ahbl_hburst    ),
  .hprot           (mem_ahbl_hprot     ),
  .master          (mem_ahbl_master    ),
  .hrdata          (mem_ahbl_hrdata    ),   
  .hresp           (mem_ahbl_hresp     ), 
  .hready          (mem_ahbl_hready    ),   
       `ifdef N101_HAS_BUS_PARITY
  .hcmdbpty        (mem_ahbl_hcmdbpty  ),
  .hwdatabpty      (mem_ahbl_hwdatabpty),
  .haddrbpty       (mem_ahbl_haddrbpty ),
  .hrdatabpty      (mem_ahbl_hrdatabpty),
  .hrspbpty        (mem_ahbl_hrspbpty  ),
  .phfatal         (mem_ahbl_phfatal   ),
       `endif
  `endif
  `endif

  .clk             (core_clk_aon    ),
  .rst_n           (sys_rst_n       )
  );

`endif

  
  wire por_rst_n_clk;

  n101_reset_sync u_por_reset_tck_sync (
    .clk      (core_clk_aon),
    .rst_n_a  (por_rst_n),
    .reset_bypass(test_mode),
    .rst_n_sync(por_rst_n_clk) 
  );

  reg [1:0] dmactive_dly;
  reg       dmactive_flg;
  wire      dmactive_re = ~dmactive_dly[1] & dmactive_dly[0];
  assign    dmactive_flag = dmactive_flg;
    always @(posedge core_clk_aon or negedge por_rst_n_clk) begin
        if(~por_rst_n_clk) begin
            dmactive_dly <= 2'b0;
            dmactive_flg <= 1'b0;
        end
        else begin
            dmactive_dly <= {dmactive_dly[1],dmactive};
            dmactive_flg <= dmactive_re ? 1'b1 : sysrstreq ? 1'b0 : dmactive_flg;
        end
    end
  


  assign dmactive = 1'b0;
  assign tap_rst_n = 1'b0;
`ifndef N101_HAS_DEBUG
  assign jtag_tdo = 1'b0;
  assign jtag_tdo_drv = 1'b0;
  assign jtag_TMS_out = 1'b0;
  assign jtag_DRV_TMS = 1'b0;
  assign jtag_BK_TMS = 1'b0;
`endif

  n101_core_wrapper u_n101_core_wrapper(

     
`ifdef N101_HAS_DEBUG
     
    .hart_halted     (), 
     
     
     
     

     
     .jtag_TCK    (jtag_tck),
     .jtag_TMS_in (jtag_tms),
     .jtag_TDI    (jtag_tdi),
     .jtag_TDO    (jtag_tdo),
     .jtag_DRV_TDO(jtag_tdo_drv),
     .jtag_dwen   (),

     .jtag_TMS_out(jtag_TMS_out),
     .jtag_DRV_TMS(jtag_DRV_TMS),
     
     .jtag_BK_TMS          (jtag_BK_TMS          ),

     .i_dbg_stop  (1'b0),
     
     

     

`endif
     
    .sysrstreq       (sysrstreq       ),

  `ifdef N101_TRACE_ITF
    .trace_ivalid    (trace_ivalid    ),
    .trace_iexception(trace_iexception),
    .trace_cause     (trace_cause     ),
    .trace_tval      (trace_tval      ),
    .trace_interrupt (trace_interrupt ),
    .trace_iaddr     (trace_iaddr     ),
    .trace_instr     (trace_instr     ),
    .trace_priv      (trace_priv      ),
  `endif

      
      


     
    `ifndef N101_TMR_PRIVATE 
    .mtip (mtip),
    .msip (msip),
    `endif
     

     
    `ifdef N101_TMR_PRIVATE 
     
      
     
    .mtime_toggle_a     (mtime_toggle_a  ),
     
    `endif
     
    `ifdef N101_DBG_TIMEOUT 
    .dbg_toggle_a     (dbg_toggle_a),
    `endif 
     
   `ifdef N101_HAS_CLIC
     
      
      
    .clic_irq            (clic_irq_i),
     
   `endif
     




      
      
    .reset_vector             (reset_vector),

    
      
      
    .core_wfi_mode            (core_wfi_mode),
    .core_sleep_value         (core_sleep_value),

      
      

      
      
    .hart_id            (32'b0),  

     
  `ifdef N101_HAS_ICACHE 
    .icache_disable_init  (1'b0),

    .icache_tag0_cs       (icache_tag0_cs   ),
    .icache_tag0_we       (icache_tag0_we   ),
    .icache_tag0_addr     (icache_tag0_addr ),
    .icache_tag0_wdata      (icache_tag0_wdata  ),        
    .icache_tag0_rdata     (icache_tag0_rdata ),
    .clk_icache_tag0      (clk_icache_tag0  ),
                                                
    .icache_data0_cs       (icache_data0_cs   ),
    .icache_data0_we       (icache_data0_we   ),
    .icache_data0_addr     (icache_data0_addr ),
    .icache_data0_wdata      (icache_data0_wdata  ),        
    .icache_data0_rdata     (icache_data0_rdata ),
    .clk_icache_data0      (clk_icache_data0  ),
                                                
    `ifdef N101_ICACHE_2WAYS
    .icache_tag1_cs       (icache_tag1_cs   ),
    .icache_tag1_we       (icache_tag1_we   ),
    .icache_tag1_addr     (icache_tag1_addr ),
    .icache_tag1_wdata      (icache_tag1_wdata  ),        
    .icache_tag1_rdata     (icache_tag1_rdata ),
    .clk_icache_tag1      (clk_icache_tag1  ),

    .icache_data1_cs       (icache_data1_cs   ),
    .icache_data1_we       (icache_data1_we   ),
    .icache_data1_addr     (icache_data1_addr ),
    .icache_data1_wdata      (icache_data1_wdata  ),        
    .icache_data1_rdata     (icache_data1_rdata ),
    .clk_icache_data1      (clk_icache_data1  ),
    `endif
  `endif

  `ifdef N101_HAS_ILM 
    `ifdef N101_LM_ITF_TYPE_SRAM 
    .ilm_cs       (ilm_cs      ),  
    .ilm_addr     (ilm_addr    ), 
    .ilm_byte_we  (ilm_byte_we ),
    .ilm_wdata    (ilm_wdata   ),          
    .ilm_rdata    (ilm_rdata   ),
    .clk_ilm_ram  (clk_ilm_ram ),
    `endif
  `endif

  `ifdef N101_HAS_DLM 
    `ifdef N101_LM_ITF_TYPE_SRAM 
    .dlm_cs       (dlm_cs      ),  
    .dlm_addr     (dlm_addr    ), 
    .dlm_byte_we  (dlm_byte_we ),
    .dlm_wdata    (dlm_wdata   ),          
    .dlm_rdata    (dlm_rdata   ),
    .clk_dlm_ram  (clk_dlm_ram ),
    `endif
  `endif


  `ifdef N101_HAS_NICE 
      
      

    .nice_mem_holdup         (nice_mem_holdup    ), 
    
    
    .nice_req_valid          (nice_req_valid     ), 
    .nice_req_ready          (nice_req_ready     ), 
    .nice_req_inst           (nice_req_inst      ), 
    .nice_req_rs1            (nice_req_rs1       ), 
    .nice_req_rs2            (nice_req_rs2       ), 
    .nice_req_mmode          (nice_req_mmode     ), 

    
    
    
    .nice_rsp_1cyc_type      (nice_1cyc_type     ), 
    .nice_rsp_1cyc_dat       (nice_1cyc_rdat     ), 
    .nice_rsp_1cyc_err       (nice_1cyc_err      ),
                                              
    .nice_rsp_multicyc_valid (nice_rsp_valid     ), 
    .nice_rsp_multicyc_ready (nice_rsp_ready     ), 
    .nice_rsp_multicyc_dat   (nice_rsp_rdat      ), 
    .nice_rsp_multicyc_err   (nice_rsp_err       ),

    
    .nice_icb_cmd_valid      (nice_icb_cmd_valid ), 
    .nice_icb_cmd_ready      (nice_icb_cmd_ready ), 
    .nice_icb_cmd_addr       (nice_icb_cmd_addr  ), 
    .nice_icb_cmd_read       (nice_icb_cmd_read  ), 
    .nice_icb_cmd_wdata      (nice_icb_cmd_wdata ), 
    .nice_icb_cmd_size       (nice_icb_cmd_size  ), 
    .nice_icb_cmd_mmode      (nice_icb_cmd_mmode ), 

    
    .nice_icb_rsp_valid      (nice_icb_rsp_valid ), 
    .nice_icb_rsp_ready      (nice_icb_rsp_ready ), 
    .nice_icb_rsp_rdata      (nice_icb_rsp_rdata ), 
    .nice_icb_rsp_err        (nice_icb_rsp_err   ), 

  `endif




  `ifdef N101_HAS_PPI 
  
  
  
  
      `ifdef N101_PPI_TYPE_ICB 
    .ppi_icb_cmd_valid     (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready     (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr      (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_read      (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata     (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask     (ppi_icb_cmd_wmask),
    
    .ppi_icb_rsp_valid     (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready     (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err       (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_rdata     (ppi_icb_rsp_rdata),
      `endif

      `ifdef N101_PPI_TYPE_APB 
    .ppi_paddr         (ppi_apb_paddr  ),
    .ppi_pwrite        (ppi_apb_pwrite ),
    .ppi_psel          (ppi_apb_psel   ),
    .ppi_dmode         (),
    .ppi_pprot         (),
    .ppi_pstrobe       (),
    .ppi_penable       (ppi_apb_penable), 
    .ppi_pwdata        (ppi_apb_pwdata ),
    .ppi_prdata        (ppi_apb_prdata ),
    .ppi_pready        (ppi_apb_pready ),
    .ppi_pslverr       (ppi_apb_pslverr),
      `endif

  `endif


  `ifdef N101_HAS_FIO 
    .fio_cmd_valid     (fio_icb_cmd_valid),
    .fio_cmd_addr      (fio_icb_cmd_addr ),
    .fio_cmd_read      (fio_icb_cmd_read ),
    .fio_cmd_mmode     (fio_icb_cmd_mmode),
    .fio_cmd_dmode     (fio_icb_cmd_dmode),
    .fio_cmd_wdata     (fio_icb_cmd_wdata),
    .fio_cmd_wmask     (fio_icb_cmd_wmask),
                                         
    .fio_rsp_err       (fio_icb_rsp_err  ),
    .fio_rsp_rdata     (fio_icb_rsp_rdata),
  `endif

  
      `ifdef N101_HAS_BUS_PARITY
    .bptylvl            (bptylvl          ),
      `endif

      `ifdef N101_MEM_TYPE_ICB 
    .mem_icb_cmd_valid  (mem_icb_cmd_valid),
    .mem_icb_cmd_ready  (mem_icb_cmd_ready),
    .mem_icb_cmd_addr   (mem_icb_cmd_addr ),
    .mem_icb_cmd_read   (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata  (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask  (mem_icb_cmd_wmask),
    .mem_icb_cmd_size   (mem_icb_cmd_size ),
    .mem_icb_cmd_hprot  (mem_icb_cmd_hprot),
    .mem_icb_cmd_dmode  (),
    
    .mem_icb_rsp_valid  (mem_icb_rsp_valid),
    .mem_icb_rsp_ready  (mem_icb_rsp_ready),
    .mem_icb_rsp_err    (mem_icb_rsp_err  ),
    .mem_icb_rsp_rdata  (mem_icb_rsp_rdata),
      `endif

      `ifdef N101_MEM_TYPE_AHBL 
        `ifdef N101_MEM_CLOCK_RATIO 
     .bus_clk_en(bus_clk_en),                                                                                                     
        `endif
     
    .htrans    (mem_ahbl_htrans),   
    .hwrite    (mem_ahbl_hwrite),   
    .haddr     (mem_ahbl_haddr ),   
    .hsize     (mem_ahbl_hsize ),   
    .hprot     (mem_ahbl_hprot ), 
    .master    (mem_ahbl_master),
    .hburst    (mem_ahbl_hburst),   
    .hwdata    (mem_ahbl_hwdata),   
    .hrdata    (mem_ahbl_hrdata),   
    .hresp     (mem_ahbl_hresp ),   
    .hready    (mem_ahbl_hready),   
    .hmastlock (mem_ahbl_hlock ),  
  `ifdef N101_HAS_BUS_PARITY
    .hcmdbpty  (mem_ahbl_hcmdbpty   ),
    .hwdatabpty(mem_ahbl_hwdatabpty ),
    .haddrbpty (mem_ahbl_haddrbpty  ),
    .hrdatabpty(mem_ahbl_hrdatabpty ),
    .hrspbpty  (mem_ahbl_hrspbpty   ),
    .phfatal   (mem_ahbl_phfatal    ),  
  `endif
     
      `endif

  
  `ifdef N101_HAS_ILM 

  `ifdef N101_LM_ITF_TYPE_AHBL 
      
    .ilm_hwdata   (ilm_hwdata),
    .ilm_hwrite   (ilm_hwrite),
    .ilm_hmastlock(ilm_hmastlock),
    .ilm_htrans   (ilm_htrans),
    .ilm_haddr    (ilm_haddr ),
    .ilm_hsize    (ilm_hsize ),
    .ilm_hrdata   (ilm_hrdata),
    .ilm_hresp    (ilm_hresp ),
    .ilm_hready   (ilm_hready),
    .ilm_hburst   (ilm_hburst),
    .ilm_hprot    (ilm_hprot ),
  `ifdef N101_HAS_BUS_PARITY
    .ilm_hcmdbpty   (ilm_hcmdbpty   ),
    .ilm_hwdatabpty (ilm_hwdatabpty ),
    .ilm_haddrbpty  (ilm_haddrbpty  ),
    .ilm_hrdatabpty (ilm_hrdatabpty ),
    .ilm_hrspbpty   (ilm_hrspbpty   ),
    .ilm_phfatal    (ilm_phfatal    ),  
  `endif
  `endif
  
      `endif



  
  
  
     `ifdef N101_HAS_DLM 

  `ifdef N101_LM_ITF_TYPE_AHBL 
    .dlm_hmastlock(dlm_hmastlock),
    .dlm_htrans   (dlm_htrans),    
    .dlm_hwrite   (dlm_hwrite),    
    .dlm_haddr    (dlm_haddr ),    
    .dlm_hsize    (dlm_hsize ),    
    .dlm_hwdata   (dlm_hwdata),    
    .dlm_hrdata   (dlm_hrdata),    
    .dlm_hresp    (dlm_hresp ),    
    .dlm_hready   (dlm_hready),    
    .dlm_hburst   (dlm_hburst),
    .dlm_hprot    (dlm_hprot ),
    .dlm_master   (dlm_master),
  `ifdef N101_HAS_BUS_PARITY
    .dlm_hcmdbpty   (dlm_hcmdbpty   ),
    .dlm_hwdatabpty (dlm_hwdatabpty ),
    .dlm_haddrbpty  (dlm_haddrbpty  ),
    .dlm_hrdatabpty (dlm_hrdatabpty ),
    .dlm_hrspbpty   (dlm_hrspbpty   ),
    .dlm_phfatal    (dlm_phfatal    ),  
  `endif

  `endif
  
      `endif
	
	  
      `ifdef N101_HAS_LM_SLAVE

    `ifdef N101_LM_SALVE_AHBL 
    .slv_huser         (slv_huser),
    .slv_hsel          (slv_hsel),   
    .slv_htrans        (slv_htrans),   
    .slv_hwrite        (slv_hwrite),   
    .slv_haddr         (slv_haddr),    
    .slv_hsize         (slv_hsize),    
    .slv_hwdata        (slv_hwdata),   

    .slv_hrdata        (slv_hrdata),   
    .slv_hresp         (slv_hresp),    
    .slv_hready_in     (slv_hready_in),   
    .slv_hready_out    (slv_hready_out),   
    `endif

  `ifdef N101_LM_SALVE_ICB 
    .slv_icb_cmd_valid (0), 
    .slv_icb_cmd_ready (0), 
    .slv_icb_cmd_addr  (0),
    .slv_icb_cmd_read  (0), 
    .slv_icb_cmd_wdata (0), 
    .slv_icb_cmd_wmask (0), 
    .slv_icb_cmd_size  (0), 

    .slv_icb_rsp_valid (0), 
    .slv_icb_rsp_ready (0), 
    .slv_icb_rsp_err   (0),   
    .slv_icb_rsp_rdata (0), 
  `endif
      `endif

     
  `ifdef N101_HAS_LOCKSTEP
    .lockstep_en        (1'b1        ), 
  `ifdef FPGA_SOURCE
    .lockstep_chck_en   (1'b1        ), 
  `endif
  `ifndef FPGA_SOURCE
    .lockstep_chck_en   (1'b0        ), 
  `endif
    .lockstep_mis       (lockstep_mis), 
    .lockstep_mis_cause (),
  `endif

     .tx_evt  (),
     .rx_evt  (evt_i),

  `ifdef N101_HAS_SCP 
     .scp_en  (1'b1  ),
     .trng_i  (32'h5a5a5a5a),
     .trng_vld_i(1'b0),
  `endif

     .clkgate_bypass   (test_mode), 
     .reset_bypass     (test_mode), 
     .core_clk         (core_clk  ),
     .core_clk_aon     (core_clk_aon),
     .core_reset_n     (sys_rst_n),
     .por_reset_n      (por_rst_n)

  );


     
      `ifndef N101_D_SHARE_ILM 
     
  wire                          biu2ilm_icb_cmd_valid;
  wire                          biu2ilm_icb_cmd_ready;
  wire  [`N101_ILM_ADDR_WIDTH-1:0]   biu2ilm_icb_cmd_addr; 
  wire                          biu2ilm_icb_cmd_read; 
  wire  [`N101_XLEN-1:0]        biu2ilm_icb_cmd_wdata;
  wire  [`N101_XLEN/8-1:0]      biu2ilm_icb_cmd_wmask;
  
  wire                          biu2ilm_icb_rsp_valid;
  wire                          biu2ilm_icb_rsp_ready;
  wire                          biu2ilm_icb_rsp_err;
  wire  [`N101_XLEN-1:0]        biu2ilm_icb_rsp_rdata;
     
       `endif
     

  wire                               biu2dlm_icb_cmd_valid;
  wire                               biu2dlm_icb_cmd_ready;
  wire  [`N101_DLM_ADDR_WIDTH-1:0]   biu2dlm_icb_cmd_addr; 
  wire                               biu2dlm_icb_cmd_read; 
  wire  [`N101_XLEN-1:0]             biu2dlm_icb_cmd_wdata;
  wire  [`N101_XLEN/8-1:0]           biu2dlm_icb_cmd_wmask;
  
  wire                               biu2dlm_icb_rsp_valid;
  wire                               biu2dlm_icb_rsp_ready;
  wire                               biu2dlm_icb_rsp_err;
  wire  [`N101_XLEN-1:0]             biu2dlm_icb_rsp_rdata;



 n101_subsys_lm u_n101_subsys_lm(

     
  `ifdef N101_HAS_ILM 
    `ifdef N101_LM_ITF_TYPE_SRAM 
    .i_ilm_ram_cs       (ilm_cs      ),  
    .i_ilm_ram_addr     (ilm_addr    ), 
    .i_ilm_ram_wem      (ilm_byte_we ),
    .i_ilm_ram_din    (ilm_wdata   ),          
    .i_ilm_ram_dout    (ilm_rdata   ),
    .i_clk_ilm_ram  (clk_ilm_ram ),
    `endif
  `endif

  `ifdef N101_HAS_DLM 
    `ifdef N101_LM_ITF_TYPE_SRAM 
    .i_dlm_ram_cs       (dlm_cs      ),  
    .i_dlm_ram_addr     (dlm_addr    ), 
    .i_dlm_ram_wem      (dlm_byte_we ),
    .i_dlm_ram_din    (dlm_wdata   ),          
    .i_dlm_ram_dout    (dlm_rdata   ),
    .i_clk_dlm_ram  (clk_dlm_ram ),
    `endif
  `endif

      `ifndef N101_D_SHARE_ILM 
     
    .biu2ilm_icb_cmd_valid (biu2ilm_icb_cmd_valid),
    .biu2ilm_icb_cmd_ready (biu2ilm_icb_cmd_ready),
    .biu2ilm_icb_cmd_addr  (biu2ilm_icb_cmd_addr ), 
    .biu2ilm_icb_cmd_read  (biu2ilm_icb_cmd_read ), 
    .biu2ilm_icb_cmd_wdata (biu2ilm_icb_cmd_wdata),
    .biu2ilm_icb_cmd_wmask (biu2ilm_icb_cmd_wmask),
    
    .biu2ilm_icb_rsp_valid (biu2ilm_icb_rsp_valid),
    .biu2ilm_icb_rsp_ready (biu2ilm_icb_rsp_ready),
    .biu2ilm_icb_rsp_err   (biu2ilm_icb_rsp_err  ),
    .biu2ilm_icb_rsp_rdata (biu2ilm_icb_rsp_rdata),
     
       `endif
     

    .biu2dlm_icb_cmd_valid (biu2dlm_icb_cmd_valid),
    .biu2dlm_icb_cmd_ready (biu2dlm_icb_cmd_ready),
    .biu2dlm_icb_cmd_addr  (biu2dlm_icb_cmd_addr ), 
    .biu2dlm_icb_cmd_read  (biu2dlm_icb_cmd_read ), 
    .biu2dlm_icb_cmd_wdata (biu2dlm_icb_cmd_wdata),
    .biu2dlm_icb_cmd_wmask (biu2dlm_icb_cmd_wmask),
    
    .biu2dlm_icb_rsp_valid (biu2dlm_icb_rsp_valid),
    .biu2dlm_icb_rsp_ready (biu2dlm_icb_rsp_ready),
    .biu2dlm_icb_rsp_err   (biu2dlm_icb_rsp_err  ),
    .biu2dlm_icb_rsp_rdata (biu2dlm_icb_rsp_rdata),

     
  
  `ifdef N101_HAS_ILM 

  `ifdef N101_LM_ITF_TYPE_AHBL 
      
    .ilm_ahbl_htrans   (ilm_htrans),
    .ilm_ahbl_haddr    (ilm_haddr ),
    .ilm_ahbl_hsize    (ilm_hsize ),
    .ilm_ahbl_hwrite   (ilm_hwrite),    
    .ilm_ahbl_hwdata   (ilm_hwdata),    
    .ilm_ahbl_hrdata   (ilm_hrdata),
    .ilm_ahbl_hresp    (ilm_hresp ),
    .ilm_ahbl_hready   (ilm_hready),
  `endif
  
      `endif


  
  
  
     `ifdef N101_HAS_DLM 

  `ifdef N101_LM_ITF_TYPE_AHBL 
    .dlm_ahbl_htrans  (dlm_htrans),    
    .dlm_ahbl_haddr   (dlm_haddr ),    
    .dlm_ahbl_hsize   (dlm_hsize ),    
    .dlm_ahbl_hwrite  (dlm_hwrite),    
    .dlm_ahbl_hwdata  (dlm_hwdata),    
    .dlm_ahbl_hrdata  (dlm_hrdata),    
    .dlm_ahbl_hresp   (dlm_hresp ),    
    .dlm_ahbl_hready  (dlm_hready),    
  `endif
  
      `endif
     

    .test_mode     (test_mode),
    .clk           (clk_bus  ),
    .rst_n         (sys_rst_n) 
  );
 
  wire                       qspi0_ro_icb_cmd_valid;
  wire                       qspi0_ro_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0] qspi0_ro_icb_cmd_addr; 
  wire                       qspi0_ro_icb_cmd_read; 
  wire [32-1:0]              qspi0_ro_icb_cmd_wdata;
  
  wire                       qspi0_ro_icb_rsp_valid;
  wire                       qspi0_ro_icb_rsp_ready;
  wire [32-1:0]              qspi0_ro_icb_rsp_rdata;

  

     
  `ifdef N101_HAS_FIO 
  wire [`N101_ADDR_SIZE-1:0] fio_region_indic = `N101_CFG_FIO_BASE_ADDR;
  `endif
  `ifdef N101_HAS_PPI 
  wire [`N101_ADDR_SIZE-1:0] ppi_region_indic = `N101_CFG_PPI_BASE_ADDR;
  `endif
     

  n101_subsys_perips u_n101_subsys_perips (

     
  `ifdef N101_HAS_FIO 
    .fio_icb_cmd_valid     (fio_icb_cmd_valid),
    .fio_icb_cmd_addr      ({fio_region_indic[`N101_FIO_BASE_REGION],fio_icb_cmd_addr} ),
    .fio_icb_cmd_read      (fio_icb_cmd_read ),
    .fio_icb_cmd_wdata     (fio_icb_cmd_wdata),
    .fio_icb_cmd_wmask     (fio_icb_cmd_wmask),
     
    .fio_icb_rsp_err       (fio_icb_rsp_err  ),
    .fio_icb_rsp_rdata     (fio_icb_rsp_rdata),
  `endif
 
  `ifdef N101_HAS_PPI 
      `ifdef N101_PPI_TYPE_ICB 
    .ppi_icb_cmd_valid     (ppi_icb_cmd_valid),
    .ppi_icb_cmd_ready     (ppi_icb_cmd_ready),
    .ppi_icb_cmd_addr      (ppi_icb_cmd_addr ),
    .ppi_icb_cmd_read      (ppi_icb_cmd_read ),
    .ppi_icb_cmd_wdata     (ppi_icb_cmd_wdata),
    .ppi_icb_cmd_wmask     (ppi_icb_cmd_wmask),
    
    .ppi_icb_rsp_valid     (ppi_icb_rsp_valid),
    .ppi_icb_rsp_ready     (ppi_icb_rsp_ready),
    .ppi_icb_rsp_err       (ppi_icb_rsp_err  ),
    .ppi_icb_rsp_rdata     (ppi_icb_rsp_rdata),
      `endif

      `ifdef N101_PPI_TYPE_APB 
    .ppi_apb_paddr         ({ppi_region_indic[`N101_PPI_BASE_REGION],ppi_apb_paddr}  ),
    .ppi_apb_pwrite        (ppi_apb_pwrite ),
    .ppi_apb_psel          (ppi_apb_psel   ),
    .ppi_apb_penable       (ppi_apb_penable), 
    .ppi_apb_pwdata        (ppi_apb_pwdata ),
    .ppi_apb_prdata        (ppi_apb_prdata ),
    .ppi_apb_pready        (ppi_apb_pready ),
    .ppi_apb_pslverr       (ppi_apb_pslverr),
      `endif
  `endif

  `ifndef N101_HAS_PPI 
     
    .biu2ppi_icb_cmd_valid     (biu2ppi_icb_cmd_valid),
    .biu2ppi_icb_cmd_ready     (biu2ppi_icb_cmd_ready),
    .biu2ppi_icb_cmd_addr      (biu2ppi_icb_cmd_addr ),
    .biu2ppi_icb_cmd_read      (biu2ppi_icb_cmd_read ),
    .biu2ppi_icb_cmd_wdata     (biu2ppi_icb_cmd_wdata),
    .biu2ppi_icb_cmd_wmask     (biu2ppi_icb_cmd_wmask),
    
    .biu2ppi_icb_rsp_valid     (biu2ppi_icb_rsp_valid),
    .biu2ppi_icb_rsp_ready     (biu2ppi_icb_rsp_ready),
    .biu2ppi_icb_rsp_err       (biu2ppi_icb_rsp_err  ),
    .biu2ppi_icb_rsp_rdata     (biu2ppi_icb_rsp_rdata),
     
  `endif
     

    .qspi0_ro_icb_cmd_valid  (qspi0_ro_icb_cmd_valid), 
    .qspi0_ro_icb_cmd_ready  (qspi0_ro_icb_cmd_ready),
    .qspi0_ro_icb_cmd_addr   (qspi0_ro_icb_cmd_addr ),
    .qspi0_ro_icb_cmd_read   (qspi0_ro_icb_cmd_read ),
    .qspi0_ro_icb_cmd_wdata  (qspi0_ro_icb_cmd_wdata),
                             
    .qspi0_ro_icb_rsp_valid  (qspi0_ro_icb_rsp_valid),
    .qspi0_ro_icb_rsp_ready  (qspi0_ro_icb_rsp_ready),
    .qspi0_ro_icb_rsp_rdata  (qspi0_ro_icb_rsp_rdata),
                           
    .io_pads_gpio_0_i_ival   (io_pads_gpio_0_i_ival),
    .io_pads_gpio_0_o_oval   (io_pads_gpio_0_o_oval),
    .io_pads_gpio_0_o_oe     (io_pads_gpio_0_o_oe),
    .io_pads_gpio_0_o_ie     (io_pads_gpio_0_o_ie),
    .io_pads_gpio_0_o_pue    (io_pads_gpio_0_o_pue),
    .io_pads_gpio_0_o_ds     (io_pads_gpio_0_o_ds),
    .io_pads_gpio_1_i_ival   (io_pads_gpio_1_i_ival),
    .io_pads_gpio_1_o_oval   (io_pads_gpio_1_o_oval),
    .io_pads_gpio_1_o_oe     (io_pads_gpio_1_o_oe),
    .io_pads_gpio_1_o_ie     (io_pads_gpio_1_o_ie),
    .io_pads_gpio_1_o_pue    (io_pads_gpio_1_o_pue),
    .io_pads_gpio_1_o_ds     (io_pads_gpio_1_o_ds),
    .io_pads_gpio_2_i_ival   (io_pads_gpio_2_i_ival),
    .io_pads_gpio_2_o_oval   (io_pads_gpio_2_o_oval),
    .io_pads_gpio_2_o_oe     (io_pads_gpio_2_o_oe),
    .io_pads_gpio_2_o_ie     (io_pads_gpio_2_o_ie),
    .io_pads_gpio_2_o_pue    (io_pads_gpio_2_o_pue),
    .io_pads_gpio_2_o_ds     (io_pads_gpio_2_o_ds),
    .io_pads_gpio_3_i_ival   (io_pads_gpio_3_i_ival),
    .io_pads_gpio_3_o_oval   (io_pads_gpio_3_o_oval),
    .io_pads_gpio_3_o_oe     (io_pads_gpio_3_o_oe),
    .io_pads_gpio_3_o_ie     (io_pads_gpio_3_o_ie),
    .io_pads_gpio_3_o_pue    (io_pads_gpio_3_o_pue),
    .io_pads_gpio_3_o_ds     (io_pads_gpio_3_o_ds),
    .io_pads_gpio_4_i_ival   (io_pads_gpio_4_i_ival),
    .io_pads_gpio_4_o_oval   (io_pads_gpio_4_o_oval),
    .io_pads_gpio_4_o_oe     (io_pads_gpio_4_o_oe),
    .io_pads_gpio_4_o_ie     (io_pads_gpio_4_o_ie),
    .io_pads_gpio_4_o_pue    (io_pads_gpio_4_o_pue),
    .io_pads_gpio_4_o_ds     (io_pads_gpio_4_o_ds),
    .io_pads_gpio_5_i_ival   (io_pads_gpio_5_i_ival),
    .io_pads_gpio_5_o_oval   (io_pads_gpio_5_o_oval),
    .io_pads_gpio_5_o_oe     (io_pads_gpio_5_o_oe),
    .io_pads_gpio_5_o_ie     (io_pads_gpio_5_o_ie),
    .io_pads_gpio_5_o_pue    (io_pads_gpio_5_o_pue),
    .io_pads_gpio_5_o_ds     (io_pads_gpio_5_o_ds),
    .io_pads_gpio_6_i_ival   (io_pads_gpio_6_i_ival),
    .io_pads_gpio_6_o_oval   (io_pads_gpio_6_o_oval),
    .io_pads_gpio_6_o_oe     (io_pads_gpio_6_o_oe),
    .io_pads_gpio_6_o_ie     (io_pads_gpio_6_o_ie),
    .io_pads_gpio_6_o_pue    (io_pads_gpio_6_o_pue),
    .io_pads_gpio_6_o_ds     (io_pads_gpio_6_o_ds),
    .io_pads_gpio_7_i_ival   (io_pads_gpio_7_i_ival),
    .io_pads_gpio_7_o_oval   (io_pads_gpio_7_o_oval),
    .io_pads_gpio_7_o_oe     (io_pads_gpio_7_o_oe),
    .io_pads_gpio_7_o_ie     (io_pads_gpio_7_o_ie),
    .io_pads_gpio_7_o_pue    (io_pads_gpio_7_o_pue),
    .io_pads_gpio_7_o_ds     (io_pads_gpio_7_o_ds),
    .io_pads_gpio_8_i_ival   (io_pads_gpio_8_i_ival),
    .io_pads_gpio_8_o_oval   (io_pads_gpio_8_o_oval),
    .io_pads_gpio_8_o_oe     (io_pads_gpio_8_o_oe),
    .io_pads_gpio_8_o_ie     (io_pads_gpio_8_o_ie),
    .io_pads_gpio_8_o_pue    (io_pads_gpio_8_o_pue),
    .io_pads_gpio_8_o_ds     (io_pads_gpio_8_o_ds),
    .io_pads_gpio_9_i_ival   (io_pads_gpio_9_i_ival),
    .io_pads_gpio_9_o_oval   (io_pads_gpio_9_o_oval),
    .io_pads_gpio_9_o_oe     (io_pads_gpio_9_o_oe),
    .io_pads_gpio_9_o_ie     (io_pads_gpio_9_o_ie),
    .io_pads_gpio_9_o_pue    (io_pads_gpio_9_o_pue),
    .io_pads_gpio_9_o_ds     (io_pads_gpio_9_o_ds),
    .io_pads_gpio_10_i_ival  (io_pads_gpio_10_i_ival),
    .io_pads_gpio_10_o_oval  (io_pads_gpio_10_o_oval),
    .io_pads_gpio_10_o_oe    (io_pads_gpio_10_o_oe),
    .io_pads_gpio_10_o_ie    (io_pads_gpio_10_o_ie),
    .io_pads_gpio_10_o_pue   (io_pads_gpio_10_o_pue),
    .io_pads_gpio_10_o_ds    (io_pads_gpio_10_o_ds),
    .io_pads_gpio_11_i_ival  (io_pads_gpio_11_i_ival),
    .io_pads_gpio_11_o_oval  (io_pads_gpio_11_o_oval),
    .io_pads_gpio_11_o_oe    (io_pads_gpio_11_o_oe),
    .io_pads_gpio_11_o_ie    (io_pads_gpio_11_o_ie),
    .io_pads_gpio_11_o_pue   (io_pads_gpio_11_o_pue),
    .io_pads_gpio_11_o_ds    (io_pads_gpio_11_o_ds),
    .io_pads_gpio_12_i_ival  (io_pads_gpio_12_i_ival),
    .io_pads_gpio_12_o_oval  (io_pads_gpio_12_o_oval),
    .io_pads_gpio_12_o_oe    (io_pads_gpio_12_o_oe),
    .io_pads_gpio_12_o_ie    (io_pads_gpio_12_o_ie),
    .io_pads_gpio_12_o_pue   (io_pads_gpio_12_o_pue),
    .io_pads_gpio_12_o_ds    (io_pads_gpio_12_o_ds),
    .io_pads_gpio_13_i_ival  (io_pads_gpio_13_i_ival),
    .io_pads_gpio_13_o_oval  (io_pads_gpio_13_o_oval),
    .io_pads_gpio_13_o_oe    (io_pads_gpio_13_o_oe),
    .io_pads_gpio_13_o_ie    (io_pads_gpio_13_o_ie),
    .io_pads_gpio_13_o_pue   (io_pads_gpio_13_o_pue),
    .io_pads_gpio_13_o_ds    (io_pads_gpio_13_o_ds),
    .io_pads_gpio_14_i_ival  (io_pads_gpio_14_i_ival),
    .io_pads_gpio_14_o_oval  (io_pads_gpio_14_o_oval),
    .io_pads_gpio_14_o_oe    (io_pads_gpio_14_o_oe),
    .io_pads_gpio_14_o_ie    (io_pads_gpio_14_o_ie),
    .io_pads_gpio_14_o_pue   (io_pads_gpio_14_o_pue),
    .io_pads_gpio_14_o_ds    (io_pads_gpio_14_o_ds),
    .io_pads_gpio_15_i_ival  (io_pads_gpio_15_i_ival),
    .io_pads_gpio_15_o_oval  (io_pads_gpio_15_o_oval),
    .io_pads_gpio_15_o_oe    (io_pads_gpio_15_o_oe),
    .io_pads_gpio_15_o_ie    (io_pads_gpio_15_o_ie),
    .io_pads_gpio_15_o_pue   (io_pads_gpio_15_o_pue),
    .io_pads_gpio_15_o_ds    (io_pads_gpio_15_o_ds),
    .io_pads_gpio_16_i_ival  (io_pads_gpio_16_i_ival),
    .io_pads_gpio_16_o_oval  (io_pads_gpio_16_o_oval),
    .io_pads_gpio_16_o_oe    (io_pads_gpio_16_o_oe),
    .io_pads_gpio_16_o_ie    (io_pads_gpio_16_o_ie),
    .io_pads_gpio_16_o_pue   (io_pads_gpio_16_o_pue),
    .io_pads_gpio_16_o_ds    (io_pads_gpio_16_o_ds),
    .io_pads_gpio_17_i_ival  (io_pads_gpio_17_i_ival),
    .io_pads_gpio_17_o_oval  (io_pads_gpio_17_o_oval),
    .io_pads_gpio_17_o_oe    (io_pads_gpio_17_o_oe),
    .io_pads_gpio_17_o_ie    (io_pads_gpio_17_o_ie),
    .io_pads_gpio_17_o_pue   (io_pads_gpio_17_o_pue),
    .io_pads_gpio_17_o_ds    (io_pads_gpio_17_o_ds),
    .io_pads_gpio_18_i_ival  (io_pads_gpio_18_i_ival),
    .io_pads_gpio_18_o_oval  (io_pads_gpio_18_o_oval),
    .io_pads_gpio_18_o_oe    (io_pads_gpio_18_o_oe),
    .io_pads_gpio_18_o_ie    (io_pads_gpio_18_o_ie),
    .io_pads_gpio_18_o_pue   (io_pads_gpio_18_o_pue),
    .io_pads_gpio_18_o_ds    (io_pads_gpio_18_o_ds),
    .io_pads_gpio_19_i_ival  (io_pads_gpio_19_i_ival),
    .io_pads_gpio_19_o_oval  (io_pads_gpio_19_o_oval),
    .io_pads_gpio_19_o_oe    (io_pads_gpio_19_o_oe),
    .io_pads_gpio_19_o_ie    (io_pads_gpio_19_o_ie),
    .io_pads_gpio_19_o_pue   (io_pads_gpio_19_o_pue),
    .io_pads_gpio_19_o_ds    (io_pads_gpio_19_o_ds),
    .io_pads_gpio_20_i_ival  (io_pads_gpio_20_i_ival),
    .io_pads_gpio_20_o_oval  (io_pads_gpio_20_o_oval),
    .io_pads_gpio_20_o_oe    (io_pads_gpio_20_o_oe),
    .io_pads_gpio_20_o_ie    (io_pads_gpio_20_o_ie),
    .io_pads_gpio_20_o_pue   (io_pads_gpio_20_o_pue),
    .io_pads_gpio_20_o_ds    (io_pads_gpio_20_o_ds),
    .io_pads_gpio_21_i_ival  (io_pads_gpio_21_i_ival),
    .io_pads_gpio_21_o_oval  (io_pads_gpio_21_o_oval),
    .io_pads_gpio_21_o_oe    (io_pads_gpio_21_o_oe),
    .io_pads_gpio_21_o_ie    (io_pads_gpio_21_o_ie),
    .io_pads_gpio_21_o_pue   (io_pads_gpio_21_o_pue),
    .io_pads_gpio_21_o_ds    (io_pads_gpio_21_o_ds),
    .io_pads_gpio_22_i_ival  (io_pads_gpio_22_i_ival),
    .io_pads_gpio_22_o_oval  (io_pads_gpio_22_o_oval),
    .io_pads_gpio_22_o_oe    (io_pads_gpio_22_o_oe),
    .io_pads_gpio_22_o_ie    (io_pads_gpio_22_o_ie),
    .io_pads_gpio_22_o_pue   (io_pads_gpio_22_o_pue),
    .io_pads_gpio_22_o_ds    (io_pads_gpio_22_o_ds),
    .io_pads_gpio_23_i_ival  (io_pads_gpio_23_i_ival),
    .io_pads_gpio_23_o_oval  (io_pads_gpio_23_o_oval),
    .io_pads_gpio_23_o_oe    (io_pads_gpio_23_o_oe),
    .io_pads_gpio_23_o_ie    (io_pads_gpio_23_o_ie),
    .io_pads_gpio_23_o_pue   (io_pads_gpio_23_o_pue),
    .io_pads_gpio_23_o_ds    (io_pads_gpio_23_o_ds),
    .io_pads_gpio_24_i_ival  (io_pads_gpio_24_i_ival),
    .io_pads_gpio_24_o_oval  (io_pads_gpio_24_o_oval),
    .io_pads_gpio_24_o_oe    (io_pads_gpio_24_o_oe),
    .io_pads_gpio_24_o_ie    (io_pads_gpio_24_o_ie),
    .io_pads_gpio_24_o_pue   (io_pads_gpio_24_o_pue),
    .io_pads_gpio_24_o_ds    (io_pads_gpio_24_o_ds),
    .io_pads_gpio_25_i_ival  (io_pads_gpio_25_i_ival),
    .io_pads_gpio_25_o_oval  (io_pads_gpio_25_o_oval),
    .io_pads_gpio_25_o_oe    (io_pads_gpio_25_o_oe),
    .io_pads_gpio_25_o_ie    (io_pads_gpio_25_o_ie),
    .io_pads_gpio_25_o_pue   (io_pads_gpio_25_o_pue),
    .io_pads_gpio_25_o_ds    (io_pads_gpio_25_o_ds),
    .io_pads_gpio_26_i_ival  (io_pads_gpio_26_i_ival),
    .io_pads_gpio_26_o_oval  (io_pads_gpio_26_o_oval),
    .io_pads_gpio_26_o_oe    (io_pads_gpio_26_o_oe),
    .io_pads_gpio_26_o_ie    (io_pads_gpio_26_o_ie),
    .io_pads_gpio_26_o_pue   (io_pads_gpio_26_o_pue),
    .io_pads_gpio_26_o_ds    (io_pads_gpio_26_o_ds),
    .io_pads_gpio_27_i_ival  (io_pads_gpio_27_i_ival),
    .io_pads_gpio_27_o_oval  (io_pads_gpio_27_o_oval),
    .io_pads_gpio_27_o_oe    (io_pads_gpio_27_o_oe),
    .io_pads_gpio_27_o_ie    (io_pads_gpio_27_o_ie),
    .io_pads_gpio_27_o_pue   (io_pads_gpio_27_o_pue),
    .io_pads_gpio_27_o_ds    (io_pads_gpio_27_o_ds),
    .io_pads_gpio_28_i_ival  (io_pads_gpio_28_i_ival),
    .io_pads_gpio_28_o_oval  (io_pads_gpio_28_o_oval),
    .io_pads_gpio_28_o_oe    (io_pads_gpio_28_o_oe),
    .io_pads_gpio_28_o_ie    (io_pads_gpio_28_o_ie),
    .io_pads_gpio_28_o_pue   (io_pads_gpio_28_o_pue),
    .io_pads_gpio_28_o_ds    (io_pads_gpio_28_o_ds),
    .io_pads_gpio_29_i_ival  (io_pads_gpio_29_i_ival),
    .io_pads_gpio_29_o_oval  (io_pads_gpio_29_o_oval),
    .io_pads_gpio_29_o_oe    (io_pads_gpio_29_o_oe),
    .io_pads_gpio_29_o_ie    (io_pads_gpio_29_o_ie),
    .io_pads_gpio_29_o_pue   (io_pads_gpio_29_o_pue),
    .io_pads_gpio_29_o_ds    (io_pads_gpio_29_o_ds),
    .io_pads_gpio_30_i_ival  (io_pads_gpio_30_i_ival),
    .io_pads_gpio_30_o_oval  (io_pads_gpio_30_o_oval),
    .io_pads_gpio_30_o_oe    (io_pads_gpio_30_o_oe),
    .io_pads_gpio_30_o_ie    (io_pads_gpio_30_o_ie),
    .io_pads_gpio_30_o_pue   (io_pads_gpio_30_o_pue),
    .io_pads_gpio_30_o_ds    (io_pads_gpio_30_o_ds),
    .io_pads_gpio_31_i_ival  (io_pads_gpio_31_i_ival),
    .io_pads_gpio_31_o_oval  (io_pads_gpio_31_o_oval),
    .io_pads_gpio_31_o_oe    (io_pads_gpio_31_o_oe),
    .io_pads_gpio_31_o_ie    (io_pads_gpio_31_o_ie),
    .io_pads_gpio_31_o_pue   (io_pads_gpio_31_o_pue),
    .io_pads_gpio_31_o_ds    (io_pads_gpio_31_o_ds),

    .io_pads_qspi_sck_i_ival (io_pads_qspi_sck_i_ival    ),
    .io_pads_qspi_sck_o_oval (io_pads_qspi_sck_o_oval    ),
    .io_pads_qspi_sck_o_oe   (io_pads_qspi_sck_o_oe      ),
    .io_pads_qspi_sck_o_ie   (io_pads_qspi_sck_o_ie      ),
    .io_pads_qspi_sck_o_pue  (io_pads_qspi_sck_o_pue     ),
    .io_pads_qspi_sck_o_ds   (io_pads_qspi_sck_o_ds      ),
    .io_pads_qspi_dq_0_i_ival(io_pads_qspi_dq_0_i_ival   ),
    .io_pads_qspi_dq_0_o_oval(io_pads_qspi_dq_0_o_oval   ),
    .io_pads_qspi_dq_0_o_oe  (io_pads_qspi_dq_0_o_oe     ),
    .io_pads_qspi_dq_0_o_ie  (io_pads_qspi_dq_0_o_ie     ),
    .io_pads_qspi_dq_0_o_pue (io_pads_qspi_dq_0_o_pue    ),
    .io_pads_qspi_dq_0_o_ds  (io_pads_qspi_dq_0_o_ds     ),
    .io_pads_qspi_dq_1_i_ival(io_pads_qspi_dq_1_i_ival   ),
    .io_pads_qspi_dq_1_o_oval(io_pads_qspi_dq_1_o_oval   ),
    .io_pads_qspi_dq_1_o_oe  (io_pads_qspi_dq_1_o_oe     ),
    .io_pads_qspi_dq_1_o_ie  (io_pads_qspi_dq_1_o_ie     ),
    .io_pads_qspi_dq_1_o_pue (io_pads_qspi_dq_1_o_pue    ),
    .io_pads_qspi_dq_1_o_ds  (io_pads_qspi_dq_1_o_ds     ),
    .io_pads_qspi_dq_2_i_ival(io_pads_qspi_dq_2_i_ival   ),
    .io_pads_qspi_dq_2_o_oval(io_pads_qspi_dq_2_o_oval   ),
    .io_pads_qspi_dq_2_o_oe  (io_pads_qspi_dq_2_o_oe     ),
    .io_pads_qspi_dq_2_o_ie  (io_pads_qspi_dq_2_o_ie     ),
    .io_pads_qspi_dq_2_o_pue (io_pads_qspi_dq_2_o_pue    ),
    .io_pads_qspi_dq_2_o_ds  (io_pads_qspi_dq_2_o_ds     ),
    .io_pads_qspi_dq_3_i_ival(io_pads_qspi_dq_3_i_ival   ),
    .io_pads_qspi_dq_3_o_oval(io_pads_qspi_dq_3_o_oval   ),
    .io_pads_qspi_dq_3_o_oe  (io_pads_qspi_dq_3_o_oe     ),
    .io_pads_qspi_dq_3_o_ie  (io_pads_qspi_dq_3_o_ie     ),
    .io_pads_qspi_dq_3_o_pue (io_pads_qspi_dq_3_o_pue    ),
    .io_pads_qspi_dq_3_o_ds  (io_pads_qspi_dq_3_o_ds     ),
    .io_pads_qspi_cs_0_i_ival(io_pads_qspi_cs_0_i_ival   ),
    .io_pads_qspi_cs_0_o_oval(io_pads_qspi_cs_0_o_oval   ),
    .io_pads_qspi_cs_0_o_oe  (io_pads_qspi_cs_0_o_oe     ),
    .io_pads_qspi_cs_0_o_ie  (io_pads_qspi_cs_0_o_ie     ),
    .io_pads_qspi_cs_0_o_pue (io_pads_qspi_cs_0_o_pue    ),
    .io_pads_qspi_cs_0_o_ds  (io_pads_qspi_cs_0_o_ds     ),

    .qspi0_irq            (qspi0_irq  ),
    .qspi1_irq            (qspi1_irq  ),
    .qspi2_irq            (qspi2_irq  ),
    .uart0_irq            (uart0_irq  ),
    .uart1_irq            (uart1_irq  ),
    .pwm0_irq_0           (pwm0_irq_0 ),
    .pwm0_irq_1           (pwm0_irq_1 ),
    .pwm0_irq_2           (pwm0_irq_2 ),
    .pwm0_irq_3           (pwm0_irq_3 ),
    .pwm1_irq_0           (pwm1_irq_0 ),
    .pwm1_irq_1           (pwm1_irq_1 ),
    .pwm1_irq_2           (pwm1_irq_2 ),
    .pwm1_irq_3           (pwm1_irq_3 ),
    .pwm2_irq_0           (pwm2_irq_0 ),
    .pwm2_irq_1           (pwm2_irq_1 ),
    .pwm2_irq_2           (pwm2_irq_2 ),
    .pwm2_irq_3           (pwm2_irq_3 ),
    .i2c_mst_irq          (i2c_mst_irq),
    .gpio_irq_0           (gpio_irq_0 ),
    .gpio_irq_1           (gpio_irq_1 ),
    .gpio_irq_2           (gpio_irq_2 ),
    .gpio_irq_3           (gpio_irq_3 ),
    .gpio_irq_4           (gpio_irq_4 ),
    .gpio_irq_5           (gpio_irq_5 ),
    .gpio_irq_6           (gpio_irq_6 ),
    .gpio_irq_7           (gpio_irq_7 ),
    .gpio_irq_8           (gpio_irq_8 ),
    .gpio_irq_9           (gpio_irq_9 ),
    .gpio_irq_10          (gpio_irq_10),
    .gpio_irq_11          (gpio_irq_11),
    .gpio_irq_12            (gpio_irq_12),
    .gpio_irq_13            (gpio_irq_13),
    .gpio_irq_14            (gpio_irq_14),
    .gpio_irq_15            (gpio_irq_15),
    .gpio_irq_16            (gpio_irq_16),
    .gpio_irq_17            (gpio_irq_17),
    .gpio_irq_18            (gpio_irq_18),
    .gpio_irq_19            (gpio_irq_19),
    .gpio_irq_20            (gpio_irq_20),
    .gpio_irq_21            (gpio_irq_21),
    .gpio_irq_22            (gpio_irq_22),
    .gpio_irq_23            (gpio_irq_23),
    .gpio_irq_24            (gpio_irq_24),
    .gpio_irq_25            (gpio_irq_25),
    .gpio_irq_26            (gpio_irq_26),
    .gpio_irq_27            (gpio_irq_27),
    .gpio_irq_28            (gpio_irq_28),
    .gpio_irq_29            (gpio_irq_29),
    .gpio_irq_30            (gpio_irq_30),
    .gpio_irq_31            (gpio_irq_31),

    .clk                    (clk_bus  ),
    .bus_rst_n              (sys_rst_n), 
    .rst_n                  (sys_rst_n) 
  );

  n101_subsys_mems u_n101_subsys_mems(
     
    `ifndef N101_TMR_PRIVATE 
    .mtip          (mtip          ),
    .msip          (msip),
    .mtime_toggle_a(mtime_toggle_a ),
    `endif

      `ifdef N101_MEM_TYPE_ICB 
    .mem_icb_cmd_valid  (mem_icb_cmd_valid),
    .mem_icb_cmd_ready  (mem_icb_cmd_ready),
    .mem_icb_cmd_addr   (mem_icb_cmd_addr ),
    .mem_icb_cmd_read   (mem_icb_cmd_read ),
    .mem_icb_cmd_excl   (1'b0             ),
    .mem_icb_cmd_wdata  (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask  (mem_icb_cmd_wmask),
    .mem_icb_cmd_hlock  (1'b0),
    
    .mem_icb_rsp_valid  (mem_icb_rsp_valid),
    .mem_icb_rsp_ready  (mem_icb_rsp_ready),
    .mem_icb_rsp_err    (mem_icb_rsp_err  ),
    .mem_icb_rsp_excl_ok(                 ),
    .mem_icb_rsp_rdata  (mem_icb_rsp_rdata),
      `endif

      `ifndef N101_D_SHARE_ILM 
     
    .biu2ilm_icb_cmd_valid (biu2ilm_icb_cmd_valid),
    .biu2ilm_icb_cmd_ready (biu2ilm_icb_cmd_ready),
    .biu2ilm_icb_cmd_addr  (biu2ilm_icb_cmd_addr ), 
    .biu2ilm_icb_cmd_read  (biu2ilm_icb_cmd_read ), 
    .biu2ilm_icb_cmd_wdata (biu2ilm_icb_cmd_wdata),
    .biu2ilm_icb_cmd_wmask (biu2ilm_icb_cmd_wmask),
    
    .biu2ilm_icb_rsp_valid (biu2ilm_icb_rsp_valid),
    .biu2ilm_icb_rsp_ready (biu2ilm_icb_rsp_ready),
    .biu2ilm_icb_rsp_err   (biu2ilm_icb_rsp_err  ),
    .biu2ilm_icb_rsp_rdata (biu2ilm_icb_rsp_rdata),
     
      `endif
     

    .biu2dlm_icb_cmd_valid (biu2dlm_icb_cmd_valid),
    .biu2dlm_icb_cmd_ready (biu2dlm_icb_cmd_ready),
    .biu2dlm_icb_cmd_addr  (biu2dlm_icb_cmd_addr ), 
    .biu2dlm_icb_cmd_read  (biu2dlm_icb_cmd_read ), 
    .biu2dlm_icb_cmd_wdata (biu2dlm_icb_cmd_wdata),
    .biu2dlm_icb_cmd_wmask (biu2dlm_icb_cmd_wmask),
    
    .biu2dlm_icb_rsp_valid (biu2dlm_icb_rsp_valid),
    .biu2dlm_icb_rsp_ready (biu2dlm_icb_rsp_ready),
    .biu2dlm_icb_rsp_err   (biu2dlm_icb_rsp_err  ),
    .biu2dlm_icb_rsp_rdata (biu2dlm_icb_rsp_rdata),


     
      `ifdef N101_MEM_TYPE_AHBL 
     
    .mem_ahbl_htrans    (mem_ahbl_htrans),   
    .mem_ahbl_hwrite    (mem_ahbl_hwrite),   
    .mem_ahbl_haddr     (mem_ahbl_haddr ),   
    .mem_ahbl_hsize     (mem_ahbl_hsize[1:0]),   
    .mem_ahbl_hlock     (mem_ahbl_hlock ),  
    .mem_ahbl_hexcl     (1'b0 ),  
    .mem_ahbl_hburst    (mem_ahbl_hburst),   
    .mem_ahbl_hwdata    (mem_ahbl_hwdata),   
    .mem_ahbl_hrdata    (mem_ahbl_hrdata),   
    .mem_ahbl_hresp     (mem_ahbl_hresp ),   
    .mem_ahbl_hresp_exok(),   
    .mem_ahbl_hready    (mem_ahbl_hready),   
     
      `endif
     
 

    .qspi0_ro_icb_cmd_valid  (qspi0_ro_icb_cmd_valid), 
    .qspi0_ro_icb_cmd_ready  (qspi0_ro_icb_cmd_ready),
    .qspi0_ro_icb_cmd_addr   (qspi0_ro_icb_cmd_addr ),
    .qspi0_ro_icb_cmd_read   (qspi0_ro_icb_cmd_read ),
    .qspi0_ro_icb_cmd_wdata  (qspi0_ro_icb_cmd_wdata),
                             
    .qspi0_ro_icb_rsp_valid  (qspi0_ro_icb_rsp_valid),
    .qspi0_ro_icb_rsp_ready  (qspi0_ro_icb_rsp_ready),
    .qspi0_ro_icb_rsp_err    (1'b0  ),
    .qspi0_ro_icb_rsp_rdata  (qspi0_ro_icb_rsp_rdata),
                           
     
  `ifndef N101_HAS_PPI 
     
    .biu2ppi_icb_cmd_valid     (biu2ppi_icb_cmd_valid),
    .biu2ppi_icb_cmd_ready     (biu2ppi_icb_cmd_ready),
    .biu2ppi_icb_cmd_addr      (biu2ppi_icb_cmd_addr ),
    .biu2ppi_icb_cmd_read      (biu2ppi_icb_cmd_read ),
    .biu2ppi_icb_cmd_wdata     (biu2ppi_icb_cmd_wdata),
    .biu2ppi_icb_cmd_wmask     (biu2ppi_icb_cmd_wmask),
    
    .biu2ppi_icb_rsp_valid     (biu2ppi_icb_rsp_valid),
    .biu2ppi_icb_rsp_ready     (biu2ppi_icb_rsp_ready),
    .biu2ppi_icb_rsp_err       (biu2ppi_icb_rsp_err  ),
    .biu2ppi_icb_rsp_rdata     (biu2ppi_icb_rsp_rdata),
     
  `endif
     

    .clk           (clk_bus  ),
    .bus_rst_n     (sys_rst_n), 
    .rst_n         (sys_rst_n) 
  );


     
 n101_subsys_srams u_n101_subsys_srams(

  `ifdef N101_HAS_ICACHE 
    .rst_icache_ram       (sys_rst_n),

    .icache_tag0_cs       (icache_tag0_cs   ),
    .icache_tag0_we       (icache_tag0_we   ),
    .icache_tag0_addr     (icache_tag0_addr ),
    .icache_tag0_wdata    (icache_tag0_wdata),        
    .icache_tag0_rdata     (icache_tag0_rdata ),
    .clk_icache_tag0      (clk_icache_tag0  ),
                                                
    .icache_data0_cs       (icache_data0_cs   ),
    .icache_data0_we       (icache_data0_we   ),
    .icache_data0_addr     (icache_data0_addr ),
    .icache_data0_wdata    (icache_data0_wdata),        
    .icache_data0_rdata     (icache_data0_rdata ),
    .clk_icache_data0      (clk_icache_data0  ),
                                                
    `ifdef N101_ICACHE_2WAYS
    .icache_tag1_cs       (icache_tag1_cs   ),
    .icache_tag1_we       (icache_tag1_we   ),
    .icache_tag1_addr     (icache_tag1_addr ),
    .icache_tag1_wdata    (icache_tag1_wdata),        
    .icache_tag1_rdata     (icache_tag1_rdata ),
    .clk_icache_tag1      (clk_icache_tag1  ),

    .icache_data1_cs       (icache_data1_cs   ),
    .icache_data1_we       (icache_data1_we   ),
    .icache_data1_addr     (icache_data1_addr ),
    .icache_data1_wdata    (icache_data1_wdata),        
    .icache_data1_rdata     (icache_data1_rdata ),
    .clk_icache_data1      (clk_icache_data1  ),
    `endif
  `endif

    .dummy(1'b0)
  );
     

     
  `ifdef N101_HAS_NICE 
    `ifndef N101_NICE_UVC
n101_subsys_nice_core  u_n101_subsys_nice_core(
    .nice_clk             (nice_clk            ),
    .nice_rst_n           (sys_rst_n          ),
    .nice_active          (nice_active         ),
    .nice_mem_holdup      (nice_mem_holdup     ),

    .nice_req_valid       (nice_req_valid      ),
    .nice_req_ready       (nice_req_ready      ),
    .nice_req_inst        (nice_req_inst       ),
    .nice_req_rs1         (nice_req_rs1        ),
    .nice_req_rs2         (nice_req_rs2        ),
    .nice_req_mmode       (nice_req_mmode      ),
    .nice_1cyc_type       (nice_1cyc_type      ),
    .nice_1cyc_rdat       (nice_1cyc_rdat      ),	
    .nice_1cyc_err        (nice_1cyc_err       ),	
    .nice_rsp_valid       (nice_rsp_valid      ),
    .nice_rsp_ready       (nice_rsp_ready      ),
    .nice_rsp_rdat        (nice_rsp_rdat       ),
    .nice_rsp_err         (nice_rsp_err        ),
    .nice_icb_cmd_valid   (nice_icb_cmd_valid  ),
    .nice_icb_cmd_ready   (nice_icb_cmd_ready  ),
    .nice_icb_cmd_addr    (nice_icb_cmd_addr   ),
    .nice_icb_cmd_read    (nice_icb_cmd_read   ),
    .nice_icb_cmd_wdata   (nice_icb_cmd_wdata  ),
    .nice_icb_cmd_size    (nice_icb_cmd_size   ),
    .nice_icb_cmd_mmode   (nice_icb_cmd_mmode  ),
    .nice_icb_rsp_valid   (nice_icb_rsp_valid  ),
    .nice_icb_rsp_ready   (nice_icb_rsp_ready  ),
    .nice_icb_rsp_rdata   (nice_icb_rsp_rdata  ),
    .nice_icb_rsp_err	  (nice_icb_rsp_err	   )
);
    `endif
  `endif
     




endmodule
