 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         

















`include "n101_defines.v"

module n101_subsys_excl(

  input                          icb_cmd_valid,
  output                         icb_cmd_ready,
  input  [`N101_ADDR_SIZE-1:0]   icb_cmd_addr, 
  input                          icb_cmd_read, 
  input  [`N101_XLEN-1:0]        icb_cmd_wdata,
  input  [`N101_XLEN/8-1:0]      icb_cmd_wmask,
  input                          icb_cmd_lock,
  input                          icb_cmd_excl,
  input  [1:0]                   icb_cmd_size,

  output                         icb_rsp_valid,
  input                          icb_rsp_ready,
  output                         icb_rsp_err  ,
  output                         icb_rsp_excl_ok  ,
  output [`N101_XLEN-1:0]        icb_rsp_rdata,

  output                         o_icb_cmd_valid,
  input                          o_icb_cmd_ready,
  output  [`N101_ADDR_SIZE-1:0]  o_icb_cmd_addr, 
  output                         o_icb_cmd_read, 
  output  [`N101_XLEN-1:0]       o_icb_cmd_wdata,
  output  [`N101_XLEN/8-1:0]     o_icb_cmd_wmask,
  output                         o_icb_cmd_lock,
  output  [1:0]                  o_icb_cmd_size,

  input                          o_icb_rsp_valid,
  output                         o_icb_rsp_ready,
  input                          o_icb_rsp_err  ,
  input  [`N101_XLEN-1:0]        o_icb_rsp_rdata,


  input  clk,
  input  rst_n
  );

  wire excl_fifo_wen = icb_cmd_valid & icb_cmd_ready;
  wire excl_fifo_ren = icb_rsp_valid & icb_rsp_ready;

       
  wire excl_flg_r;
  wire [`N101_ADDR_SIZE-1:0] excl_addr_r;
  wire icb_cmdaddr_eq_excladdr = (icb_cmd_addr == excl_addr_r);
  
  wire excl_flg_set = icb_cmd_valid & icb_cmd_ready & icb_cmd_read & icb_cmd_excl;
  
  
  wire excl_flg_clr = (icb_cmd_valid & icb_cmd_ready & (~icb_cmd_read) & icb_cmdaddr_eq_excladdr & excl_flg_r);
  wire excl_flg_ena = excl_flg_set | excl_flg_clr;
  wire excl_flg_nxt = excl_flg_set | (~excl_flg_clr);
  n101_gnrl_dfflr #(1) excl_flg_dffl (excl_flg_ena, excl_flg_nxt, excl_flg_r, clk, rst_n);
  
  
  wire excl_addr_ena = excl_flg_set;
  wire [`N101_ADDR_SIZE-1:0] excl_addr_nxt = icb_cmd_addr;
  n101_gnrl_dfflr #(`N101_ADDR_SIZE) excl_addr_dffl (excl_addr_ena, excl_addr_nxt, excl_addr_r, clk, rst_n);

  
  wire icb_cmd_scond = icb_cmd_excl & (~icb_cmd_read);
  wire icb_cmd_scond_true = icb_cmd_scond & icb_cmdaddr_eq_excladdr & excl_flg_r;

  assign o_icb_cmd_wmask = 
      (icb_cmd_scond & (~icb_cmd_scond_true)) ? {`N101_XLEN/8{1'b0}} : icb_cmd_wmask;



  wire icb_rsp_scond_true;

  assign icb_rsp_excl_ok = icb_rsp_scond_true;


  

  wire excl_fifo_i_ready;
  wire excl_fifo_i_valid = excl_fifo_wen;
  wire excl_fifo_o_valid;
  wire excl_fifo_o_ready = excl_fifo_ren;


  
  n101_gnrl_fifo # (
    .CUT_READY (0),
    .MSKO      (0),
    .DP  (2),
    .DW  (1)
  ) u_n101_excl_fifo (
    .i_vld  (excl_fifo_i_valid),
    .i_rdy  (excl_fifo_i_ready),
    .i_dat  (icb_cmd_scond_true ),
    .o_vld  (excl_fifo_o_valid),
    .o_rdy  (excl_fifo_o_ready),  
    .o_dat  (icb_rsp_scond_true ),  
    .clk  (clk),
    .rst_n(rst_n)
  );


  assign  icb_cmd_ready = o_icb_cmd_ready;

  assign  o_icb_cmd_valid = icb_cmd_valid; 
  assign  o_icb_cmd_addr  = icb_cmd_addr ; 
  assign  o_icb_cmd_read  = icb_cmd_read ; 
  assign  o_icb_cmd_wdata = icb_cmd_wdata; 
  
  assign  o_icb_cmd_lock  = icb_cmd_lock ;
  assign  o_icb_cmd_size  = icb_cmd_size ;

  assign icb_rsp_valid   = o_icb_rsp_valid  ; 
  assign icb_rsp_err     = o_icb_rsp_err    ;
  
  assign icb_rsp_rdata   = o_icb_rsp_rdata  ;

  assign o_icb_rsp_ready = icb_rsp_ready;

endmodule

