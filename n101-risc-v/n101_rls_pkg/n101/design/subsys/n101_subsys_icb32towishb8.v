 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         













`include "n101_defines.v" 











module n101_gnrl_icb32towishb8 # (
  parameter AW = 32 
) (
  input              i_icb_cmd_valid, 
  output             i_icb_cmd_ready, 
  input              i_icb_cmd_read, 
  input  [AW-1:0]    i_icb_cmd_addr, 
  input  [32-1:0]    i_icb_cmd_wdata, 
  input  [4-1:0]  i_icb_cmd_wmask,
  input  [1:0]       i_icb_cmd_size,

  output             i_icb_rsp_valid, 
  
  output             i_icb_rsp_err,
  output [32-1:0]    i_icb_rsp_rdata, 
  
  
  output  [AW-1:0] wb_adr,     
  output  [8-1:0]  wb_dat_w,   
  input   [8-1:0]  wb_dat_r,   
  output           wb_we,      
  output           wb_stb,     
  output           wb_cyc,     
  input            wb_ack,     

  input  clk,  
  input  rst_n
  );

  assign wb_adr   = i_icb_cmd_addr;
  assign wb_we    = ~i_icb_cmd_read;

  
  assign wb_dat_w = 
             i_icb_cmd_wmask[3] ? i_icb_cmd_wdata[31:24] :
             i_icb_cmd_wmask[2] ? i_icb_cmd_wdata[23:16] :
             i_icb_cmd_wmask[1] ? i_icb_cmd_wdata[15:8] :
             i_icb_cmd_wmask[0] ? i_icb_cmd_wdata[7:0] :
                                  8'b0;
             
             
  wire  [32-1:0]  wb_dat_r_remap = 
                 {24'b0,wb_dat_r} << {i_icb_cmd_addr[1:0],3'b0};
             

  assign wb_stb          = i_icb_cmd_valid;
  assign wb_cyc          = i_icb_cmd_valid;
  assign i_icb_cmd_ready = wb_ack;
  assign i_icb_rsp_valid = wb_ack;
  assign i_icb_rsp_rdata = wb_dat_r_remap;


  assign i_icb_rsp_err = 1'b0;

endmodule




