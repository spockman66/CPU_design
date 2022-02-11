`include "n100_defines.v"
`include "tb_defines.v"

module tb_top();

  reg  sys_clk;
  reg  aon_clk;
  reg  tb_rst_n;

  reg  gpio_30_pin;
  reg  gpio_31_pin;


  wire hfclk = sys_clk;// To leave it here since many TB cov need to use this
  `RANDOM_PIN(gpio_30_pin)
  `RANDOM_PIN(gpio_31_pin)

//Set random seed
longint seed;
  initial begin
    if($value$plusargs("SEED=%d", seed)) begin
      $display("SEED = %d", seed);
    end
  end



  integer tb_force_delay;
  initial begin
    $value$plusargs("FORCE_DELAY=%d",tb_force_delay);
    $display("FORCE_DELAY=%d",tb_force_delay);
  end

  reg random7;
  reg random8;
  reg random9;

  `RANDOM_ALL(random7)
  `RANDOM_ALL(random8)
  `RANDOM_ALL(random9)





`ifdef  N100_HAS_MEM_ERR_PROT//{
    `ifdef N100_HAS_ECC//{
      `ifdef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_ecc_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifndef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_ecc_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifdef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_ecc_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
      `ifndef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_ecc_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
    `endif//}
    `ifdef N100_HAS_PARITY//{
      `ifdef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_parity_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifndef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_parity_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifdef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_parity_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
      `ifndef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_parity_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
    `endif//}
`endif//}
`ifndef N100_HAS_MEM_ERR_PROT//{
      `ifdef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifndef N100_HAS_ILM//{
  `define ILM_ICB_STALL `SUB_LM.u_ilm_icb_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_ILM}
      `ifdef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
      `ifndef N100_HAS_DLM//{
  `define DLM_ICB_STALL `SUB_LM.u_dlm_icb_ctrl.u_n100_1cyc_sram_ctrl.stall_uop_cmd
      `endif//N100_HAS_DLM}
