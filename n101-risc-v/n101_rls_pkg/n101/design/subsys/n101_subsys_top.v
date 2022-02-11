 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















`include "n101_defines.v"

module n101_subsys_top(
  
  input  por_rst_n,

  
  input  sys_rst_n,
        
  
  input  sys_clk,
      
  
  input  aon_clk,
      

  input  evt_i,
  input  nmi_i,

  output core_wfi_mode,
  output core_sleep_value,


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

  input  jtag_tdi,
  output jtag_tdo,
  input  jtag_tms,
  input  jtag_tck,
  output jtag_tdo_drv,

  output jtag_TMS_out,
  output jtag_DRV_TMS,
  
  output jtag_BK_TMS          ,
  output tap_rst_n   ,


  output  dmactive,
  output  dmactive_flag,

  input   test_mode 
  );

`ifdef N101_HAS_LOCKSTEP
  wire lockstep_mis;
  wire lockstep_mis_d1;
  wire lockstep_mis_d2;
`endif
  wire sysrstreq;
  
`ifdef N101_HAS_LOCKSTEP
  n101_gnrl_dffr #(1)  lockstep_mis_d1_dffr (lockstep_mis,    lockstep_mis_d1, sys_clk, por_rst_n);
  n101_gnrl_dfflr #(1) lockstep_mis_d2_dfflr(lockstep_mis_d1, 1'b1, lockstep_mis_d2, sys_clk, por_rst_n);   
`endif
  
      
  wire byp_sys_rst_n = test_mode ? 1'b1 : sys_rst_n;
  
      
      
      
`ifndef N101_HAS_LOCKSTEP
  wire final_sys_rst_n_a = (por_rst_n & byp_sys_rst_n & (~sysrstreq));
`endif
`ifdef N101_HAS_LOCKSTEP
  wire final_sys_rst_n_a = (por_rst_n & byp_sys_rst_n & (~sysrstreq) & (~lockstep_mis_d2));
