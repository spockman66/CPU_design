
`include "n100_defines.v"
`include "tb_defines.v"

module tb_irq_gen(
  input tb_clk
);

  //****************************************************************************************************
  // Read the test verilog file and initialize the ILM

  integer tb_force_irq;
  integer tb_force_resp_err;
  integer tb_wfi_force_irq;
  initial begin
    $value$plusargs("FORCE_IRQ=%d",tb_force_irq);
    $display("FORCE_IRQ=%d",tb_force_irq);
    $value$plusargs("FORCE_RESP_ERR=%d",tb_force_resp_err);
    $display("FORCE_RESP_ERR=%d",tb_force_resp_err);
    $value$plusargs("WFI_FORCE_IRQ=%d",tb_wfi_force_irq);
    $display("WFI_FORCE_IRQ=%d",tb_wfi_force_irq);
    //$display("SEED=%d",$urandom_range(1, 2000));
  end


  //****************************************************************************************************
  // Check the result
  reg random0_ena;
  reg random1_ena;
  reg random2_ena;
  reg random3_ena;
  reg random4_ena;
  reg random5_ena;
  reg random6_ena;
  reg random7_ena;
  reg random8_ena;
  reg random9_ena;
`ifdef N100_HAS_SCP//{
  reg random0_sig;
`endif//N100_HAS_SCP}
  reg dummy;
  reg tb_dbg_irq;
  reg tb_dbg_hlt;
`ifdef N100_HAS_NDSE//{
  reg tb_plic_irq;
`endif//N100_HAS_NDSE}
  reg tb_rx_evt;
  reg tb_tmr_irq;
  reg tb_sft_irq;
  reg tb_nmi_plus;
`ifdef N100_HAS_NDSE//{
  reg  tb_mip_imecci;
  reg  tb_mip_bwei;
  reg  tb_mip_pmovi;
`endif//N100_HAS_NDSE}
  `ifdef N100_HAS_CLIC//{
  reg [`N100_CLIC_IRQ_NUM-1:0] tb_clic_irq;
  `endif//}

  reg tb_tmr_irq_plus;
  reg tb_sft_irq_plus;
`ifdef N100_HAS_NDSE//{
  reg tb_plic_irq_plus;
`endif//N100_HAS_NDSE}


 
  wire [`N100_XLEN-1:0] x3 = `CPU_CORE_TOP.x3;

  wire [31:0] pc_write_to_host_cnt;
  wire [31:0] pc_write_to_host_cycle;
  wire [31:0] valid_ir_cycle;
  wire [31:0] cycle_count;

  tb_wait_pass u_tb_wait_pass(tb_clk,tb_top.tb_rst_n,pc_write_to_host_cnt,pc_write_to_host_cycle,valid_ir_cycle,cycle_count);

  initial begin
    #600
    @(pc_write_to_host_cnt == 32'd8) #10 dummy <=1;

    #100

    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~ Test Finish  ~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    $display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    #10
    $finish;
  end


endmodule
