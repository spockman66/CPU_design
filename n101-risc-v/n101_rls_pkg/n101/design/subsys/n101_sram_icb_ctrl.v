 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         



















`include "n101_defines.v" 

module n101_sram_icb_ctrl #(
    parameter DW = 32,
    parameter MW = 4,
    parameter AW = 32,
    parameter AW_LSB = 3,
    parameter USR_W = 3 
)(
  output sram_ctrl_active,
  
  
      
  input  tcm_cgstop,

  input  stall_uop_cmd,
  
  
  
  
  input  i_icb_cmd_valid, 
  output i_icb_cmd_ready, 
  input  i_icb_cmd_read,  
  input  [AW-1:0] i_icb_cmd_addr, 
  input  [DW-1:0] i_icb_cmd_wdata, 
  input  [MW-1:0] i_icb_cmd_wmask, 
  input  [USR_W-1:0] i_icb_cmd_usr, 

  
  output i_icb_rsp_valid, 
  input  i_icb_rsp_ready, 
  output [DW-1:0] i_icb_rsp_rdata, 
  output [USR_W-1:0] i_icb_rsp_usr, 

  output          ram_cs,  
  output [AW-AW_LSB-1:0] ram_addr, 
  output [MW-1:0] ram_wem,
  output [DW-1:0] ram_din,          
  input  [DW-1:0] ram_dout,
  output          clk_ram,

  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );

    
    
  wire  byp_icb_cmd_valid;
  wire  byp_icb_cmd_ready;
  wire  byp_icb_cmd_read;
  wire  [AW-1:0] byp_icb_cmd_addr; 
  wire  [DW-1:0] byp_icb_cmd_wdata; 
  wire  [MW-1:0] byp_icb_cmd_wmask; 
  wire  [USR_W-1:0] byp_icb_cmd_usr; 

  localparam BUF_CMD_PACK_W = (AW+DW+MW+USR_W+1);
  wire [BUF_CMD_PACK_W-1:0] byp_icb_cmd_o_pack;
  wire [BUF_CMD_PACK_W-1:0] byp_icb_cmd_i_pack =  {
                      i_icb_cmd_read, 
                      i_icb_cmd_addr, 
                      i_icb_cmd_wdata, 
                      i_icb_cmd_wmask, 
                      i_icb_cmd_usr  
                    };
  assign {
                      byp_icb_cmd_read, 
                      byp_icb_cmd_addr, 
                      byp_icb_cmd_wdata, 
                      byp_icb_cmd_wmask, 
                      byp_icb_cmd_usr  
                    } = byp_icb_cmd_o_pack;

     
  n101_gnrl_bypbuf # (
   .DP(1),
   .DW(BUF_CMD_PACK_W)
  ) u_byp_icb_cmd_buf(
    .i_vld(i_icb_cmd_valid), 
    .i_rdy(i_icb_cmd_ready), 
    .i_dat(byp_icb_cmd_i_pack),
    .o_vld(byp_icb_cmd_valid), 
    .o_rdy(byp_icb_cmd_ready), 
    .o_dat(byp_icb_cmd_o_pack),
  
    .clk  (clk  ),
    .rst_n(rst_n)  
   );


  
  
  
  
  wire sram_active;

  n101_1cyc_sram_ctrl #(
      .DW     (DW),
      .AW     (AW),
      .MW     (MW),
      .AW_LSB (AW_LSB),
      .USR_W  (USR_W) 
  ) u_n101_1cyc_sram_ctrl(
     .sram_ctrl_active (sram_active),
     .tcm_cgstop       (tcm_cgstop),

     .stall_uop_cmd (stall_uop_cmd),
     
     .uop_cmd_valid (byp_icb_cmd_valid),
     .uop_cmd_ready (byp_icb_cmd_ready),
     .uop_cmd_read  (byp_icb_cmd_read ),
     .uop_cmd_addr  (byp_icb_cmd_addr ), 
     .uop_cmd_wdata (byp_icb_cmd_wdata), 
     .uop_cmd_wmask (byp_icb_cmd_wmask), 
     .uop_cmd_usr   (byp_icb_cmd_usr  ),
  
     .uop_rsp_valid (i_icb_rsp_valid),
     .uop_rsp_ready (i_icb_rsp_ready),
     .uop_rsp_rdata (i_icb_rsp_rdata),
     .uop_rsp_usr   (i_icb_rsp_usr  ),
  
     .ram_cs   (ram_cs  ),  
     .ram_addr (ram_addr), 
     .ram_wem  (ram_wem ),
     .ram_din  (ram_din ),          
     .ram_dout (ram_dout),
     .clk_ram  (clk_ram ),
  
     .clkgate_bypass(clkgate_bypass  ),
     .clk  (clk  ),
     .rst_n(rst_n)  
    );


  assign sram_ctrl_active = 
                       i_icb_cmd_valid 
                     | byp_icb_cmd_valid 
                     | sram_active  
                     | i_icb_rsp_valid 
                     ;

endmodule