`endif
  wire final_sys_rst_n;
  
  n101_reset_sync u_n101_reset_sync(
    .clk      (sys_clk),
    .rst_n_a  (final_sys_rst_n_a),
    .reset_bypass(test_mode),
    .rst_n_sync(final_sys_rst_n)   
  );
    




  
  wire mtime_toggle_a;
  wire mtime_toggle_nxt = ~mtime_toggle_a;
  n101_gnrl_dffr #(1) mtime_toggle_dffr (mtime_toggle_nxt, mtime_toggle_a, aon_clk, por_rst_n);


  wire  [`N101_PC_SIZE-1:0] reset_vector =
          
     
          `ifdef N101_ADDR_SIZE_IS_32
     
                         `ifdef FPGA_SOURCE
                                     `N101_ADDR_SIZE'h2000_0000;
                         `else
                                     `N101_ADDR_SIZE'h0000_1000;
                         `endif
     
          `endif
          `ifdef N101_ADDR_SIZE_IS_24
                         `ifdef FPGA_SOURCE
                                     `N101_ADDR_SIZE'h2000_00;
                         `else
                                     `N101_ADDR_SIZE'h0010_00;
                         `endif
          `endif
          `ifdef N101_ADDR_SIZE_IS_20
                         `ifdef FPGA_SOURCE
                                     `N101_ADDR_SIZE'h2000_0;
                         `else
                                     `N101_ADDR_SIZE'h010_00;
                         `endif
          `endif   
          `ifdef N101_ADDR_SIZE_IS_18
                         `ifdef FPGA_SOURCE
                                     `N101_ADDR_SIZE'h200_0;
                         `else
                                     `N101_ADDR_SIZE'h10_00;
                         `endif
          `endif   
          `ifdef N101_ADDR_SIZE_IS_16
                         `ifdef FPGA_SOURCE
                                     `N101_ADDR_SIZE'h200_0;
                         `else
                                     `N101_ADDR_SIZE'h10_00;
                         `endif
          `endif   
     

  
  wire mtime_toggle;
  wire trng_sync = mtime_toggle;

  n101_gnrl_sync # (
  .DP(`N101_ASYNC_FF_LEVELS),
  .DW(1)
  ) u_mtime_toggle_sync(
      .din_a    (mtime_toggle_a  ),
      .dout     (mtime_toggle    ),
      .clk      (sys_clk         ),
      .rst_n    (final_sys_rst_n ) 
  );

  
  wire evt_sync;

  n101_gnrl_sync # (
  .DP(`N101_ASYNC_FF_LEVELS),
  .DW(1)
  ) u_evt_sync(
      .din_a    (evt_i           ),
      .dout     (evt_sync        ),
      .clk      (sys_clk         ),
      .rst_n    (final_sys_rst_n ) 
  );

  
  wire nmi_sync;

  n101_gnrl_sync # (
  .DP(`N101_ASYNC_FF_LEVELS),
  .DW(1)
  ) u_nmi_sync(
      .din_a    (nmi_i           ),
      .dout     (nmi_sync        ),
      .clk      (sys_clk         ),
      .rst_n    (final_sys_rst_n ) 
  );


  n101_subsys_main  u_n101_subsys_main(
    .reset_vector        (reset_vector),

    .por_rst_n           (por_rst_n),
    .sys_rst_n           (final_sys_rst_n),
    .sys_clk             (sys_clk),

    .evt_i               (evt_sync),
    .nmi_i               (nmi_sync),

  `ifdef N101_HAS_SCP 
     .trng_i             (trng_sync),
  `endif

    .core_wfi_mode       (core_wfi_mode),
    .core_sleep_value    (core_sleep_value),

    .sysrstreq           (sysrstreq),
`ifdef N101_HAS_LOCKSTEP
    .lockstep_mis        (lockstep_mis),
`endif

    .dmactive            (dmactive),
    .dmactive_flag       (dmactive_flag),



    .io_pads_gpio_0_i_ival           (io_pads_gpio_0_i_ival),
    .io_pads_gpio_0_o_oval           (io_pads_gpio_0_o_oval),
    .io_pads_gpio_0_o_oe             (io_pads_gpio_0_o_oe),
    .io_pads_gpio_0_o_ie             (io_pads_gpio_0_o_ie),
    .io_pads_gpio_0_o_pue            (io_pads_gpio_0_o_pue),
    .io_pads_gpio_0_o_ds             (io_pads_gpio_0_o_ds),
    .io_pads_gpio_1_i_ival           (io_pads_gpio_1_i_ival),
    .io_pads_gpio_1_o_oval           (io_pads_gpio_1_o_oval),
    .io_pads_gpio_1_o_oe             (io_pads_gpio_1_o_oe),
    .io_pads_gpio_1_o_ie             (io_pads_gpio_1_o_ie),
    .io_pads_gpio_1_o_pue            (io_pads_gpio_1_o_pue),
    .io_pads_gpio_1_o_ds             (io_pads_gpio_1_o_ds),
    .io_pads_gpio_2_i_ival           (io_pads_gpio_2_i_ival),
    .io_pads_gpio_2_o_oval           (io_pads_gpio_2_o_oval),
    .io_pads_gpio_2_o_oe             (io_pads_gpio_2_o_oe),
    .io_pads_gpio_2_o_ie             (io_pads_gpio_2_o_ie),
    .io_pads_gpio_2_o_pue            (io_pads_gpio_2_o_pue),
    .io_pads_gpio_2_o_ds             (io_pads_gpio_2_o_ds),
    .io_pads_gpio_3_i_ival           (io_pads_gpio_3_i_ival),
    .io_pads_gpio_3_o_oval           (io_pads_gpio_3_o_oval),
    .io_pads_gpio_3_o_oe             (io_pads_gpio_3_o_oe),
    .io_pads_gpio_3_o_ie             (io_pads_gpio_3_o_ie),
    .io_pads_gpio_3_o_pue            (io_pads_gpio_3_o_pue),
    .io_pads_gpio_3_o_ds             (io_pads_gpio_3_o_ds),
    .io_pads_gpio_4_i_ival           (io_pads_gpio_4_i_ival),
    .io_pads_gpio_4_o_oval           (io_pads_gpio_4_o_oval),
    .io_pads_gpio_4_o_oe             (io_pads_gpio_4_o_oe),
    .io_pads_gpio_4_o_ie             (io_pads_gpio_4_o_ie),
    .io_pads_gpio_4_o_pue            (io_pads_gpio_4_o_pue),
    .io_pads_gpio_4_o_ds             (io_pads_gpio_4_o_ds),
    .io_pads_gpio_5_i_ival           (io_pads_gpio_5_i_ival),
    .io_pads_gpio_5_o_oval           (io_pads_gpio_5_o_oval),
    .io_pads_gpio_5_o_oe             (io_pads_gpio_5_o_oe),
    .io_pads_gpio_5_o_ie             (io_pads_gpio_5_o_ie),
    .io_pads_gpio_5_o_pue            (io_pads_gpio_5_o_pue),
    .io_pads_gpio_5_o_ds             (io_pads_gpio_5_o_ds),
    .io_pads_gpio_6_i_ival           (io_pads_gpio_6_i_ival),
    .io_pads_gpio_6_o_oval           (io_pads_gpio_6_o_oval),
    .io_pads_gpio_6_o_oe             (io_pads_gpio_6_o_oe),
    .io_pads_gpio_6_o_ie             (io_pads_gpio_6_o_ie),
    .io_pads_gpio_6_o_pue            (io_pads_gpio_6_o_pue),
    .io_pads_gpio_6_o_ds             (io_pads_gpio_6_o_ds),
    .io_pads_gpio_7_i_ival           (io_pads_gpio_7_i_ival),
    .io_pads_gpio_7_o_oval           (io_pads_gpio_7_o_oval),
    .io_pads_gpio_7_o_oe             (io_pads_gpio_7_o_oe),
    .io_pads_gpio_7_o_ie             (io_pads_gpio_7_o_ie),
    .io_pads_gpio_7_o_pue            (io_pads_gpio_7_o_pue),
    .io_pads_gpio_7_o_ds             (io_pads_gpio_7_o_ds),
    .io_pads_gpio_8_i_ival           (io_pads_gpio_8_i_ival),
    .io_pads_gpio_8_o_oval           (io_pads_gpio_8_o_oval),
    .io_pads_gpio_8_o_oe             (io_pads_gpio_8_o_oe),
    .io_pads_gpio_8_o_ie             (io_pads_gpio_8_o_ie),
    .io_pads_gpio_8_o_pue            (io_pads_gpio_8_o_pue),
    .io_pads_gpio_8_o_ds             (io_pads_gpio_8_o_ds),
    .io_pads_gpio_9_i_ival           (io_pads_gpio_9_i_ival),
    .io_pads_gpio_9_o_oval           (io_pads_gpio_9_o_oval),
    .io_pads_gpio_9_o_oe             (io_pads_gpio_9_o_oe),
    .io_pads_gpio_9_o_ie             (io_pads_gpio_9_o_ie),
    .io_pads_gpio_9_o_pue            (io_pads_gpio_9_o_pue),
    .io_pads_gpio_9_o_ds             (io_pads_gpio_9_o_ds),
    .io_pads_gpio_10_i_ival          (io_pads_gpio_10_i_ival),
    .io_pads_gpio_10_o_oval          (io_pads_gpio_10_o_oval),
    .io_pads_gpio_10_o_oe            (io_pads_gpio_10_o_oe),
    .io_pads_gpio_10_o_ie            (io_pads_gpio_10_o_ie),
    .io_pads_gpio_10_o_pue           (io_pads_gpio_10_o_pue),
    .io_pads_gpio_10_o_ds            (io_pads_gpio_10_o_ds),
    .io_pads_gpio_11_i_ival          (io_pads_gpio_11_i_ival),
    .io_pads_gpio_11_o_oval          (io_pads_gpio_11_o_oval),
    .io_pads_gpio_11_o_oe            (io_pads_gpio_11_o_oe),
    .io_pads_gpio_11_o_ie            (io_pads_gpio_11_o_ie),
    .io_pads_gpio_11_o_pue           (io_pads_gpio_11_o_pue),
    .io_pads_gpio_11_o_ds            (io_pads_gpio_11_o_ds),
    .io_pads_gpio_12_i_ival          (io_pads_gpio_12_i_ival),
    .io_pads_gpio_12_o_oval          (io_pads_gpio_12_o_oval),
    .io_pads_gpio_12_o_oe            (io_pads_gpio_12_o_oe),
    .io_pads_gpio_12_o_ie            (io_pads_gpio_12_o_ie),
    .io_pads_gpio_12_o_pue           (io_pads_gpio_12_o_pue),
    .io_pads_gpio_12_o_ds            (io_pads_gpio_12_o_ds),
    .io_pads_gpio_13_i_ival          (io_pads_gpio_13_i_ival),
    .io_pads_gpio_13_o_oval          (io_pads_gpio_13_o_oval),
    .io_pads_gpio_13_o_oe            (io_pads_gpio_13_o_oe),
    .io_pads_gpio_13_o_ie            (io_pads_gpio_13_o_ie),
    .io_pads_gpio_13_o_pue           (io_pads_gpio_13_o_pue),
    .io_pads_gpio_13_o_ds            (io_pads_gpio_13_o_ds),
    .io_pads_gpio_14_i_ival          (io_pads_gpio_14_i_ival),
    .io_pads_gpio_14_o_oval          (io_pads_gpio_14_o_oval),
    .io_pads_gpio_14_o_oe            (io_pads_gpio_14_o_oe),
    .io_pads_gpio_14_o_ie            (io_pads_gpio_14_o_ie),
    .io_pads_gpio_14_o_pue           (io_pads_gpio_14_o_pue),
    .io_pads_gpio_14_o_ds            (io_pads_gpio_14_o_ds),
    .io_pads_gpio_15_i_ival          (io_pads_gpio_15_i_ival),
    .io_pads_gpio_15_o_oval          (io_pads_gpio_15_o_oval),
    .io_pads_gpio_15_o_oe            (io_pads_gpio_15_o_oe),
    .io_pads_gpio_15_o_ie            (io_pads_gpio_15_o_ie),
    .io_pads_gpio_15_o_pue           (io_pads_gpio_15_o_pue),
    .io_pads_gpio_15_o_ds            (io_pads_gpio_15_o_ds),
    .io_pads_gpio_16_i_ival          (io_pads_gpio_16_i_ival),
    .io_pads_gpio_16_o_oval          (io_pads_gpio_16_o_oval),
    .io_pads_gpio_16_o_oe            (io_pads_gpio_16_o_oe),
    .io_pads_gpio_16_o_ie            (io_pads_gpio_16_o_ie),
    .io_pads_gpio_16_o_pue           (io_pads_gpio_16_o_pue),
    .io_pads_gpio_16_o_ds            (io_pads_gpio_16_o_ds),
    .io_pads_gpio_17_i_ival          (io_pads_gpio_17_i_ival),
    .io_pads_gpio_17_o_oval          (io_pads_gpio_17_o_oval),
    .io_pads_gpio_17_o_oe            (io_pads_gpio_17_o_oe),
    .io_pads_gpio_17_o_ie            (io_pads_gpio_17_o_ie),
    .io_pads_gpio_17_o_pue           (io_pads_gpio_17_o_pue),
    .io_pads_gpio_17_o_ds            (io_pads_gpio_17_o_ds),
    .io_pads_gpio_18_i_ival          (io_pads_gpio_18_i_ival),
    .io_pads_gpio_18_o_oval          (io_pads_gpio_18_o_oval),
    .io_pads_gpio_18_o_oe            (io_pads_gpio_18_o_oe),
    .io_pads_gpio_18_o_ie            (io_pads_gpio_18_o_ie),
    .io_pads_gpio_18_o_pue           (io_pads_gpio_18_o_pue),
    .io_pads_gpio_18_o_ds            (io_pads_gpio_18_o_ds),
    .io_pads_gpio_19_i_ival          (io_pads_gpio_19_i_ival),
    .io_pads_gpio_19_o_oval          (io_pads_gpio_19_o_oval),
    .io_pads_gpio_19_o_oe            (io_pads_gpio_19_o_oe),
    .io_pads_gpio_19_o_ie            (io_pads_gpio_19_o_ie),
    .io_pads_gpio_19_o_pue           (io_pads_gpio_19_o_pue),
    .io_pads_gpio_19_o_ds            (io_pads_gpio_19_o_ds),
    .io_pads_gpio_20_i_ival          (io_pads_gpio_20_i_ival),
    .io_pads_gpio_20_o_oval          (io_pads_gpio_20_o_oval),
    .io_pads_gpio_20_o_oe            (io_pads_gpio_20_o_oe),
    .io_pads_gpio_20_o_ie            (io_pads_gpio_20_o_ie),
    .io_pads_gpio_20_o_pue           (io_pads_gpio_20_o_pue),
    .io_pads_gpio_20_o_ds            (io_pads_gpio_20_o_ds),
    .io_pads_gpio_21_i_ival          (io_pads_gpio_21_i_ival),
    .io_pads_gpio_21_o_oval          (io_pads_gpio_21_o_oval),
    .io_pads_gpio_21_o_oe            (io_pads_gpio_21_o_oe),
    .io_pads_gpio_21_o_ie            (io_pads_gpio_21_o_ie),
    .io_pads_gpio_21_o_pue           (io_pads_gpio_21_o_pue),
    .io_pads_gpio_21_o_ds            (io_pads_gpio_21_o_ds),
    .io_pads_gpio_22_i_ival          (io_pads_gpio_22_i_ival),
    .io_pads_gpio_22_o_oval          (io_pads_gpio_22_o_oval),
    .io_pads_gpio_22_o_oe            (io_pads_gpio_22_o_oe),
    .io_pads_gpio_22_o_ie            (io_pads_gpio_22_o_ie),
    .io_pads_gpio_22_o_pue           (io_pads_gpio_22_o_pue),
    .io_pads_gpio_22_o_ds            (io_pads_gpio_22_o_ds),
    .io_pads_gpio_23_i_ival          (io_pads_gpio_23_i_ival),
    .io_pads_gpio_23_o_oval          (io_pads_gpio_23_o_oval),
    .io_pads_gpio_23_o_oe            (io_pads_gpio_23_o_oe),
    .io_pads_gpio_23_o_ie            (io_pads_gpio_23_o_ie),
    .io_pads_gpio_23_o_pue           (io_pads_gpio_23_o_pue),
    .io_pads_gpio_23_o_ds            (io_pads_gpio_23_o_ds),
    .io_pads_gpio_24_i_ival          (io_pads_gpio_24_i_ival),
    .io_pads_gpio_24_o_oval          (io_pads_gpio_24_o_oval),
    .io_pads_gpio_24_o_oe            (io_pads_gpio_24_o_oe),
    .io_pads_gpio_24_o_ie            (io_pads_gpio_24_o_ie),
    .io_pads_gpio_24_o_pue           (io_pads_gpio_24_o_pue),
    .io_pads_gpio_24_o_ds            (io_pads_gpio_24_o_ds),
    .io_pads_gpio_25_i_ival          (io_pads_gpio_25_i_ival),
    .io_pads_gpio_25_o_oval          (io_pads_gpio_25_o_oval),
    .io_pads_gpio_25_o_oe            (io_pads_gpio_25_o_oe),
    .io_pads_gpio_25_o_ie            (io_pads_gpio_25_o_ie),
    .io_pads_gpio_25_o_pue           (io_pads_gpio_25_o_pue),
    .io_pads_gpio_25_o_ds            (io_pads_gpio_25_o_ds),
    .io_pads_gpio_26_i_ival          (io_pads_gpio_26_i_ival),
    .io_pads_gpio_26_o_oval          (io_pads_gpio_26_o_oval),
    .io_pads_gpio_26_o_oe            (io_pads_gpio_26_o_oe),
    .io_pads_gpio_26_o_ie            (io_pads_gpio_26_o_ie),
    .io_pads_gpio_26_o_pue           (io_pads_gpio_26_o_pue),
    .io_pads_gpio_26_o_ds            (io_pads_gpio_26_o_ds),
    .io_pads_gpio_27_i_ival          (io_pads_gpio_27_i_ival),
    .io_pads_gpio_27_o_oval          (io_pads_gpio_27_o_oval),
    .io_pads_gpio_27_o_oe            (io_pads_gpio_27_o_oe),
    .io_pads_gpio_27_o_ie            (io_pads_gpio_27_o_ie),
    .io_pads_gpio_27_o_pue           (io_pads_gpio_27_o_pue),
    .io_pads_gpio_27_o_ds            (io_pads_gpio_27_o_ds),
    .io_pads_gpio_28_i_ival          (io_pads_gpio_28_i_ival),
    .io_pads_gpio_28_o_oval          (io_pads_gpio_28_o_oval),
    .io_pads_gpio_28_o_oe            (io_pads_gpio_28_o_oe),
    .io_pads_gpio_28_o_ie            (io_pads_gpio_28_o_ie),
    .io_pads_gpio_28_o_pue           (io_pads_gpio_28_o_pue),
    .io_pads_gpio_28_o_ds            (io_pads_gpio_28_o_ds),
    .io_pads_gpio_29_i_ival          (io_pads_gpio_29_i_ival),
    .io_pads_gpio_29_o_oval          (io_pads_gpio_29_o_oval),
    .io_pads_gpio_29_o_oe            (io_pads_gpio_29_o_oe),
    .io_pads_gpio_29_o_ie            (io_pads_gpio_29_o_ie),
    .io_pads_gpio_29_o_pue           (io_pads_gpio_29_o_pue),
    .io_pads_gpio_29_o_ds            (io_pads_gpio_29_o_ds),
    .io_pads_gpio_30_i_ival          (io_pads_gpio_30_i_ival),
    .io_pads_gpio_30_o_oval          (io_pads_gpio_30_o_oval),
    .io_pads_gpio_30_o_oe            (io_pads_gpio_30_o_oe),
    .io_pads_gpio_30_o_ie            (io_pads_gpio_30_o_ie),
    .io_pads_gpio_30_o_pue           (io_pads_gpio_30_o_pue),
    .io_pads_gpio_30_o_ds            (io_pads_gpio_30_o_ds),
    .io_pads_gpio_31_i_ival          (io_pads_gpio_31_i_ival),
    .io_pads_gpio_31_o_oval          (io_pads_gpio_31_o_oval),
    .io_pads_gpio_31_o_oe            (io_pads_gpio_31_o_oe),
    .io_pads_gpio_31_o_ie            (io_pads_gpio_31_o_ie),
    .io_pads_gpio_31_o_pue           (io_pads_gpio_31_o_pue),
    .io_pads_gpio_31_o_ds            (io_pads_gpio_31_o_ds),

    .io_pads_qspi_sck_i_ival    (io_pads_qspi_sck_i_ival    ),
    .io_pads_qspi_sck_o_oval    (io_pads_qspi_sck_o_oval    ),
    .io_pads_qspi_sck_o_oe      (io_pads_qspi_sck_o_oe      ),
    .io_pads_qspi_sck_o_ie      (io_pads_qspi_sck_o_ie      ),
    .io_pads_qspi_sck_o_pue     (io_pads_qspi_sck_o_pue     ),
    .io_pads_qspi_sck_o_ds      (io_pads_qspi_sck_o_ds      ),
    .io_pads_qspi_dq_0_i_ival   (io_pads_qspi_dq_0_i_ival   ),
    .io_pads_qspi_dq_0_o_oval   (io_pads_qspi_dq_0_o_oval   ),
    .io_pads_qspi_dq_0_o_oe     (io_pads_qspi_dq_0_o_oe     ),
    .io_pads_qspi_dq_0_o_ie     (io_pads_qspi_dq_0_o_ie     ),
    .io_pads_qspi_dq_0_o_pue    (io_pads_qspi_dq_0_o_pue    ),
    .io_pads_qspi_dq_0_o_ds     (io_pads_qspi_dq_0_o_ds     ),
    .io_pads_qspi_dq_1_i_ival   (io_pads_qspi_dq_1_i_ival   ),
    .io_pads_qspi_dq_1_o_oval   (io_pads_qspi_dq_1_o_oval   ),
    .io_pads_qspi_dq_1_o_oe     (io_pads_qspi_dq_1_o_oe     ),
    .io_pads_qspi_dq_1_o_ie     (io_pads_qspi_dq_1_o_ie     ),
    .io_pads_qspi_dq_1_o_pue    (io_pads_qspi_dq_1_o_pue    ),
    .io_pads_qspi_dq_1_o_ds     (io_pads_qspi_dq_1_o_ds     ),
    .io_pads_qspi_dq_2_i_ival   (io_pads_qspi_dq_2_i_ival   ),
    .io_pads_qspi_dq_2_o_oval   (io_pads_qspi_dq_2_o_oval   ),
    .io_pads_qspi_dq_2_o_oe     (io_pads_qspi_dq_2_o_oe     ),
    .io_pads_qspi_dq_2_o_ie     (io_pads_qspi_dq_2_o_ie     ),
    .io_pads_qspi_dq_2_o_pue    (io_pads_qspi_dq_2_o_pue    ),
    .io_pads_qspi_dq_2_o_ds     (io_pads_qspi_dq_2_o_ds     ),
    .io_pads_qspi_dq_3_i_ival   (io_pads_qspi_dq_3_i_ival   ),
    .io_pads_qspi_dq_3_o_oval   (io_pads_qspi_dq_3_o_oval   ),
    .io_pads_qspi_dq_3_o_oe     (io_pads_qspi_dq_3_o_oe     ),
    .io_pads_qspi_dq_3_o_ie     (io_pads_qspi_dq_3_o_ie     ),
    .io_pads_qspi_dq_3_o_pue    (io_pads_qspi_dq_3_o_pue    ),
    .io_pads_qspi_dq_3_o_ds     (io_pads_qspi_dq_3_o_ds     ),
    .io_pads_qspi_cs_0_i_ival   (io_pads_qspi_cs_0_i_ival   ),
    .io_pads_qspi_cs_0_o_oval   (io_pads_qspi_cs_0_o_oval   ),
    .io_pads_qspi_cs_0_o_oe     (io_pads_qspi_cs_0_o_oe     ),
    .io_pads_qspi_cs_0_o_ie     (io_pads_qspi_cs_0_o_ie     ),
    .io_pads_qspi_cs_0_o_pue    (io_pads_qspi_cs_0_o_pue    ),
    .io_pads_qspi_cs_0_o_ds     (io_pads_qspi_cs_0_o_ds     ),

    .jtag_tdi        (jtag_tdi           ),     
    .jtag_tdo        (jtag_tdo           ),
    .jtag_tms        (jtag_tms           ),
    .jtag_tck        (jtag_tck           ),
    .jtag_tdo_drv    (jtag_tdo_drv    ),
    .jtag_TMS_out    (jtag_TMS_out    ),
    .jtag_DRV_TMS    (jtag_DRV_TMS    ),
    
    .jtag_BK_TMS     (jtag_BK_TMS     ),
    .tap_rst_n       (tap_rst_n       ),

`ifdef N101_DBG_TIMEOUT 
    .dbg_toggle_a    (aon_clk         ),
`endif



    .mtime_toggle_a  (mtime_toggle_a),
                
    .test_mode       (test_mode)
  );



endmodule
