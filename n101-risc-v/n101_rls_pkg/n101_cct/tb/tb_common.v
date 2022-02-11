
`include "n100_defines.v"
`include "tb_defines.v"

module tb_wait_pass (
  input  tb_clk,
  input  tb_rst_n,
  output reg [31:0] pc_write_to_host_cnt,
  output reg [31:0] pc_write_to_host_cycle,
  output reg [31:0] valid_ir_cycle,
  output reg [31:0] cycle_count

);

  


  wire chk_write_tohost = `CPU_CORE_TOP.mscratch_ena & (`CPU_CORE_TOP.mscratch_nxt == 32'h1);  
  wire [`N100_PC_SIZE-1:0] pc = `CPU_CORE_TOP.alu_cmt_i_pc;
  wire [`N100_PC_SIZE-1:0] pc_vld = `CPU_CORE_TOP.alu_cmt_i_valid;
  reg pc_write_to_host_flag;
  
  always @(posedge tb_clk or negedge tb_rst_n)
  begin 
    if(tb_rst_n == 1'b0) begin
        pc_write_to_host_cnt <= 32'b0;
        pc_write_to_host_flag <= 1'b0;
        pc_write_to_host_cycle <= 32'b0;
    end
    else if (pc_vld & chk_write_tohost) begin
        pc_write_to_host_cnt <= pc_write_to_host_cnt + 1'b1;
        pc_write_to_host_flag <= 1'b1;
        if (pc_write_to_host_flag == 1'b0) begin
            pc_write_to_host_cycle <= cycle_count;
        end
    end
  end

  always @(posedge tb_clk or negedge tb_rst_n)
  begin 
    if(tb_rst_n == 1'b0) begin
        cycle_count <= 32'b0;
    end
    else begin
        cycle_count <= cycle_count + 1'b1;
    end
  end

  wire i_valid = `CPU_CORE.ifu_o_valid;
  wire i_ready = `CPU_CORE.ifu_o_ready;

  always @(posedge tb_clk or negedge tb_rst_n)
  begin 
    if(tb_rst_n == 1'b0) begin
        valid_ir_cycle <= 32'b0;
    end
    else if(i_valid & i_ready & (pc_write_to_host_flag == 1'b0)) begin
        valid_ir_cycle <= valid_ir_cycle + 1'b1;
    end
  end


endmodule



