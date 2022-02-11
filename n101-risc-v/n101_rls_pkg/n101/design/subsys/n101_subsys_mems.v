 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















`include "n101_defines.v"
`include "n101_subsys_defines.v"


module n101_subsys_mems(
     
    `ifndef N101_TMR_PRIVATE 
  output  msip,
  output  mtip,
  input   mtime_toggle_a,
    `endif



      `ifdef N101_MEM_TYPE_ICB 
  input                          mem_icb_cmd_valid,
  output                         mem_icb_cmd_ready,
  input  [`N101_ADDR_SIZE-1:0]   mem_icb_cmd_addr, 
  input                          mem_icb_cmd_read, 
  input                          mem_icb_cmd_hlock, 
  input                          mem_icb_cmd_excl, 
  input  [`N101_XLEN-1:0]        mem_icb_cmd_wdata,
  input  [`N101_XLEN/8-1:0]      mem_icb_cmd_wmask,
  
  output                         mem_icb_rsp_valid,
  input                          mem_icb_rsp_ready,
  output                         mem_icb_rsp_err,
  output                         mem_icb_rsp_excl_ok,
  output [`N101_XLEN-1:0]        mem_icb_rsp_rdata,
      `endif

      `ifndef N101_D_SHARE_ILM 
     
  output                          biu2ilm_icb_cmd_valid,
  input                           biu2ilm_icb_cmd_ready,
  output  [`N101_ILM_ADDR_WIDTH-1:0]   biu2ilm_icb_cmd_addr, 
  output                          biu2ilm_icb_cmd_read, 
  output  [`N101_XLEN-1:0]        biu2ilm_icb_cmd_wdata,
  output  [`N101_XLEN/8-1:0]      biu2ilm_icb_cmd_wmask,
  
  input                           biu2ilm_icb_rsp_valid,
  output                          biu2ilm_icb_rsp_ready,
  input                           biu2ilm_icb_rsp_err,
  input   [`N101_XLEN-1:0]        biu2ilm_icb_rsp_rdata,
     
      `endif
     

  output                          biu2dlm_icb_cmd_valid,
  input                           biu2dlm_icb_cmd_ready,
  output  [`N101_DLM_ADDR_WIDTH-1:0]   biu2dlm_icb_cmd_addr, 
  output                          biu2dlm_icb_cmd_read, 
  output  [`N101_XLEN-1:0]        biu2dlm_icb_cmd_wdata,
  output  [`N101_XLEN/8-1:0]      biu2dlm_icb_cmd_wmask,
  
  input                           biu2dlm_icb_rsp_valid,
  output                          biu2dlm_icb_rsp_ready,
  input                           biu2dlm_icb_rsp_err,
  input   [`N101_XLEN-1:0]        biu2dlm_icb_rsp_rdata,


     
      `ifdef N101_MEM_TYPE_AHBL 
     
  input  [1:0]                     mem_ahbl_htrans,   
  input                            mem_ahbl_hwrite,   
  input  [`N101_ADDR_SIZE    -1:0] mem_ahbl_haddr,    
  input  [1:0]                     mem_ahbl_hsize,    
  input                            mem_ahbl_hlock,   
  input                            mem_ahbl_hexcl,   
  input  [2:0]                     mem_ahbl_hburst,   
  input  [`N101_XLEN    -1:0]      mem_ahbl_hwdata,   
  output [`N101_XLEN    -1:0]      mem_ahbl_hrdata,   
  output [1:0]                     mem_ahbl_hresp,    
  output                           mem_ahbl_hresp_exok,    
  output                           mem_ahbl_hready,   
     
      `endif
     

  
    
  output                         qspi0_ro_icb_cmd_valid,
  input                          qspi0_ro_icb_cmd_ready,
  output [`N101_ADDR_SIZE-1:0]   qspi0_ro_icb_cmd_addr, 
  output                         qspi0_ro_icb_cmd_read, 
  output [`N101_XLEN-1:0]        qspi0_ro_icb_cmd_wdata,
  
  input                          qspi0_ro_icb_rsp_valid,
  output                         qspi0_ro_icb_rsp_ready,
  input                          qspi0_ro_icb_rsp_err,
  input  [`N101_XLEN-1:0]        qspi0_ro_icb_rsp_rdata,


     
  `ifndef N101_HAS_PPI 
     
  
  output                         biu2ppi_icb_cmd_valid,
  input                          biu2ppi_icb_cmd_ready,
  output [`N101_ADDR_SIZE-1:0]   biu2ppi_icb_cmd_addr, 
  output                         biu2ppi_icb_cmd_read, 
  output [`N101_XLEN-1:0]        biu2ppi_icb_cmd_wdata,
  output [`N101_XLEN/8-1:0]      biu2ppi_icb_cmd_wmask,
  
  input                          biu2ppi_icb_rsp_valid,
  output                         biu2ppi_icb_rsp_ready,
  input                          biu2ppi_icb_rsp_err,
  input  [`N101_XLEN-1:0]        biu2ppi_icb_rsp_rdata,
     
  `endif
     

  input  clk,
  input  bus_rst_n,
  input  rst_n
  );

     
      `ifdef N101_MEM_TYPE_AHBL 
     
  wire                         mem_icb_cmd_valid;
  wire                         mem_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   mem_icb_cmd_addr; 
  wire                         mem_icb_cmd_read; 
  wire                         mem_icb_cmd_excl; 
  wire [`N101_XLEN-1:0]        mem_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      mem_icb_cmd_wmask;
  
  wire                         mem_icb_rsp_valid;
  wire                         mem_icb_rsp_ready;
  wire                         mem_icb_rsp_err;
  wire                         mem_icb_rsp_excl_ok;
  wire [`N101_XLEN-1:0]        mem_icb_rsp_rdata;

  n101_gnrl_ahbl2icb #(
    .AW(`N101_ADDR_SIZE),
    .DW(`N101_XLEN)
    ) u_mems_ahbl2icb (
      
    .ahbl2icb_active (),

    .ahbl_hsel       (1'b1      ),    
    .ahbl_htrans     (mem_ahbl_htrans    ),
    .ahbl_hwrite     (mem_ahbl_hwrite    ),
    .ahbl_haddr      (mem_ahbl_haddr     ),
    .ahbl_hsize      ({1'b0,mem_ahbl_hsize}     ),
    .ahbl_hexcl      (mem_ahbl_hexcl     ),
    .ahbl_hwdata     (mem_ahbl_hwdata    ),
	.ahbl_huser      (1'b0),
                      
    .ahbl_hrdata     (mem_ahbl_hrdata    ),
    .ahbl_hresp      (mem_ahbl_hresp     ),
    .ahbl_hresp_exok (mem_ahbl_hresp_exok),
    .ahbl_hready_in  (mem_ahbl_hready),  
    .ahbl_hready_out (mem_ahbl_hready),   

    .icb_cmd_valid (mem_icb_cmd_valid),
    .icb_cmd_ready (mem_icb_cmd_ready),
    .icb_cmd_read  (mem_icb_cmd_read ),
    .icb_cmd_excl  (mem_icb_cmd_excl ),
    .icb_cmd_addr  (mem_icb_cmd_addr ),
    .icb_cmd_wdata (mem_icb_cmd_wdata),
    .icb_cmd_wmask (mem_icb_cmd_wmask),
    .icb_cmd_size  (),
    .icb_cmd_sel   (),
	.icb_cmd_user  (),

    .icb_rsp_valid (mem_icb_rsp_valid),
    .icb_rsp_ready (mem_icb_rsp_ready),
    .icb_rsp_err   (mem_icb_rsp_err  ),
    .icb_rsp_excl_ok   (mem_icb_rsp_excl_ok  ),
    .icb_rsp_rdata (mem_icb_rsp_rdata),
       
    .clk           (clk  ),
    .rst_n         (bus_rst_n) 
  );


     
      `endif
     

  wire                         excl_mem_icb_cmd_valid;
  wire                         excl_mem_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   excl_mem_icb_cmd_addr; 
  wire                         excl_mem_icb_cmd_read; 
  wire [`N101_XLEN-1:0]        excl_mem_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      excl_mem_icb_cmd_wmask;
  
  wire                         excl_mem_icb_rsp_valid;
  wire                         excl_mem_icb_rsp_ready;
  wire                         excl_mem_icb_rsp_err;
  wire [`N101_XLEN-1:0]        excl_mem_icb_rsp_rdata;


  n101_subsys_excl u_n101_subsys_excl(
    .icb_cmd_valid   (mem_icb_cmd_valid  ),
    .icb_cmd_ready   (mem_icb_cmd_ready  ),
    .icb_cmd_addr    (mem_icb_cmd_addr   ),
    .icb_cmd_read    (mem_icb_cmd_read   ),
    .icb_cmd_wdata   (mem_icb_cmd_wdata  ),
    .icb_cmd_wmask   (mem_icb_cmd_wmask  ),
    .icb_cmd_lock    (1'b0   ),
    .icb_cmd_excl    (mem_icb_cmd_excl   ),
    .icb_cmd_size    (2'b10   ),
                      
    .icb_rsp_valid   (mem_icb_rsp_valid  ),
    .icb_rsp_ready   (mem_icb_rsp_ready  ),
    .icb_rsp_err     (mem_icb_rsp_err    ),
    .icb_rsp_excl_ok (mem_icb_rsp_excl_ok),
    .icb_rsp_rdata   (mem_icb_rsp_rdata  ),
                  
    .o_icb_cmd_valid (excl_mem_icb_cmd_valid ),
    .o_icb_cmd_ready (excl_mem_icb_cmd_ready ),
    .o_icb_cmd_addr  (excl_mem_icb_cmd_addr  ),
    .o_icb_cmd_read  (excl_mem_icb_cmd_read  ),
    .o_icb_cmd_wdata (excl_mem_icb_cmd_wdata ),
    .o_icb_cmd_wmask (excl_mem_icb_cmd_wmask ),
    .o_icb_cmd_lock  (),
    .o_icb_cmd_size  (),
                      
    .o_icb_rsp_valid (excl_mem_icb_rsp_valid ),
    .o_icb_rsp_ready (excl_mem_icb_rsp_ready ),
    .o_icb_rsp_err   (excl_mem_icb_rsp_err   ),
    .o_icb_rsp_rdata (excl_mem_icb_rsp_rdata ),


    .clk               (clk  ),
    .rst_n             (rst_n) 
  );

     
      `ifndef N101_TMR_PRIVATE 
  wire                          biu2tmr_icb_cmd_valid;
  wire                          biu2tmr_icb_cmd_ready;
  wire  [`N101_ADDR_SIZE-1:0]   biu2tmr_icb_cmd_addr; 
  wire                          biu2tmr_icb_cmd_read; 
  wire  [`N101_XLEN-1:0]        biu2tmr_icb_cmd_wdata;
  wire  [`N101_XLEN/8-1:0]      biu2tmr_icb_cmd_wmask;
  wire                          biu2tmr_icb_rsp_valid;
  wire                          biu2tmr_icb_rsp_ready;
  wire                          biu2tmr_icb_rsp_err;
  wire  [`N101_XLEN-1:0]        biu2tmr_icb_rsp_rdata;
      `endif
     


     
      `ifndef N101_HAS_DEBUG_PRIVATE 
  wire                          biu2dm_icb_cmd_valid;
  wire                          biu2dm_icb_cmd_ready = 1'b0;
  wire  [`N101_ADDR_SIZE-1:0]   biu2dm_icb_cmd_addr; 
  wire                          biu2dm_icb_cmd_read; 
  wire  [`N101_XLEN-1:0]        biu2dm_icb_cmd_wdata;
  wire  [`N101_XLEN/8-1:0]      biu2dm_icb_cmd_wmask;
  wire                          biu2dm_icb_rsp_valid = 1'b0;
  wire                          biu2dm_icb_rsp_ready;
  wire                          biu2dm_icb_rsp_err   = 1'b0;
  wire  [`N101_XLEN-1:0]        biu2dm_icb_rsp_rdata = 32'b0;
      `endif
     



  wire                         i_mem_icb_cmd_valid;
  wire                         i_mem_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   i_mem_icb_cmd_addr; 
  wire                         i_mem_icb_cmd_read; 
  wire [`N101_XLEN-1:0]        i_mem_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      i_mem_icb_cmd_wmask;
  
  wire                         i_mem_icb_rsp_valid;
  wire                         i_mem_icb_rsp_ready;
  wire                         i_mem_icb_rsp_err;
  wire [`N101_XLEN-1:0]        i_mem_icb_rsp_rdata;

  wire [`N101_ADDR_SIZE-1:0] biu2dlm_icb_cmd_addr_raw;

  assign biu2dlm_icb_cmd_addr = biu2dlm_icb_cmd_addr_raw[`N101_DLM_ADDR_WIDTH-1:0];

     
      `ifndef N101_D_SHARE_ILM 
     
  wire [`N101_ADDR_SIZE-1:0] biu2ilm_icb_cmd_addr_raw;
  assign biu2ilm_icb_cmd_addr = biu2ilm_icb_cmd_addr_raw[`N101_ILM_ADDR_WIDTH-1:0];
     
      `endif
     

  n101_icb1to6_bus # (
      .ALLOW_DIFF         (1),
      .ALLOW_0CYCL_RSP    (0),
      .ICB_FIFO_DP        (0),
      .ICB_FIFO_CUT_READY (0),
      
      .SPLT_FIFO_OUTS_NUM   (2),
      .SPLT_FIFO_OUTS_CNT_W (2),
      .SPLT_FIFO_CUT_READY  (1),
      .O0_BASE_ADDR       (`N101_CFG_ILM_BASE_ADDR),       
      .O0_BASE_REGION_LSB (`N101_ILM_ADDR_WIDTH), 
      .O1_BASE_ADDR       (`N101_CFG_DLM_BASE_ADDR),       
      .O1_BASE_REGION_LSB (`N101_DLM_ADDR_WIDTH),
      .O2_BASE_ADDR       (`N101_CFG_TMR_BASE_ADDR),
      .O2_BASE_REGION_LSB (8),
      .O3_BASE_ADDR       (`N101_ADDR_SIZE'b0),
      .O3_BASE_REGION_LSB (13),
      .O4_BASE_ADDR       (`N101_CFG_DEBUG_BASE_ADDR),
      .O4_BASE_REGION_LSB (12),
      .AW                 (`N101_ADDR_SIZE),
      .DW                 (`N101_XLEN) 
  )u_ilm_1to6_icb(

    .i_icb_cmd_valid  (excl_mem_icb_cmd_valid),
    .i_icb_cmd_ready  (excl_mem_icb_cmd_ready),
    .i_icb_cmd_addr   (excl_mem_icb_cmd_addr ),
    .i_icb_cmd_read   (excl_mem_icb_cmd_read ),
    .i_icb_cmd_wdata  (excl_mem_icb_cmd_wdata),
    .i_icb_cmd_wmask  (excl_mem_icb_cmd_wmask),
    .i_icb_cmd_lock   (1'b0),
    .i_icb_cmd_excl   (1'b0 ),
    .i_icb_cmd_size   (2'b0 ),
    .i_icb_cmd_burst  (3'b0 ),
    .i_icb_cmd_beat   (2'b0 ),
    
    .i_icb_rsp_valid  (excl_mem_icb_rsp_valid),
    .i_icb_rsp_ready  (excl_mem_icb_rsp_ready),
    .i_icb_rsp_err    (excl_mem_icb_rsp_err),
    .i_icb_rsp_excl_ok(),
    .i_icb_rsp_rdata  (excl_mem_icb_rsp_rdata),
    
        
     
  `ifndef N101_D_SHARE_ILM 
     
    .o0_icb_enable     (1'b1),

    .o0_icb_cmd_valid  (biu2ilm_icb_cmd_valid),
    .o0_icb_cmd_ready  (biu2ilm_icb_cmd_ready),
    .o0_icb_cmd_addr   (biu2ilm_icb_cmd_addr_raw),
    .o0_icb_cmd_read   (biu2ilm_icb_cmd_read ),
    .o0_icb_cmd_wdata  (biu2ilm_icb_cmd_wdata),
    .o0_icb_cmd_wmask  (biu2ilm_icb_cmd_wmask),
    .o0_icb_cmd_lock   (),
    .o0_icb_cmd_excl   (),
    .o0_icb_cmd_size   (),
    .o0_icb_cmd_burst  (),
    .o0_icb_cmd_beat   (),
    
    .o0_icb_rsp_valid  (biu2ilm_icb_rsp_valid),
    .o0_icb_rsp_ready  (biu2ilm_icb_rsp_ready),
    .o0_icb_rsp_err    (biu2ilm_icb_rsp_err),
    .o0_icb_rsp_excl_ok(1'b0  ),
    .o0_icb_rsp_rdata  (biu2ilm_icb_rsp_rdata),
     
  `else
    .o0_icb_enable     (1'b0),

    .o0_icb_cmd_valid  (),
    .o0_icb_cmd_ready  (1'b0),
    .o0_icb_cmd_addr   (),
    .o0_icb_cmd_read   (),
    .o0_icb_cmd_wdata  (),
    .o0_icb_cmd_wmask  (),
    .o0_icb_cmd_lock   (),
    .o0_icb_cmd_excl   (),
    .o0_icb_cmd_size   (),
    .o0_icb_cmd_burst  (),
    .o0_icb_cmd_beat   (),
    
    .o0_icb_rsp_valid  (1'b0),
    .o0_icb_rsp_ready  (),
    .o0_icb_rsp_err    (1'b0),
    .o0_icb_rsp_excl_ok(1'b0  ),
    .o0_icb_rsp_rdata  (32'b0),

  `endif
     

          
    .o1_icb_enable     (1'b1),

    .o1_icb_cmd_valid  (biu2dlm_icb_cmd_valid),
    .o1_icb_cmd_ready  (biu2dlm_icb_cmd_ready),
    .o1_icb_cmd_addr   (biu2dlm_icb_cmd_addr_raw),
    .o1_icb_cmd_read   (biu2dlm_icb_cmd_read ),
    .o1_icb_cmd_wdata  (biu2dlm_icb_cmd_wdata),
    .o1_icb_cmd_wmask  (biu2dlm_icb_cmd_wmask),
    .o1_icb_cmd_lock   (),
    .o1_icb_cmd_excl   (),
    .o1_icb_cmd_size   (),
    .o1_icb_cmd_burst  (),
    .o1_icb_cmd_beat   (),
    
    .o1_icb_rsp_valid  (biu2dlm_icb_rsp_valid),
    .o1_icb_rsp_ready  (biu2dlm_icb_rsp_ready),
    .o1_icb_rsp_err    (biu2dlm_icb_rsp_err),
    .o1_icb_rsp_excl_ok(1'b0  ),
    .o1_icb_rsp_rdata  (biu2dlm_icb_rsp_rdata),

     
      `ifndef N101_TMR_PRIVATE 
         
    .o2_icb_enable     (1'b1),

    .o2_icb_cmd_valid  (biu2tmr_icb_cmd_valid),
    .o2_icb_cmd_ready  (biu2tmr_icb_cmd_ready),
    .o2_icb_cmd_addr   (biu2tmr_icb_cmd_addr ),
    .o2_icb_cmd_read   (biu2tmr_icb_cmd_read ),
    .o2_icb_cmd_wdata  (biu2tmr_icb_cmd_wdata),
    .o2_icb_cmd_wmask  (biu2tmr_icb_cmd_wmask),
    .o2_icb_cmd_lock   (),
    .o2_icb_cmd_excl   (),
    .o2_icb_cmd_size   (),
    .o2_icb_cmd_burst  (),
    .o2_icb_cmd_beat   (),
    
    .o2_icb_rsp_valid  (biu2tmr_icb_rsp_valid),
    .o2_icb_rsp_ready  (biu2tmr_icb_rsp_ready),
    .o2_icb_rsp_err    (biu2tmr_icb_rsp_err),
    .o2_icb_rsp_excl_ok(1'b0  ),
    .o2_icb_rsp_rdata  (biu2tmr_icb_rsp_rdata),
    `else
     

         
    .o2_icb_enable     (1'b0),

    .o2_icb_cmd_valid  (),
    .o2_icb_cmd_ready  (1'b0),
    .o2_icb_cmd_addr   (),
    .o2_icb_cmd_read   (),
    .o2_icb_cmd_wdata  (),
    .o2_icb_cmd_wmask  (),
    .o2_icb_cmd_lock   (),
    .o2_icb_cmd_excl   (),
    .o2_icb_cmd_size   (),
    .o2_icb_cmd_burst  (),
    .o2_icb_cmd_beat   (),
    
    .o2_icb_rsp_valid  (1'b0),
    .o2_icb_rsp_ready  (),
    .o2_icb_rsp_err    (1'b0),
    .o2_icb_rsp_excl_ok(1'b0  ),
    .o2_icb_rsp_rdata  (32'b0),

     
    `endif
     

 
         
    .o3_icb_enable     (1'b0),

    .o3_icb_cmd_valid  (),
    .o3_icb_cmd_ready  (1'b0),
    .o3_icb_cmd_addr   (),
    .o3_icb_cmd_read   (),
    .o3_icb_cmd_wdata  (),
    .o3_icb_cmd_wmask  (),
    .o3_icb_cmd_lock   (),
    .o3_icb_cmd_excl   (),
    .o3_icb_cmd_size   (),
    .o3_icb_cmd_burst  (),
    .o3_icb_cmd_beat   (),
    
    .o3_icb_rsp_valid  (1'b0),
    .o3_icb_rsp_ready  (),
    .o3_icb_rsp_err    (1'b0),
    .o3_icb_rsp_excl_ok(1'b0  ),
    .o3_icb_rsp_rdata  (32'b0),


     
    `ifndef N101_HAS_DEBUG_PRIVATE 
         
    .o4_icb_enable     (1'b1),

    .o4_icb_cmd_valid  (biu2dm_icb_cmd_valid),
    .o4_icb_cmd_ready  (biu2dm_icb_cmd_ready),
    .o4_icb_cmd_addr   (biu2dm_icb_cmd_addr ),
    .o4_icb_cmd_read   (biu2dm_icb_cmd_read ),
    .o4_icb_cmd_wdata  (biu2dm_icb_cmd_wdata),
    .o4_icb_cmd_wmask  (biu2dm_icb_cmd_wmask),
    .o4_icb_cmd_lock   (),
    .o4_icb_cmd_excl   (),
    .o4_icb_cmd_size   (),
    .o4_icb_cmd_burst  (),
    .o4_icb_cmd_beat   (),
    
    .o4_icb_rsp_valid  (biu2dm_icb_rsp_valid),
    .o4_icb_rsp_ready  (biu2dm_icb_rsp_ready),
    .o4_icb_rsp_err    (biu2dm_icb_rsp_err),
    .o4_icb_rsp_excl_ok(1'b0  ),
    .o4_icb_rsp_rdata  (biu2dm_icb_rsp_rdata),
    `else
     

         
    .o4_icb_enable     (1'b0),

    .o4_icb_cmd_valid  (),
    .o4_icb_cmd_ready  (1'b0),
    .o4_icb_cmd_addr   (),
    .o4_icb_cmd_read   (),
    .o4_icb_cmd_wdata  (),
    .o4_icb_cmd_wmask  (),
    .o4_icb_cmd_lock   (),
    .o4_icb_cmd_excl   (),
    .o4_icb_cmd_size   (),
    .o4_icb_cmd_burst  (),
    .o4_icb_cmd_beat   (),
    
    .o4_icb_rsp_valid  (1'b0),
    .o4_icb_rsp_ready  (),
    .o4_icb_rsp_err    (1'b0),
    .o4_icb_rsp_excl_ok(1'b0  ),
    .o4_icb_rsp_rdata  (32'b0),

     
    `endif
     

        
    .o5_icb_cmd_valid  (i_mem_icb_cmd_valid),
    .o5_icb_cmd_ready  (i_mem_icb_cmd_ready),
    .o5_icb_cmd_addr   (i_mem_icb_cmd_addr ),
    .o5_icb_cmd_read   (i_mem_icb_cmd_read ),
    .o5_icb_cmd_wdata  (i_mem_icb_cmd_wdata),
    .o5_icb_cmd_wmask  (i_mem_icb_cmd_wmask),
    .o5_icb_cmd_lock   (),
    .o5_icb_cmd_excl   (),
    .o5_icb_cmd_size   (),
    .o5_icb_cmd_burst  (),
    .o5_icb_cmd_beat   (),
    
    .o5_icb_rsp_valid  (i_mem_icb_rsp_valid),
    .o5_icb_rsp_ready  (i_mem_icb_rsp_ready),
    .o5_icb_rsp_err    (i_mem_icb_rsp_err  ),
    .o5_icb_rsp_excl_ok(1'b0  ),
    .o5_icb_rsp_rdata  (i_mem_icb_rsp_rdata),

    .clk               (clk  ),
    .rst_n             (rst_n) 
  );



      
  wire                         mrom_icb_cmd_valid;
  wire                         mrom_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   mrom_icb_cmd_addr; 
  wire                         mrom_icb_cmd_read; 
  
  wire                         mrom_icb_rsp_valid;
  wire                         mrom_icb_rsp_ready;
  wire                         mrom_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        mrom_icb_rsp_rdata;

`ifdef N101_HAS_ICACHE
  wire                         sysmem_icb_cmd_valid;
  wire                         sysmem_icb_cmd_ready;
  wire [`N101_ADDR_SIZE-1:0]   sysmem_icb_cmd_addr; 
  wire [`N101_XLEN-1:0]        sysmem_icb_cmd_wdata;
  wire [`N101_XLEN/8-1:0]      sysmem_icb_cmd_wmask;
  wire                         sysmem_icb_cmd_read; 
  
  wire                         sysmem_icb_rsp_valid;
  wire                         sysmem_icb_rsp_ready;
  wire                         sysmem_icb_rsp_err  ;
  wire [`N101_XLEN-1:0]        sysmem_icb_rsp_rdata;
`endif




 localparam MROM_AW = 12  ;
 localparam MROM_DP = 1024;
`ifdef N101_ADDR_SIZE_IS_20
 localparam SYSMEM_BASE_ADDR = 20'ha_0000;
`else
 localparam SYSMEM_BASE_ADDR = 32'ha000_0000;    
`endif
 localparam SYSMEM_AW = 16  ;
  
  
  
  
  
  

  n101_icb1to8_bus # (
  .ICB_FIFO_CMD_DP        (2),
  .ICB_FIFO_RSP_DP        (0),
  .ICB_FIFO_CUT_READY (0),
  .AW                   (`N101_ADDR_SIZE),
  .DW                   (`N101_XLEN),
  .SPLT_FIFO_OUTS_NUM   (1),
  .SPLT_FIFO_CUT_READY  (1),
  
  `ifdef N101_ADDR_SIZE_IS_20
  .O0_BASE_ADDR       (32'h8_0000),
  `else
  .O0_BASE_ADDR       (32'h8000_0000),    
  `endif
  .O0_BASE_REGION_LSB (16),
  
  .O1_BASE_ADDR       (32'h0000_1000),       
  .O1_BASE_REGION_LSB (12),
  
  .O2_BASE_ADDR       (32'h0002_0000),       
  .O2_BASE_REGION_LSB (16),
  
  `ifdef N101_ADDR_SIZE_IS_20
  .O3_BASE_ADDR       (32'h2_0000),      
  `else
  .O3_BASE_ADDR       (32'h2000_0000), 
  `endif
  .O3_BASE_REGION_LSB (16),
  
  `ifdef N101_ADDR_SIZE_IS_20
  .O4_BASE_ADDR       (20'h0_0000),      
  `else
  .O4_BASE_ADDR       (32'h0000_0000),   
  `endif
  .O4_BASE_REGION_LSB (16),

      
  .O5_BASE_ADDR       (`N101_CFG_PPI_BASE_ADDR),     
  .O5_BASE_REGION_LSB (16),
  
      
   `ifdef N101_ADDR_SIZE_IS_20
  .O6_BASE_ADDR       (SYSMEM_BASE_ADDR),
   `else
  .O6_BASE_ADDR       (SYSMEM_BASE_ADDR),    
   `endif
  .O6_BASE_REGION_LSB (SYSMEM_AW),
  
      
  .O7_BASE_ADDR       (32'h0000_0000),       
  .O7_BASE_REGION_LSB (0)

  )u_n101_mem_fab(

    .i_icb_cmd_valid  (i_mem_icb_cmd_valid),
    .i_icb_cmd_ready  (i_mem_icb_cmd_ready),
    .i_icb_cmd_addr   (i_mem_icb_cmd_addr ),
    .i_icb_cmd_read   (i_mem_icb_cmd_read ),
    .i_icb_cmd_wdata  (i_mem_icb_cmd_wdata),
    .i_icb_cmd_wmask  (i_mem_icb_cmd_wmask),
    .i_icb_cmd_lock   (1'b0 ),
    .i_icb_cmd_excl   (1'b0 ),
    .i_icb_cmd_size   (2'b0 ),
    .i_icb_cmd_burst  (3'b0),
    .i_icb_cmd_beat   (2'b0 ),
    
    .i_icb_rsp_valid  (i_mem_icb_rsp_valid),
    .i_icb_rsp_ready  (i_mem_icb_rsp_ready),
    .i_icb_rsp_err    (i_mem_icb_rsp_err  ),
    .i_icb_rsp_excl_ok(),
    .i_icb_rsp_rdata  (i_mem_icb_rsp_rdata),
    
  
    .o0_icb_enable     (1'b0),

    .o0_icb_cmd_valid  (),
    .o0_icb_cmd_ready  (1'b0),
    .o0_icb_cmd_addr   (),
    .o0_icb_cmd_read   (),
    .o0_icb_cmd_wdata  (),
    .o0_icb_cmd_wmask  (),
    .o0_icb_cmd_lock   (),
    .o0_icb_cmd_excl   (),
    .o0_icb_cmd_size   (),
    .o0_icb_cmd_burst  (),
    .o0_icb_cmd_beat   (),
    
    .o0_icb_rsp_valid  (1'b0),
    .o0_icb_rsp_ready  (),
    .o0_icb_rsp_err    (1'b0),
    .o0_icb_rsp_excl_ok(1'b0),
    .o0_icb_rsp_rdata  (32'b0),

  
    .o1_icb_enable     (1'b1),

    .o1_icb_cmd_valid  (mrom_icb_cmd_valid),
    .o1_icb_cmd_ready  (mrom_icb_cmd_ready),
    .o1_icb_cmd_addr   (mrom_icb_cmd_addr ),
    .o1_icb_cmd_read   (mrom_icb_cmd_read ),
    .o1_icb_cmd_wdata  (),
    .o1_icb_cmd_wmask  (),
    .o1_icb_cmd_lock   (),
    .o1_icb_cmd_excl   (),
    .o1_icb_cmd_size   (),
    .o1_icb_cmd_burst  (),
    .o1_icb_cmd_beat   (),
    
    .o1_icb_rsp_valid  (mrom_icb_rsp_valid),
    .o1_icb_rsp_ready  (mrom_icb_rsp_ready),
    .o1_icb_rsp_err    (mrom_icb_rsp_err),
    .o1_icb_rsp_excl_ok(1'b0  ),
    .o1_icb_rsp_rdata  (mrom_icb_rsp_rdata),

  
  
    .o2_icb_enable     (1'b0),

    .o2_icb_cmd_valid  (),
    .o2_icb_cmd_ready  (1'b0),
    .o2_icb_cmd_addr   (),
    .o2_icb_cmd_read   (),
    .o2_icb_cmd_wdata  (),
    .o2_icb_cmd_wmask  (),
    .o2_icb_cmd_lock   (),
    .o2_icb_cmd_excl   (),
    .o2_icb_cmd_size   (),
    .o2_icb_cmd_burst  (),
    .o2_icb_cmd_beat   (),
    
    .o2_icb_rsp_valid  (1'b0),
    .o2_icb_rsp_ready  (),
    .o2_icb_rsp_err    (1'b0),
    .o2_icb_rsp_excl_ok(1'b0  ),
    .o2_icb_rsp_rdata  (32'b0),

  
    .o3_icb_enable     (1'b1),

    .o3_icb_cmd_valid  (qspi0_ro_icb_cmd_valid),
    .o3_icb_cmd_ready  (qspi0_ro_icb_cmd_ready),
    .o3_icb_cmd_addr   (qspi0_ro_icb_cmd_addr ),
    .o3_icb_cmd_read   (qspi0_ro_icb_cmd_read ),
    .o3_icb_cmd_wdata  (qspi0_ro_icb_cmd_wdata),
    .o3_icb_cmd_wmask  (),
    .o3_icb_cmd_lock   (),
    .o3_icb_cmd_excl   (),
    .o3_icb_cmd_size   (),
    .o3_icb_cmd_burst  (),
    .o3_icb_cmd_beat   (),
    
    .o3_icb_rsp_valid  (qspi0_ro_icb_rsp_valid),
    .o3_icb_rsp_ready  (qspi0_ro_icb_rsp_ready),
    .o3_icb_rsp_err    (qspi0_ro_icb_rsp_err),
    .o3_icb_rsp_excl_ok(1'b0  ),
    .o3_icb_rsp_rdata  (qspi0_ro_icb_rsp_rdata),


  
    .o4_icb_enable     (1'b0),

    .o4_icb_cmd_valid  (),
    .o4_icb_cmd_ready  (1'b0),
    .o4_icb_cmd_addr   (),
    .o4_icb_cmd_read   (),
    .o4_icb_cmd_wdata  (),
    .o4_icb_cmd_wmask  (),
    .o4_icb_cmd_lock   (),
    .o4_icb_cmd_excl   (),
    .o4_icb_cmd_size   (),
    .o4_icb_cmd_burst  (),
    .o4_icb_cmd_beat   (),
    
    .o4_icb_rsp_valid  (1'b0),
    .o4_icb_rsp_ready  (),
    .o4_icb_rsp_err    (1'b0    ),
    .o4_icb_rsp_excl_ok(1'b0),
    .o4_icb_rsp_rdata  (32'b0),

     
`ifdef N101_HAS_PPI
    .o5_icb_enable     (1'b0),

    .o5_icb_cmd_valid  (),
    .o5_icb_cmd_ready  (1'b0),
    .o5_icb_cmd_addr   (),
    .o5_icb_cmd_read   (),
    .o5_icb_cmd_wdata  (),
    .o5_icb_cmd_wmask  (),
    .o5_icb_cmd_lock   (),
    .o5_icb_cmd_excl   (),
    .o5_icb_cmd_size   (),
    .o5_icb_cmd_burst  (),
    .o5_icb_cmd_beat   (),
    
    .o5_icb_rsp_valid  (1'b0),
    .o5_icb_rsp_ready  (),
    .o5_icb_rsp_err    (1'b0),
    .o5_icb_rsp_excl_ok(1'b0  ),
    .o5_icb_rsp_rdata  (32'b0),
`endif

`ifndef N101_HAS_PPI
     
    .o5_icb_enable     (1'b1),
    .o5_icb_cmd_valid  (biu2ppi_icb_cmd_valid),
    .o5_icb_cmd_ready  (biu2ppi_icb_cmd_ready),
    .o5_icb_cmd_addr   (biu2ppi_icb_cmd_addr ),
    .o5_icb_cmd_read   (biu2ppi_icb_cmd_read ),
    .o5_icb_cmd_wdata  (biu2ppi_icb_cmd_wdata),
    .o5_icb_cmd_wmask  (biu2ppi_icb_cmd_wmask),
    .o5_icb_cmd_lock   (),
    .o5_icb_cmd_excl   (),
    .o5_icb_cmd_size   (),
    .o5_icb_cmd_burst  (),
    .o5_icb_cmd_beat   (),
    
    .o5_icb_rsp_valid  (biu2ppi_icb_rsp_valid),
    .o5_icb_rsp_ready  (biu2ppi_icb_rsp_ready),
    .o5_icb_rsp_err    (biu2ppi_icb_rsp_err  ),
    .o5_icb_rsp_rdata  (biu2ppi_icb_rsp_rdata),
    .o5_icb_rsp_excl_ok(1'b0  ),
     
`endif
     



`ifndef N101_HAS_ICACHE
        
    .o6_icb_enable     (1'b0),

    .o6_icb_cmd_valid  (),
    .o6_icb_cmd_ready  (1'b0),
    .o6_icb_cmd_addr   (),
    .o6_icb_cmd_read   (),
    .o6_icb_cmd_wdata  (),
    .o6_icb_cmd_wmask  (),
    .o6_icb_cmd_lock   (),
    .o6_icb_cmd_excl   (),
    .o6_icb_cmd_size   (),
    .o6_icb_cmd_burst  (),
    .o6_icb_cmd_beat   (),
    
    .o6_icb_rsp_valid  (1'b0),
    .o6_icb_rsp_ready  (),
    .o6_icb_rsp_err    (1'b0  ),
    .o6_icb_rsp_excl_ok(1'b0  ),
    .o6_icb_rsp_rdata  (`N101_XLEN'b0),
`endif

`ifdef N101_HAS_ICACHE
        
    .o6_icb_enable     (1'b1),

    .o6_icb_cmd_valid  (sysmem_icb_cmd_valid),
    .o6_icb_cmd_ready  (sysmem_icb_cmd_ready),
    .o6_icb_cmd_addr   (sysmem_icb_cmd_addr ),
    .o6_icb_cmd_read   (sysmem_icb_cmd_read ),
    .o6_icb_cmd_wdata  (sysmem_icb_cmd_wdata),
    .o6_icb_cmd_wmask  (sysmem_icb_cmd_wmask),
    .o6_icb_cmd_lock   (),
    .o6_icb_cmd_excl   (),
    .o6_icb_cmd_size   (),
    .o6_icb_cmd_burst  (),
    .o6_icb_cmd_beat   (),
    
    .o6_icb_rsp_valid  (sysmem_icb_rsp_valid),
    .o6_icb_rsp_ready  (sysmem_icb_rsp_ready),
    .o6_icb_rsp_err    (sysmem_icb_rsp_err  ),
    .o6_icb_rsp_excl_ok(1'b0              ),
    .o6_icb_rsp_rdata  (sysmem_icb_rsp_rdata),
`endif

        
    .o7_icb_enable     (1'b0),

    .o7_icb_cmd_valid  (),
    .o7_icb_cmd_ready  (1'b0),
    .o7_icb_cmd_addr   (),
    .o7_icb_cmd_read   (),
    .o7_icb_cmd_wdata  (),
    .o7_icb_cmd_wmask  (),
    .o7_icb_cmd_lock   (),
    .o7_icb_cmd_excl   (),
    .o7_icb_cmd_size   (),
    .o7_icb_cmd_burst  (),
    .o7_icb_cmd_beat   (),
    
    .o7_icb_rsp_valid  (1'b0),
    .o7_icb_rsp_ready  (),
    .o7_icb_rsp_err    (1'b0  ),
    .o7_icb_rsp_excl_ok(1'b0  ),
    .o7_icb_rsp_rdata  (`N101_XLEN'b0),

    .clk           (clk  ),
    .rst_n         (bus_rst_n) 
  );

  n101_mrom_top #(
    .AW(MROM_AW),
    .DW(32),
    .DP(MROM_DP)
  )u_n101_mrom_top(

    .rom_icb_cmd_valid  (mrom_icb_cmd_valid),
    .rom_icb_cmd_ready  (mrom_icb_cmd_ready),
    .rom_icb_cmd_addr   (mrom_icb_cmd_addr [MROM_AW-1:0]),
    .rom_icb_cmd_read   (mrom_icb_cmd_read ),
    
    .rom_icb_rsp_valid  (mrom_icb_rsp_valid),
    .rom_icb_rsp_ready  (mrom_icb_rsp_ready),
    .rom_icb_rsp_err    (mrom_icb_rsp_err  ),
    .rom_icb_rsp_rdata  (mrom_icb_rsp_rdata),

    .clk           (clk  ),
    .rst_n         (rst_n) 
  );


`ifdef N101_HAS_ICACHE
 n101_icb_ram_top #(
      .DW     (`N101_XLEN),
      .AW     (SYSMEM_AW)
  ) u_sysmem_top (
     
     .icb_cmd_valid (sysmem_icb_cmd_valid),
     .icb_cmd_ready (sysmem_icb_cmd_ready),
     .icb_cmd_read  (sysmem_icb_cmd_read ),
     .icb_cmd_addr  (sysmem_icb_cmd_addr[SYSMEM_AW-1:0]), 
     .icb_cmd_wdata (sysmem_icb_cmd_wdata), 
     .icb_cmd_wmask (sysmem_icb_cmd_wmask), 
  
     .icb_rsp_valid (sysmem_icb_rsp_valid),
     .icb_rsp_ready (sysmem_icb_rsp_ready),
     .icb_rsp_rdata (sysmem_icb_rsp_rdata),
     .icb_rsp_err   (sysmem_icb_rsp_err  ),
  
     .clk           (clk               ),
     .rst_n         (rst_n             )  
    );

`endif



  



  
     
      `ifndef N101_TMR_PRIVATE 
n101_tmr_top u_n101_tmr_top(
    .i_icb_cmd_valid     (biu2tmr_icb_cmd_valid),
    .i_icb_cmd_ready     (biu2tmr_icb_cmd_ready),
    .i_icb_cmd_addr      (biu2tmr_icb_cmd_addr ),
    .i_icb_cmd_read      (biu2tmr_icb_cmd_read ),
    .i_icb_cmd_wdata     (biu2tmr_icb_cmd_wdata),
    .i_icb_cmd_wmask     (biu2tmr_icb_cmd_wmask),
    .i_icb_cmd_mmode     (1'b0),
    .i_icb_cmd_dmode     (1'b0),
    
    .i_icb_rsp_valid     (biu2tmr_icb_rsp_valid),
    .i_icb_rsp_ready     (biu2tmr_icb_rsp_ready),
    .i_icb_rsp_err       (biu2tmr_icb_rsp_err  ),
    .i_icb_rsp_rdata     (biu2tmr_icb_rsp_rdata),

    .tmr_irq             (mtip),
    .sft_irq             (msip),

    .rtc_toggle_i        (mtime_toggle_a),

    .dbg_stoptime        (1'b0), 

    .tmr_active          (),
    .sft_rst_req         (),
    .clk                 (clk   ),
    .clk_aon             (clk   ),

    .rst_n               (rst_n) 
  );
    `endif
     



endmodule
