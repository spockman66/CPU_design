
`include "n100_defines.v"
`include "tb_defines.v"
`include "n100_subsys_defines.v"

module tb_mem_init(
  input tb_clk
);

  //****************************************************************************************************
  // Read the test verilog file and initialize the ILM

  localparam ILM_RAM_DP = `N100_ILM_RAM_DP;

  integer i;
  reg [7:0] ilm_mem [0:(ILM_RAM_DP*4)-1];
  reg [6:0] ilm_mem_ecc_code[0:ILM_RAM_DP-1];

  reg[8*300:1] testcase;

  initial begin //{
      $display("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");  
      if($value$plusargs("TESTCASE=%s",testcase))begin
        $display("TESTCASE=%s",testcase);
      end


    $readmemh({testcase, ".verilog"}, ilm_mem);

    for (i=0;i<(ILM_RAM_DP);i=i+1) begin
        `ILM_MEM[i][00+7:00] = ilm_mem[i*4+0];
        `ILM_MEM[i][08+7:08] = ilm_mem[i*4+1];
        `ILM_MEM[i][16+7:16] = ilm_mem[i*4+2];
        `ILM_MEM[i][24+7:24] = ilm_mem[i*4+3];
        `ifdef N100_HAS_ECC//{
        `ILM_MEM[i][38:32] = ecc_code_32gen(`ILM_MEM[i][31:0]);
        `ILM_MEM[i][39] = 1'b0;
        `endif//}
    end


    for (i=0;i<(ILM_RAM_DP);i=i+1) begin
        `DLM_MEM[i][00+7:00] = 0;
        `DLM_MEM[i][08+7:08] = 0;
        `DLM_MEM[i][16+7:16] = 0;
        `DLM_MEM[i][24+7:24] = 0;
        `ifdef N100_HAS_ECC//{
        `DLM_MEM[i][38:32] = ecc_code_32gen(`DLM_MEM[i][31:0]);
        `DLM_MEM[i][39] = 1'b0;
        `endif//}
    end


    $display("ILM 0x00: %h", `ILM_MEM[8'h00]);
    $display("ILM 0x01: %h", `ILM_MEM[8'h01]);
    $display("ILM 0x02: %h", `ILM_MEM[8'h02]);
    $display("ILM 0x03: %h", `ILM_MEM[8'h03]);
    $display("ILM 0x04: %h", `ILM_MEM[8'h04]);
    $display("ILM 0x05: %h", `ILM_MEM[8'h05]);
    $display("ILM 0x06: %h", `ILM_MEM[8'h06]);
    $display("ILM 0x07: %h", `ILM_MEM[8'h07]);
    $display("ILM 0x16: %h", `ILM_MEM[8'h16]);
    $display("ILM 0x20: %h", `ILM_MEM[8'h20]);

  end //}
  
  // when reset happens, intialize ILM again
  always @(negedge (`CPU_CORE_WRAPPER.core_reset_n | `CPU_CORE_WRAPPER.por_reset_n)) begin

    $readmemh({testcase, ".verilog"}, ilm_mem);

    for (i=0;i<(ILM_RAM_DP);i=i+1) begin
        `ILM_MEM[i][00+7:00] = ilm_mem[i*4+0];
        `ILM_MEM[i][08+7:08] = ilm_mem[i*4+1];
        `ILM_MEM[i][16+7:16] = ilm_mem[i*4+2];
        `ILM_MEM[i][24+7:24] = ilm_mem[i*4+3];
        `ifdef N100_HAS_ECC//{
        `ILM_MEM[i][38:32] = ecc_code_32gen(`ILM_MEM[i][31:0]);
        `ILM_MEM[i][39] = 1'b0;
        `endif//}
    end
  end

    function [6:0] ecc_code_32gen(input[31:0]i_dat);
        begin
        ecc_code_32gen[0] = 
            i_dat[ 0] ^ i_dat[ 1] ^ i_dat[ 3] ^ i_dat[ 4] ^ i_dat[ 6] ^ i_dat[ 8] ^ i_dat[10] ^ i_dat[11] ^
            i_dat[13] ^ i_dat[15] ^ i_dat[17] ^ i_dat[19] ^ i_dat[21] ^ i_dat[23] ^ i_dat[25] ^ i_dat[26] ^
            i_dat[28] ^ i_dat[30];  
         
        ecc_code_32gen[1] =
            i_dat[ 0] ^ i_dat[ 2] ^ i_dat[ 3] ^ i_dat[ 5] ^ i_dat[ 6] ^ i_dat[ 9] ^ i_dat[10] ^ i_dat[12] ^
            i_dat[13] ^ i_dat[16] ^ i_dat[17] ^ i_dat[20] ^ i_dat[21] ^ i_dat[24] ^ i_dat[25] ^ i_dat[27] ^
            i_dat[28] ^ i_dat[31];

        ecc_code_32gen[2] =
            i_dat[ 1] ^ i_dat[ 2] ^ i_dat[ 3] ^ i_dat[ 7] ^ i_dat[ 8] ^ i_dat[ 9] ^ i_dat[10] ^ i_dat[14] ^
            i_dat[15] ^ i_dat[16] ^ i_dat[17] ^ i_dat[22] ^ i_dat[23] ^ i_dat[24] ^ i_dat[25] ^ i_dat[29] ^
            i_dat[30] ^ i_dat[31];

        ecc_code_32gen[3] =
            i_dat[ 4] ^ i_dat[ 5] ^ i_dat[ 6] ^ i_dat[ 7] ^ i_dat[ 8] ^ i_dat[ 9] ^ i_dat[10] ^ i_dat[18] ^
            i_dat[19] ^ i_dat[20] ^ i_dat[21] ^ i_dat[22] ^ i_dat[23] ^ i_dat[24] ^ i_dat[25]; 

        ecc_code_32gen[4] =
            i_dat[11] ^ i_dat[12] ^ i_dat[13] ^ i_dat[14] ^ i_dat[15] ^ i_dat[16] ^ i_dat[17] ^ i_dat[18] ^
            i_dat[19] ^ i_dat[20] ^ i_dat[21] ^ i_dat[22] ^ i_dat[23] ^ i_dat[24] ^ i_dat[25];

        ecc_code_32gen[5] = 
            i_dat[26] ^ i_dat[27] ^ i_dat[28] ^ i_dat[29] ^ i_dat[30] ^ i_dat[31];

        ecc_code_32gen[6] =
            i_dat[ 0] ^ i_dat[ 1] ^ i_dat[ 2] ^ i_dat[ 3] ^ i_dat[ 4] ^ i_dat[ 5] ^ i_dat[ 6] ^ i_dat[ 7] ^ 
            i_dat[ 8] ^ i_dat[ 9] ^ i_dat[10] ^ i_dat[11] ^ i_dat[12] ^ i_dat[13] ^ i_dat[14] ^ i_dat[15] ^ 
            i_dat[16] ^ i_dat[17] ^ i_dat[18] ^ i_dat[19] ^ i_dat[20] ^ i_dat[21] ^ i_dat[22] ^ i_dat[23] ^ 
            i_dat[24] ^ i_dat[25] ^ i_dat[26] ^ i_dat[27] ^ i_dat[28] ^ i_dat[29] ^ i_dat[30] ^ i_dat[31] ^ 
            ecc_code_32gen[0] ^ ecc_code_32gen[1] ^ ecc_code_32gen[2] ^ ecc_code_32gen[3] ^ ecc_code_32gen[4] ^ ecc_code_32gen[5];
        end
    endfunction

endmodule