`endif//}

  //    `ifdef N100_HAS_ILM //{
  //`define MEM_ICB_STALL  `SUB_MAIN.u_n100_subsys_mems.u_ilm_1to2_icb.u_i_icb_splt.rspid_fifo_full
  //    `endif//N100_HAS_ILM}
  //    `ifndef N100_HAS_ILM //{
  //`define MEM_ICB_STALL  `SUB_MAIN.u_n100_subsys_mems.u_nurv_mem_fab.u_i_icb_splt.rspid_fifo_full
  //    `endif//}

  initial begin
    #200
    if(tb_force_delay == 1) begin//{
     `ifdef N100_CFG_HAS_ILM //{
     force `ILM_ICB_STALL = random7;
     `endif //}

     `ifdef N100_CFG_HAS_DLM //{
     force `DLM_ICB_STALL = random8;
     `endif //}

  //   force `MEM_ICB_STALL  = random9;
    end//}
  end

  initial begin
     sys_clk    <=0;
     aon_clk <=0;
     tb_rst_n <=0;
     #2000 tb_rst_n <=1;
     #2000 tb_rst_n <=0;
     #2000 tb_rst_n <=1;
  end

  always
  begin 
     #31 sys_clk <= ~sys_clk;
  end

  always
  begin 
     #1000 aon_clk <= ~aon_clk;
  end

  integer dumpwave;

  initial begin
    $value$plusargs("DUMPWAVE=%d",dumpwave);
    if(dumpwave != 0)begin
      $fsdbDumpfile("tb_top.fsdb");
      $fsdbDumpvars(0, tb_top, "+mda");
    end
  end

  initial begin
    #200000000
    $display("Time Out !!!");
    $finish;
  end

  //****************************************************************************************************
  // Here we instantiated the TB ILM-Loader and Result-Checker
  tb_mem_init u_tb_mem_init(sys_clk);
  tb_monitor u_tb_monitor(sys_clk);
  tb_irq_gen u_tb_irq_gen(sys_clk);
  //****************************************************************************************************
  // Here we instantiated the Demo SoC
  n100_soc_top u_n100_soc_top(
   
   .por_rst_n(tb_rst_n),
   .sys_rst_n(tb_rst_n),

   .sys_clk(sys_clk),
   .aon_clk(aon_clk),

   .evt_i  (1'b0),
   .nmi_i  (1'b0),
   .core_sleep_value (),
   .core_wfi_mode  (),

   .dmactive(),
   .dmactive_flag(),

   .io_pads_jtag_TCK_i_ival (1'b0),
   .io_pads_jtag_TMS_i_ival (1'b0),
   .io_pads_jtag_TDI_i_ival (1'b0),
   .io_pads_jtag_TDO_o_oval (),
   .io_pads_gpio_0_i_ival (1'b1),
   .io_pads_gpio_0_o_oval (),
   .io_pads_gpio_0_o_oe (),
   .io_pads_gpio_0_o_ie (),
   .io_pads_gpio_0_o_pue (),
   .io_pads_gpio_0_o_ds (),
   .io_pads_gpio_1_i_ival (1'b1),
   .io_pads_gpio_1_o_oval (),
   .io_pads_gpio_1_o_oe (),
   .io_pads_gpio_1_o_ie (),
   .io_pads_gpio_1_o_pue (),
   .io_pads_gpio_1_o_ds (),
   .io_pads_gpio_2_i_ival (1'b1),
   .io_pads_gpio_2_o_oval (),
   .io_pads_gpio_2_o_oe (),
   .io_pads_gpio_2_o_ie (),
   .io_pads_gpio_2_o_pue (),
   .io_pads_gpio_2_o_ds (),
   .io_pads_gpio_3_i_ival (1'b1),
   .io_pads_gpio_3_o_oval (),
   .io_pads_gpio_3_o_oe (),
   .io_pads_gpio_3_o_ie (),
   .io_pads_gpio_3_o_pue (),
   .io_pads_gpio_3_o_ds (),
   .io_pads_gpio_4_i_ival (1'b1),
   .io_pads_gpio_4_o_oval (),
   .io_pads_gpio_4_o_oe (),
   .io_pads_gpio_4_o_ie (),
   .io_pads_gpio_4_o_pue (),
   .io_pads_gpio_4_o_ds (),
   .io_pads_gpio_5_i_ival (1'b1),
   .io_pads_gpio_5_o_oval (),
   .io_pads_gpio_5_o_oe (),
   .io_pads_gpio_5_o_ie (),
   .io_pads_gpio_5_o_pue (),
   .io_pads_gpio_5_o_ds (),
   .io_pads_gpio_6_i_ival (1'b1),
   .io_pads_gpio_6_o_oval (),
   .io_pads_gpio_6_o_oe (),
   .io_pads_gpio_6_o_ie (),
   .io_pads_gpio_6_o_pue (),
   .io_pads_gpio_6_o_ds (),
   .io_pads_gpio_7_i_ival (1'b1),
   .io_pads_gpio_7_o_oval (),
   .io_pads_gpio_7_o_oe (),
   .io_pads_gpio_7_o_ie (),
   .io_pads_gpio_7_o_pue (),
   .io_pads_gpio_7_o_ds (),
   .io_pads_gpio_8_i_ival (1'b1),
   .io_pads_gpio_8_o_oval (),
   .io_pads_gpio_8_o_oe (),
   .io_pads_gpio_8_o_ie (),
   .io_pads_gpio_8_o_pue (),
   .io_pads_gpio_8_o_ds (),
   .io_pads_gpio_9_i_ival (1'b1),
   .io_pads_gpio_9_o_oval (),
   .io_pads_gpio_9_o_oe (),
   .io_pads_gpio_9_o_ie (),
   .io_pads_gpio_9_o_pue (),
   .io_pads_gpio_9_o_ds (),
   .io_pads_gpio_10_i_ival (1'b1),
   .io_pads_gpio_10_o_oval (),
   .io_pads_gpio_10_o_oe (),
   .io_pads_gpio_10_o_ie (),
   .io_pads_gpio_10_o_pue (),
   .io_pads_gpio_10_o_ds (),
   .io_pads_gpio_11_i_ival (1'b1),
   .io_pads_gpio_11_o_oval (),
   .io_pads_gpio_11_o_oe (),
   .io_pads_gpio_11_o_ie (),
   .io_pads_gpio_11_o_pue (),
   .io_pads_gpio_11_o_ds (),
   .io_pads_gpio_12_i_ival (1'b1),
   .io_pads_gpio_12_o_oval (),
   .io_pads_gpio_12_o_oe (),
   .io_pads_gpio_12_o_ie (),
   .io_pads_gpio_12_o_pue (),
   .io_pads_gpio_12_o_ds (),
   .io_pads_gpio_13_i_ival (1'b1),
   .io_pads_gpio_13_o_oval (),
   .io_pads_gpio_13_o_oe (),
   .io_pads_gpio_13_o_ie (),
   .io_pads_gpio_13_o_pue (),
   .io_pads_gpio_13_o_ds (),
   .io_pads_gpio_14_i_ival (1'b1),
   .io_pads_gpio_14_o_oval (),
   .io_pads_gpio_14_o_oe (),
   .io_pads_gpio_14_o_ie (),
   .io_pads_gpio_14_o_pue (),
   .io_pads_gpio_14_o_ds (),
   .io_pads_gpio_15_i_ival (1'b1),
   .io_pads_gpio_15_o_oval (),
   .io_pads_gpio_15_o_oe (),
   .io_pads_gpio_15_o_ie (),
   .io_pads_gpio_15_o_pue (),
   .io_pads_gpio_15_o_ds (),
   .io_pads_gpio_16_i_ival (1'b1),
   .io_pads_gpio_16_o_oval (),
   .io_pads_gpio_16_o_oe (),
   .io_pads_gpio_16_o_ie (),
   .io_pads_gpio_16_o_pue (),
   .io_pads_gpio_16_o_ds (),
   .io_pads_gpio_17_i_ival (1'b1),
   .io_pads_gpio_17_o_oval (),
   .io_pads_gpio_17_o_oe (),
   .io_pads_gpio_17_o_ie (),
   .io_pads_gpio_17_o_pue (),
   .io_pads_gpio_17_o_ds (),
   .io_pads_gpio_18_i_ival (1'b1),
   .io_pads_gpio_18_o_oval (),
   .io_pads_gpio_18_o_oe (),
   .io_pads_gpio_18_o_ie (),
   .io_pads_gpio_18_o_pue (),
   .io_pads_gpio_18_o_ds (),
   .io_pads_gpio_19_i_ival (1'b1),
   .io_pads_gpio_19_o_oval (),
   .io_pads_gpio_19_o_oe (),
   .io_pads_gpio_19_o_ie (),
   .io_pads_gpio_19_o_pue (),
   .io_pads_gpio_19_o_ds (),
   .io_pads_gpio_20_i_ival (1'b1),
   .io_pads_gpio_20_o_oval (),
   .io_pads_gpio_20_o_oe (),
   .io_pads_gpio_20_o_ie (),
   .io_pads_gpio_20_o_pue (),
   .io_pads_gpio_20_o_ds (),
   .io_pads_gpio_21_i_ival (1'b1),
   .io_pads_gpio_21_o_oval (),
   .io_pads_gpio_21_o_oe (),
   .io_pads_gpio_21_o_ie (),
   .io_pads_gpio_21_o_pue (),
   .io_pads_gpio_21_o_ds (),
   .io_pads_gpio_22_i_ival (1'b1),
   .io_pads_gpio_22_o_oval (),
   .io_pads_gpio_22_o_oe (),
   .io_pads_gpio_22_o_ie (),
   .io_pads_gpio_22_o_pue (),
   .io_pads_gpio_22_o_ds (),
   .io_pads_gpio_23_i_ival (1'b1),
   .io_pads_gpio_23_o_oval (),
   .io_pads_gpio_23_o_oe (),
   .io_pads_gpio_23_o_ie (),
   .io_pads_gpio_23_o_pue (),
   .io_pads_gpio_23_o_ds (),
   .io_pads_gpio_24_i_ival (1'b1),
   .io_pads_gpio_24_o_oval (),
   .io_pads_gpio_24_o_oe (),
   .io_pads_gpio_24_o_ie (),
   .io_pads_gpio_24_o_pue (),
   .io_pads_gpio_24_o_ds (),
   .io_pads_gpio_25_i_ival (1'b1),
   .io_pads_gpio_25_o_oval (),
   .io_pads_gpio_25_o_oe (),
   .io_pads_gpio_25_o_ie (),
   .io_pads_gpio_25_o_pue (),
   .io_pads_gpio_25_o_ds (),
   .io_pads_gpio_26_i_ival (1'b1),
   .io_pads_gpio_26_o_oval (),
   .io_pads_gpio_26_o_oe (),
   .io_pads_gpio_26_o_ie (),
   .io_pads_gpio_26_o_pue (),
   .io_pads_gpio_26_o_ds (),
   .io_pads_gpio_27_i_ival (1'b1),
   .io_pads_gpio_27_o_oval (),
   .io_pads_gpio_27_o_oe (),
   .io_pads_gpio_27_o_ie (),
   .io_pads_gpio_27_o_pue (),
   .io_pads_gpio_27_o_ds (),
   .io_pads_gpio_28_i_ival (1'b1),
   .io_pads_gpio_28_o_oval (),
   .io_pads_gpio_28_o_oe (),
   .io_pads_gpio_28_o_ie (),
   .io_pads_gpio_28_o_pue (),
   .io_pads_gpio_28_o_ds (),
   .io_pads_gpio_29_i_ival (1'b1),
   .io_pads_gpio_29_o_oval (),
   .io_pads_gpio_29_o_oe (),
   .io_pads_gpio_29_o_ie (),
   .io_pads_gpio_29_o_pue (),
   .io_pads_gpio_29_o_ds (),
   .io_pads_gpio_30_i_ival (gpio_30_pin),
   .io_pads_gpio_30_o_oval (),
   .io_pads_gpio_30_o_oe (),
   .io_pads_gpio_30_o_ie (),
   .io_pads_gpio_30_o_pue (),
   .io_pads_gpio_30_o_ds (),
   .io_pads_gpio_31_i_ival (gpio_31_pin),
   .io_pads_gpio_31_o_oval (),
   .io_pads_gpio_31_o_oe (),
   .io_pads_gpio_31_o_ie (),
   .io_pads_gpio_31_o_pue (),
   .io_pads_gpio_31_o_ds (),

   .io_pads_qspi_sck_o_oval (),
   .io_pads_qspi_dq_0_i_ival (1'b1),
   .io_pads_qspi_dq_0_o_oval (),
   .io_pads_qspi_dq_0_o_oe (),
   .io_pads_qspi_dq_0_o_ie (),
   .io_pads_qspi_dq_0_o_pue (),
   .io_pads_qspi_dq_0_o_ds (),
   .io_pads_qspi_dq_1_i_ival (1'b1),
   .io_pads_qspi_dq_1_o_oval (),
   .io_pads_qspi_dq_1_o_oe (),
   .io_pads_qspi_dq_1_o_ie (),
   .io_pads_qspi_dq_1_o_pue (),
   .io_pads_qspi_dq_1_o_ds (),
   .io_pads_qspi_dq_2_i_ival (1'b1),
   .io_pads_qspi_dq_2_o_oval (),
   .io_pads_qspi_dq_2_o_oe (),
   .io_pads_qspi_dq_2_o_ie (),
   .io_pads_qspi_dq_2_o_pue (),
   .io_pads_qspi_dq_2_o_ds (),
   .io_pads_qspi_dq_3_i_ival (1'b1),
   .io_pads_qspi_dq_3_o_oval (),
   .io_pads_qspi_dq_3_o_oe (),
   .io_pads_qspi_dq_3_o_ie (),
   .io_pads_qspi_dq_3_o_pue (),
   .io_pads_qspi_dq_3_o_ds (),
   .io_pads_qspi_cs_0_o_oval (),
   .io_pads_jtag_tdo_drv_o_oval (),
   .io_pads_jtag_TMS_out_o_oval (),
   .io_pads_jtag_DRV_TMS_o_oval (),
   .io_pads_jtag_ap_o_oval (),
   .io_pads_jtag_tap_rst_n_o_oval ()

);
 

endmodule
