 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















module n101_icb2to1_bus # (
  parameter ICB_FIFO_DP = 0, 
                             
                             
  parameter ICB_FIFO_CUT_READY = 1, 

  parameter AW = 32,
  parameter DW = 32,
  parameter ARBT_FIFO_OUTS_NUM    = 1,
  parameter ARBT_FIFO_OUTS_CNT_W  = 1,
  parameter ARBT_FIFO_CUT_READY   = 1,
  parameter ARBT_SCHEME = 0,
  parameter ARBT_ALLOW_0CYCL_RSP = 0

)(

  output                         o_icb_cmd_valid,
  input                          o_icb_cmd_ready,
  output [             AW-1:0]   o_icb_cmd_addr, 
  output                         o_icb_cmd_read, 
  output [3-1:0]                 o_icb_cmd_burst,
  output [2-1:0]                 o_icb_cmd_beat,
  output [        DW-1:0]        o_icb_cmd_wdata,
  output [        DW/8-1:0]      o_icb_cmd_wmask,
  output                         o_icb_cmd_lock,
  output                         o_icb_cmd_excl,
  output [1:0]                   o_icb_cmd_size,
  
  input                          o_icb_rsp_valid,
  output                         o_icb_rsp_ready,
  input                          o_icb_rsp_err  ,
  input                          o_icb_rsp_excl_ok,
  input  [        DW-1:0]        o_icb_rsp_rdata,

  input                          i0_icb_cmd_valid,
  output                         i0_icb_cmd_ready,
  input  [             AW-1:0]   i0_icb_cmd_addr, 
  input                          i0_icb_cmd_read, 
  input  [3-1:0]                 i0_icb_cmd_burst,
  input  [2-1:0]                 i0_icb_cmd_beat,
  input  [        DW-1:0]        i0_icb_cmd_wdata,
  input  [        DW/8-1:0]      i0_icb_cmd_wmask,
  input                          i0_icb_cmd_lock,
  input                          i0_icb_cmd_excl,
  input  [1:0]                   i0_icb_cmd_size,
  
  output                         i0_icb_rsp_valid,
  input                          i0_icb_rsp_ready,
  output                         i0_icb_rsp_err  ,
  output                         i0_icb_rsp_excl_ok,
  output [        DW-1:0]        i0_icb_rsp_rdata,

  input                          i1_icb_cmd_valid,
  output                         i1_icb_cmd_ready,
  input  [             AW-1:0]   i1_icb_cmd_addr, 
  input                          i1_icb_cmd_read, 
  input  [3-1:0]                 i1_icb_cmd_burst,
  input  [2-1:0]                 i1_icb_cmd_beat,
  input  [        DW-1:0]        i1_icb_cmd_wdata,
  input  [        DW/8-1:0]      i1_icb_cmd_wmask,
  input                          i1_icb_cmd_lock,
  input                          i1_icb_cmd_excl,
  input  [1:0]                   i1_icb_cmd_size,
  
  output                         i1_icb_rsp_valid,
  input                          i1_icb_rsp_ready,
  output                         i1_icb_rsp_err  ,
  output                         i1_icb_rsp_excl_ok,
  output [        DW-1:0]        i1_icb_rsp_rdata,

  input  clk,
  input  rst_n
  );


  localparam ARBT_I_NUM   = 2;
  localparam ARBT_I_PTR_W = 1;

  wire arbt_icb_cmd_valid;
  wire arbt_icb_cmd_ready;
  wire [AW-1:0] arbt_icb_cmd_addr;
  wire arbt_icb_cmd_read;
  wire [DW-1:0] arbt_icb_cmd_wdata;
  wire [DW/8-1:0] arbt_icb_cmd_wmask;
  wire [2:0] arbt_icb_cmd_burst;
  wire [1:0] arbt_icb_cmd_beat;
  wire arbt_icb_cmd_lock;
  wire arbt_icb_cmd_excl;
  wire [1:0] arbt_icb_cmd_size;
  wire arbt_icb_cmd_usr;


  wire arbt_icb_rsp_valid;
  wire arbt_icb_rsp_ready;
  wire arbt_icb_rsp_err;
  wire arbt_icb_rsp_excl_ok;
  wire [DW-1:0] arbt_icb_rsp_rdata;

  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_valid;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_ready;
  wire [ARBT_I_NUM*AW-1:0] arbt_bus_icb_cmd_addr;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_read;
  wire [ARBT_I_NUM*DW-1:0] arbt_bus_icb_cmd_wdata;
  wire [ARBT_I_NUM*DW/8-1:0] arbt_bus_icb_cmd_wmask;
  wire [ARBT_I_NUM*3-1:0] arbt_bus_icb_cmd_burst;
  wire [ARBT_I_NUM*2-1:0] arbt_bus_icb_cmd_beat;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_lock;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_excl;
  wire [ARBT_I_NUM*2-1:0] arbt_bus_icb_cmd_size;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_cmd_usr;

  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_valid;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_ready;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_err;
  wire [ARBT_I_NUM*1-1:0] arbt_bus_icb_rsp_excl_ok;
  wire [ARBT_I_NUM*DW-1:0] arbt_bus_icb_rsp_rdata;

  
  assign arbt_bus_icb_cmd_valid =
                           {
                             i1_icb_cmd_valid,
                             i0_icb_cmd_valid
                           } ;

  assign arbt_bus_icb_cmd_addr =
                           {
                             i1_icb_cmd_addr,
                             i0_icb_cmd_addr
                           } ;

  assign arbt_bus_icb_cmd_read =
                           {
                             i1_icb_cmd_read,
                             i0_icb_cmd_read
                           } ;

  assign arbt_bus_icb_cmd_wdata =
                           {
                             i1_icb_cmd_wdata,
                             i0_icb_cmd_wdata
                           } ;

  assign arbt_bus_icb_cmd_wmask =
                           {
                             i1_icb_cmd_wmask,
                             i0_icb_cmd_wmask
                           } ;
                         
  assign arbt_bus_icb_cmd_burst =
                           {
                             i1_icb_cmd_burst,
                             i0_icb_cmd_burst
                           } ;
                         
  assign arbt_bus_icb_cmd_beat =
                           {
                             i1_icb_cmd_beat,
                             i0_icb_cmd_beat
                           } ;
                         
  assign arbt_bus_icb_cmd_lock =
                           {
                             i1_icb_cmd_lock,
                             i0_icb_cmd_lock
                           } ;

  assign arbt_bus_icb_cmd_excl =
                           {
                             i1_icb_cmd_excl,
                             i0_icb_cmd_excl
                           } ;
                           
  assign arbt_bus_icb_cmd_size =
                           {
                             i1_icb_cmd_size,
                             i0_icb_cmd_size
                           } ;

 wire i1_icb_cmd_ifu = 1'b1;
 wire i0_icb_cmd_ifu = 1'b0;
 assign arbt_bus_icb_cmd_usr =
                           {
                             i1_icb_cmd_ifu,
                             i0_icb_cmd_ifu
                           } ;

  assign                   {
                             i1_icb_cmd_ready,
                             i0_icb_cmd_ready
                           } = arbt_bus_icb_cmd_ready;

  
  assign                   {
                             i1_icb_rsp_valid,
                             i0_icb_rsp_valid
                           } = arbt_bus_icb_rsp_valid;

  assign                   {
                             i1_icb_rsp_err,
                             i0_icb_rsp_err
                           } = arbt_bus_icb_rsp_err;

  assign                   {
                             i1_icb_rsp_excl_ok,
                             i0_icb_rsp_excl_ok
                           } = arbt_bus_icb_rsp_excl_ok;
                           
  assign                   {
                             i1_icb_rsp_rdata,
                             i0_icb_rsp_rdata
                           } = arbt_bus_icb_rsp_rdata;

  assign arbt_bus_icb_rsp_ready = {
                             i1_icb_rsp_ready,
                             i0_icb_rsp_ready
                           };

  wire arbt_icb_active;

  n101_gnrl_icb_arbt # (
  .ARBT_SCHEME (ARBT_SCHEME),
  .ALLOW_BURST (1),
  .ALLOW_0CYCL_RSP (ARBT_ALLOW_0CYCL_RSP),
  .FIFO_OUTS_NUM   (ARBT_FIFO_OUTS_NUM),
  .FIFO_CUT_READY  (ARBT_FIFO_CUT_READY),
  .ARBT_NUM   (ARBT_I_NUM),
  .ARBT_PTR_W (ARBT_I_PTR_W),
  .USR_W      (1),
  .AW         (AW),
  .DW         (DW) 
  ) u_icb_arbt(
  .arbt_active            (arbt_icb_active )     ,

  .o_icb_cmd_valid        (arbt_icb_cmd_valid )     ,
  .o_icb_cmd_ready        (arbt_icb_cmd_ready )     ,
  .o_icb_cmd_read         (arbt_icb_cmd_read )      ,
  .o_icb_cmd_addr         (arbt_icb_cmd_addr )      ,
  .o_icb_cmd_wdata        (arbt_icb_cmd_wdata )     ,
  .o_icb_cmd_wmask        (arbt_icb_cmd_wmask)      ,
  .o_icb_cmd_burst        (arbt_icb_cmd_burst)     ,
  .o_icb_cmd_beat         (arbt_icb_cmd_beat )     ,
  .o_icb_cmd_excl         (arbt_icb_cmd_excl )     ,
  .o_icb_cmd_lock         (arbt_icb_cmd_lock )     ,
  .o_icb_cmd_size         (arbt_icb_cmd_size )     ,
  .o_icb_cmd_usr          (arbt_icb_cmd_usr  )     ,
                                
  .o_icb_rsp_valid        (arbt_icb_rsp_valid )     ,
  .o_icb_rsp_ready        (arbt_icb_rsp_ready )     ,
  .o_icb_rsp_err          (arbt_icb_rsp_err)        ,
  .o_icb_rsp_excl_ok      (arbt_icb_rsp_excl_ok)    ,
  .o_icb_rsp_rdata        (arbt_icb_rsp_rdata )     ,
  .o_icb_rsp_usr          (1'b0   )     ,
                               
  .i_bus_icb_cmd_sel_vec  ({ARBT_I_NUM{1'b0}}) ,

  .i_bus_icb_cmd_ready    (arbt_bus_icb_cmd_ready ) ,
  .i_bus_icb_cmd_valid    (arbt_bus_icb_cmd_valid ) ,
  .i_bus_icb_cmd_read     (arbt_bus_icb_cmd_read )  ,
  .i_bus_icb_cmd_addr     (arbt_bus_icb_cmd_addr )  ,
  .i_bus_icb_cmd_wdata    (arbt_bus_icb_cmd_wdata ) ,
  .i_bus_icb_cmd_wmask    (arbt_bus_icb_cmd_wmask)  ,
  .i_bus_icb_cmd_burst    (arbt_bus_icb_cmd_burst),
  .i_bus_icb_cmd_beat     (arbt_bus_icb_cmd_beat ),
  .i_bus_icb_cmd_excl     (arbt_bus_icb_cmd_excl ),
  .i_bus_icb_cmd_lock     (arbt_bus_icb_cmd_lock ),
  .i_bus_icb_cmd_size     (arbt_bus_icb_cmd_size ),
  .i_bus_icb_cmd_usr      (arbt_bus_icb_cmd_usr ),
                                
  .i_bus_icb_rsp_valid    (arbt_bus_icb_rsp_valid ) ,
  .i_bus_icb_rsp_ready    (arbt_bus_icb_rsp_ready ) ,
  .i_bus_icb_rsp_err      (arbt_bus_icb_rsp_err)    ,
  .i_bus_icb_rsp_excl_ok  (arbt_bus_icb_rsp_excl_ok),
  .i_bus_icb_rsp_rdata    (arbt_bus_icb_rsp_rdata ) ,
  .i_bus_icb_rsp_usr      () ,
                             
  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );


  n101_gnrl_icb_buffer # (
    .OUTS_CNT_W   (ARBT_FIFO_OUTS_CNT_W),
    .AW    (AW),
    .DW    (DW), 
    .CMD_DP(ICB_FIFO_DP),
    .RSP_DP(ICB_FIFO_DP),
    .CMD_CUT_READY (ICB_FIFO_CUT_READY),
    .RSP_CUT_READY (ICB_FIFO_CUT_READY),
    .USR_W (1)
  )u_n101_gnrl_icb_buffer(
      .bus_clk_en (1'b1),
    .icb_buffer_active      (),
    .i_icb_cmd_valid        (arbt_icb_cmd_valid),
    .i_icb_cmd_ready        (arbt_icb_cmd_ready),
    .i_icb_cmd_read         (arbt_icb_cmd_read ),
    .i_icb_cmd_addr         (arbt_icb_cmd_addr ),
    .i_icb_cmd_wdata        (arbt_icb_cmd_wdata),
    .i_icb_cmd_wmask        (arbt_icb_cmd_wmask),
    .i_icb_cmd_lock         (arbt_icb_cmd_lock ),
    .i_icb_cmd_excl         (arbt_icb_cmd_excl ),
    .i_icb_cmd_size         (arbt_icb_cmd_size ),
    .i_icb_cmd_burst        (arbt_icb_cmd_burst),
    .i_icb_cmd_beat         (arbt_icb_cmd_beat ),
    .i_icb_cmd_usr          (1'b0  ),
                     
    .i_icb_rsp_valid        (arbt_icb_rsp_valid),
    .i_icb_rsp_ready        (arbt_icb_rsp_ready),
    .i_icb_rsp_err          (arbt_icb_rsp_err  ),
    .i_icb_rsp_excl_ok      (arbt_icb_rsp_excl_ok),
    .i_icb_rsp_rdata        (arbt_icb_rsp_rdata),
    .i_icb_rsp_usr          (),
    
    .o_icb_cmd_valid        (o_icb_cmd_valid),
    .o_icb_cmd_ready        (o_icb_cmd_ready),
    .o_icb_cmd_read         (o_icb_cmd_read ),
    .o_icb_cmd_addr         (o_icb_cmd_addr ),
    .o_icb_cmd_wdata        (o_icb_cmd_wdata),
    .o_icb_cmd_wmask        (o_icb_cmd_wmask),
    .o_icb_cmd_lock         (o_icb_cmd_lock ),
    .o_icb_cmd_excl         (o_icb_cmd_excl ),
    .o_icb_cmd_size         (o_icb_cmd_size ),
    .o_icb_cmd_burst        (o_icb_cmd_burst),
    .o_icb_cmd_beat         (o_icb_cmd_beat ),
    .o_icb_cmd_usr          (),
                         
    .o_icb_rsp_valid        (o_icb_rsp_valid),
    .o_icb_rsp_ready        (o_icb_rsp_ready),
    .o_icb_rsp_err          (o_icb_rsp_err  ),
    .o_icb_rsp_excl_ok      (o_icb_rsp_excl_ok),
    .o_icb_rsp_rdata        (o_icb_rsp_rdata),
    .o_icb_rsp_usr          (1'b0  ),

    .clk                    (clk  ),
    .rst_n                  (rst_n)
  );

endmodule

