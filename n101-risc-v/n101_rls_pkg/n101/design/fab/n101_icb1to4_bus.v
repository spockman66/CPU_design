 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         





















module n101_icb1to4_bus # (
  parameter ALLOW_DIFF = 0, 
  parameter ALLOW_0CYCL_RSP = 0, 
  parameter ICB_FIFO_DP = 0, 
                             
                             
  parameter ICB_FIFO_CUT_READY = 1, 

  parameter AW = 32,
  parameter DW = 32,
  parameter SPLT_FIFO_OUTS_NUM    = 1,
  parameter SPLT_FIFO_OUTS_CNT_W  = 1,
  parameter SPLT_FIFO_CUT_READY   = 1,

  parameter O0_BASE_ADDR       = 32'h0000_1000,       
  parameter O0_BASE_REGION_LSB = 12,
  parameter O1_BASE_ADDR       = 32'h0000_2000,       
  parameter O1_BASE_REGION_LSB = 12, 
  parameter O2_BASE_ADDR       = 32'h0000_3000,       
  parameter O2_BASE_REGION_LSB = 12 
)(

  input                          i_icb_cmd_valid,
  output                         i_icb_cmd_ready,
  input  [             AW-1:0]   i_icb_cmd_addr, 
  input                          i_icb_cmd_read, 
  input  [3-1:0]                 i_icb_cmd_burst,
  input  [2-1:0]                 i_icb_cmd_beat,
  input  [        DW-1:0]        i_icb_cmd_wdata,
  input  [        DW/8-1:0]      i_icb_cmd_wmask,
  input                          i_icb_cmd_lock,
  input                          i_icb_cmd_excl,
  input  [1:0]                   i_icb_cmd_size,
  
  output                         i_icb_rsp_valid,
  input                          i_icb_rsp_ready,
  output                         i_icb_rsp_err  ,
  output                         i_icb_rsp_excl_ok,
  output [        DW-1:0]        i_icb_rsp_rdata,

  input                          o0_icb_enable,
  input                          o1_icb_enable,
  input                          o2_icb_enable,

  output                         o0_icb_cmd_valid,
  input                          o0_icb_cmd_ready,
  output [             AW-1:0]   o0_icb_cmd_addr, 
  output                         o0_icb_cmd_read, 
  output [3-1:0]                 o0_icb_cmd_burst,
  output [2-1:0]                 o0_icb_cmd_beat,
  output [        DW-1:0]        o0_icb_cmd_wdata,
  output [        DW/8-1:0]      o0_icb_cmd_wmask,
  output                         o0_icb_cmd_lock,
  output                         o0_icb_cmd_excl,
  output [1:0]                   o0_icb_cmd_size,
  
  input                          o0_icb_rsp_valid,
  output                         o0_icb_rsp_ready,
  input                          o0_icb_rsp_err  ,
  input                          o0_icb_rsp_excl_ok,
  input  [        DW-1:0]        o0_icb_rsp_rdata,

  output                         o1_icb_cmd_valid,
  input                          o1_icb_cmd_ready,
  output [             AW-1:0]   o1_icb_cmd_addr, 
  output                         o1_icb_cmd_read, 
  output [3-1:0]                 o1_icb_cmd_burst,
  output [2-1:0]                 o1_icb_cmd_beat,
  output [        DW-1:0]        o1_icb_cmd_wdata,
  output [        DW/8-1:0]      o1_icb_cmd_wmask,
  output                         o1_icb_cmd_lock,
  output                         o1_icb_cmd_excl,
  output [1:0]                   o1_icb_cmd_size,
  
  input                          o1_icb_rsp_valid,
  output                         o1_icb_rsp_ready,
  input                          o1_icb_rsp_err  ,
  input                          o1_icb_rsp_excl_ok,
  input  [        DW-1:0]        o1_icb_rsp_rdata,


  output                         o2_icb_cmd_valid,
  input                          o2_icb_cmd_ready,
  output [             AW-1:0]   o2_icb_cmd_addr, 
  output                         o2_icb_cmd_read, 
  output [3-1:0]                 o2_icb_cmd_burst,
  output [2-1:0]                 o2_icb_cmd_beat,
  output [        DW-1:0]        o2_icb_cmd_wdata,
  output [        DW/8-1:0]      o2_icb_cmd_wmask,
  output                         o2_icb_cmd_lock,
  output                         o2_icb_cmd_excl,
  output [1:0]                   o2_icb_cmd_size,
  
  input                          o2_icb_rsp_valid,
  output                         o2_icb_rsp_ready,
  input                          o2_icb_rsp_err  ,
  input                          o2_icb_rsp_excl_ok,
  input  [        DW-1:0]        o2_icb_rsp_rdata,

  output                         o3_icb_cmd_valid,
  input                          o3_icb_cmd_ready,
  output [             AW-1:0]   o3_icb_cmd_addr, 
  output                         o3_icb_cmd_read, 
  output [3-1:0]                 o3_icb_cmd_burst,
  output [2-1:0]                 o3_icb_cmd_beat,
  output [        DW-1:0]        o3_icb_cmd_wdata,
  output [        DW/8-1:0]      o3_icb_cmd_wmask,
  output                         o3_icb_cmd_lock,
  output                         o3_icb_cmd_excl,
  output [1:0]                   o3_icb_cmd_size,
  
  input                          o3_icb_rsp_valid,
  output                         o3_icb_rsp_ready,
  input                          o3_icb_rsp_err  ,
  input                          o3_icb_rsp_excl_ok,
  input  [        DW-1:0]        o3_icb_rsp_rdata,
  input  clk,
  input  rst_n
  );

  wire                         buf_icb_cmd_valid;
  wire                         buf_icb_cmd_ready;
  wire [             AW-1:0]   buf_icb_cmd_addr; 
  wire                         buf_icb_cmd_read; 
  wire [3-1:0]                 buf_icb_cmd_burst;
  wire [2-1:0]                 buf_icb_cmd_beat;
  wire [        DW-1:0]        buf_icb_cmd_wdata;
  wire [        DW/8-1:0]      buf_icb_cmd_wmask;
  wire                         buf_icb_cmd_lock;
  wire                         buf_icb_cmd_excl;
  wire [1:0]                   buf_icb_cmd_size;
  
  wire                         buf_icb_rsp_valid;
  wire                         buf_icb_rsp_ready;
  wire                         buf_icb_rsp_err  ;
  wire                         buf_icb_rsp_excl_ok;
  wire [        DW-1:0]        buf_icb_rsp_rdata;

  n101_gnrl_icb_buffer # (
    .OUTS_CNT_W   (SPLT_FIFO_OUTS_CNT_W),
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
    .i_icb_cmd_valid        (i_icb_cmd_valid),
    .i_icb_cmd_ready        (i_icb_cmd_ready),
    .i_icb_cmd_read         (i_icb_cmd_read ),
    .i_icb_cmd_addr         (i_icb_cmd_addr ),
    .i_icb_cmd_wdata        (i_icb_cmd_wdata),
    .i_icb_cmd_wmask        (i_icb_cmd_wmask),
    .i_icb_cmd_lock         (i_icb_cmd_lock ),
    .i_icb_cmd_excl         (i_icb_cmd_excl ),
    .i_icb_cmd_size         (i_icb_cmd_size ),
    .i_icb_cmd_burst        (i_icb_cmd_burst),
    .i_icb_cmd_beat         (i_icb_cmd_beat ),
    .i_icb_cmd_usr          (1'b0  ),
                     
    .i_icb_rsp_valid        (i_icb_rsp_valid),
    .i_icb_rsp_ready        (i_icb_rsp_ready),
    .i_icb_rsp_err          (i_icb_rsp_err  ),
    .i_icb_rsp_excl_ok      (i_icb_rsp_excl_ok),
    .i_icb_rsp_rdata        (i_icb_rsp_rdata),
    .i_icb_rsp_usr          (),
    
    .o_icb_cmd_valid        (buf_icb_cmd_valid),
    .o_icb_cmd_ready        (buf_icb_cmd_ready),
    .o_icb_cmd_read         (buf_icb_cmd_read ),
    .o_icb_cmd_addr         (buf_icb_cmd_addr ),
    .o_icb_cmd_wdata        (buf_icb_cmd_wdata),
    .o_icb_cmd_wmask        (buf_icb_cmd_wmask),
    .o_icb_cmd_lock         (buf_icb_cmd_lock ),
    .o_icb_cmd_excl         (buf_icb_cmd_excl ),
    .o_icb_cmd_size         (buf_icb_cmd_size ),
    .o_icb_cmd_burst        (buf_icb_cmd_burst),
    .o_icb_cmd_beat         (buf_icb_cmd_beat ),
    .o_icb_cmd_usr          (),
                         
    .o_icb_rsp_valid        (buf_icb_rsp_valid),
    .o_icb_rsp_ready        (buf_icb_rsp_ready),
    .o_icb_rsp_err          (buf_icb_rsp_err  ),
    .o_icb_rsp_excl_ok      (buf_icb_rsp_excl_ok),
    .o_icb_rsp_rdata        (buf_icb_rsp_rdata),
    .o_icb_rsp_usr          (1'b0  ),

    .clk                    (clk  ),
    .rst_n                  (rst_n)
  );



  localparam BASE_REGION_MSB = (AW-1);
  localparam SPLT_I_NUM = 4;


  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_valid;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_ready;
  wire [SPLT_I_NUM*             AW-1:0] splt_bus_icb_cmd_addr;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_read;
  wire [SPLT_I_NUM*3-1:0] splt_bus_icb_cmd_burst;
  wire [SPLT_I_NUM*2-1:0] splt_bus_icb_cmd_beat;
  wire [SPLT_I_NUM*        DW-1:0] splt_bus_icb_cmd_wdata;
  wire [SPLT_I_NUM*        DW/8-1:0] splt_bus_icb_cmd_wmask;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_lock;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_cmd_excl;
  wire [SPLT_I_NUM*2-1:0] splt_bus_icb_cmd_size;

  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_valid;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_ready;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_err;
  wire [SPLT_I_NUM*1-1:0] splt_bus_icb_rsp_excl_ok;
  wire [SPLT_I_NUM*        DW-1:0] splt_bus_icb_rsp_rdata;

  
  assign {
                             o0_icb_cmd_valid
                           , o1_icb_cmd_valid
                           , o2_icb_cmd_valid
                           , o3_icb_cmd_valid
                           } = splt_bus_icb_cmd_valid;

  assign {
                             o0_icb_cmd_addr
                           , o1_icb_cmd_addr
                           , o2_icb_cmd_addr
                           , o3_icb_cmd_addr
                           } = splt_bus_icb_cmd_addr;

  assign {
                             o0_icb_cmd_read
                           , o1_icb_cmd_read
                           , o2_icb_cmd_read
                           , o3_icb_cmd_read
                           } = splt_bus_icb_cmd_read;

  assign {
                             o0_icb_cmd_burst
                           , o1_icb_cmd_burst
                           , o2_icb_cmd_burst
                           , o3_icb_cmd_burst
                           } = splt_bus_icb_cmd_burst;

  assign {
                             o0_icb_cmd_beat
                           , o1_icb_cmd_beat
                           , o2_icb_cmd_beat
                           , o3_icb_cmd_beat
                           } = splt_bus_icb_cmd_beat;

  assign {
                             o0_icb_cmd_wdata
                           , o1_icb_cmd_wdata
                           , o2_icb_cmd_wdata
                           , o3_icb_cmd_wdata
                           } = splt_bus_icb_cmd_wdata;

  assign {
                             o0_icb_cmd_wmask
                           , o1_icb_cmd_wmask
                           , o2_icb_cmd_wmask
                           , o3_icb_cmd_wmask
                           } = splt_bus_icb_cmd_wmask;
                         
  assign {
                             o0_icb_cmd_lock
                           , o1_icb_cmd_lock
                           , o2_icb_cmd_lock
                           , o3_icb_cmd_lock
                           } = splt_bus_icb_cmd_lock;

  assign {
                             o0_icb_cmd_excl
                           , o1_icb_cmd_excl
                           , o2_icb_cmd_excl
                           , o3_icb_cmd_excl
                           } = splt_bus_icb_cmd_excl;
                           
  assign {
                             o0_icb_cmd_size
                           , o1_icb_cmd_size
                           , o2_icb_cmd_size
                           , o3_icb_cmd_size
                           } = splt_bus_icb_cmd_size;

  assign splt_bus_icb_cmd_ready = {
                             o0_icb_cmd_ready
                           , o1_icb_cmd_ready
                           , o2_icb_cmd_ready
                           , o3_icb_cmd_ready
                           };

  
  assign splt_bus_icb_rsp_valid = {
                             o0_icb_rsp_valid
                           , o1_icb_rsp_valid
                           , o2_icb_rsp_valid
                           , o3_icb_rsp_valid
                           };

  assign splt_bus_icb_rsp_err = {
                             o0_icb_rsp_err
                           , o1_icb_rsp_err
                           , o2_icb_rsp_err
                           , o3_icb_rsp_err
                           };

  assign splt_bus_icb_rsp_excl_ok = {
                             o0_icb_rsp_excl_ok
                           , o1_icb_rsp_excl_ok
                           , o2_icb_rsp_excl_ok
                           , o3_icb_rsp_excl_ok
                           };

  assign splt_bus_icb_rsp_rdata = {
                             o0_icb_rsp_rdata
                           , o1_icb_rsp_rdata
                           , o2_icb_rsp_rdata
                           , o3_icb_rsp_rdata
                           };

  assign {
                             o0_icb_rsp_ready
                           , o1_icb_rsp_ready
                           , o2_icb_rsp_ready
                           , o3_icb_rsp_ready
                           } = splt_bus_icb_rsp_ready;

  wire icb_cmd_o0 = o0_icb_enable & (buf_icb_cmd_addr     [BASE_REGION_MSB:O0_BASE_REGION_LSB] 
                     ==  O0_BASE_ADDR [BASE_REGION_MSB:O0_BASE_REGION_LSB] 
                    );

  wire icb_cmd_o1 = o1_icb_enable & (buf_icb_cmd_addr     [BASE_REGION_MSB:O1_BASE_REGION_LSB] 
                     ==  O1_BASE_ADDR [BASE_REGION_MSB:O1_BASE_REGION_LSB] 
                    );

  wire icb_cmd_o2 = o2_icb_enable & (buf_icb_cmd_addr     [BASE_REGION_MSB:O2_BASE_REGION_LSB] 
                     ==  O2_BASE_ADDR [BASE_REGION_MSB:O2_BASE_REGION_LSB] 
                    );

  wire icb_cmd_o3 = (~icb_cmd_o0) & (~icb_cmd_o1) & (~icb_cmd_o2);
                     
  wire [SPLT_I_NUM-1:0] buf_icb_splt_indic = 
      {
                      icb_cmd_o0
                    , icb_cmd_o1
                    , icb_cmd_o2
                    , icb_cmd_o3
      };

  n101_gnrl_icb_splt # (
  .ALLOW_DIFF (ALLOW_DIFF),
  .ALLOW_0CYCL_RSP (ALLOW_0CYCL_RSP),
  .FIFO_OUTS_NUM   (SPLT_FIFO_OUTS_NUM ),
  .FIFO_CUT_READY  (SPLT_FIFO_CUT_READY),
  .SPLT_NUM   (SPLT_I_NUM),
  .SPLT_PTR_W (SPLT_I_NUM),
  .SPLT_PTR_1HOT (1),
  .VLD_MSK_PAYLOAD(1),
  .USR_W      (1),
  .AW         (AW),
  .DW         (DW) 
  ) u_i_icb_splt(
  .i_icb_splt_indic       (buf_icb_splt_indic),        

  .i_icb_cmd_valid        (buf_icb_cmd_valid )     ,
  .i_icb_cmd_ready        (buf_icb_cmd_ready )     ,
  .i_icb_cmd_read         (buf_icb_cmd_read )      ,
  .i_icb_cmd_addr         (buf_icb_cmd_addr )      ,
  .i_icb_cmd_wdata        (buf_icb_cmd_wdata )     ,
  .i_icb_cmd_wmask        (buf_icb_cmd_wmask)      ,
  .i_icb_cmd_burst        (buf_icb_cmd_burst)     ,
  .i_icb_cmd_beat         (buf_icb_cmd_beat )     ,
  .i_icb_cmd_excl         (buf_icb_cmd_excl )     ,
  .i_icb_cmd_lock         (buf_icb_cmd_lock )     ,
  .i_icb_cmd_size         (buf_icb_cmd_size )     ,
  .i_icb_cmd_usr          (1'b0)     ,
 
  .i_icb_rsp_valid        (buf_icb_rsp_valid )     ,
  .i_icb_rsp_ready        (buf_icb_rsp_ready )     ,
  .i_icb_rsp_err          (buf_icb_rsp_err)        ,
  .i_icb_rsp_excl_ok      (buf_icb_rsp_excl_ok)    ,
  .i_icb_rsp_rdata        (buf_icb_rsp_rdata )     ,
  .i_icb_rsp_usr          ( )     ,
                               
  .o_bus_icb_cmd_ready    (splt_bus_icb_cmd_ready ) ,
  .o_bus_icb_cmd_valid    (splt_bus_icb_cmd_valid ) ,
  .o_bus_icb_cmd_read     (splt_bus_icb_cmd_read )  ,
  .o_bus_icb_cmd_addr     (splt_bus_icb_cmd_addr )  ,
  .o_bus_icb_cmd_wdata    (splt_bus_icb_cmd_wdata ) ,
  .o_bus_icb_cmd_wmask    (splt_bus_icb_cmd_wmask)  ,
  .o_bus_icb_cmd_burst    (splt_bus_icb_cmd_burst),
  .o_bus_icb_cmd_beat     (splt_bus_icb_cmd_beat ),
  .o_bus_icb_cmd_excl     (splt_bus_icb_cmd_excl ),
  .o_bus_icb_cmd_lock     (splt_bus_icb_cmd_lock ),
  .o_bus_icb_cmd_size     (splt_bus_icb_cmd_size ),
  .o_bus_icb_cmd_usr      ()     ,
  
  .o_bus_icb_rsp_valid    (splt_bus_icb_rsp_valid ) ,
  .o_bus_icb_rsp_ready    (splt_bus_icb_rsp_ready ) ,
  .o_bus_icb_rsp_err      (splt_bus_icb_rsp_err)    ,
  .o_bus_icb_rsp_excl_ok  (splt_bus_icb_rsp_excl_ok),
  .o_bus_icb_rsp_rdata    (splt_bus_icb_rsp_rdata ) ,
  .o_bus_icb_rsp_usr      ({SPLT_I_NUM{1'b0}}) ,
                             
  .clk                    (clk  )                     ,
  .rst_n                  (rst_n)
  );


endmodule



