 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















`include "n101_defines.v"
`include "n101_subsys_defines.v"


module n101_subsys_lm(
     
      `ifndef N101_D_SHARE_ILM 
     
  input                           biu2ilm_icb_cmd_valid,
  output                          biu2ilm_icb_cmd_ready,
  input   [`N101_ILM_ADDR_WIDTH-1:0]   biu2ilm_icb_cmd_addr, 
  input                           biu2ilm_icb_cmd_read, 
  input   [`N101_XLEN-1:0]        biu2ilm_icb_cmd_wdata,
  input   [`N101_XLEN/8-1:0]      biu2ilm_icb_cmd_wmask,
  
  output                          biu2ilm_icb_rsp_valid,
  input                           biu2ilm_icb_rsp_ready,
  output                          biu2ilm_icb_rsp_err,
  output   [`N101_XLEN-1:0]       biu2ilm_icb_rsp_rdata,
     
     `endif
     

  input                           biu2dlm_icb_cmd_valid,
  output                          biu2dlm_icb_cmd_ready,
  input   [`N101_DLM_ADDR_WIDTH-1:0]   biu2dlm_icb_cmd_addr, 
  input                           biu2dlm_icb_cmd_read, 
  input   [`N101_XLEN-1:0]        biu2dlm_icb_cmd_wdata,
  input   [`N101_XLEN/8-1:0]      biu2dlm_icb_cmd_wmask,
  
  output                          biu2dlm_icb_rsp_valid,
  input                           biu2dlm_icb_rsp_ready,
  output                          biu2dlm_icb_rsp_err,
  output   [`N101_XLEN-1:0]       biu2dlm_icb_rsp_rdata,
     
  
  
  
     `ifdef N101_HAS_ILM 

  `ifdef N101_LM_ITF_TYPE_SRAM 
  input               i_ilm_ram_cs,  
  input  [`N101_ILM_RAM_AW-1:0] i_ilm_ram_addr, 
  input  [`N101_ILM_RAM_MW-1:0] i_ilm_ram_wem,
  input  [`N101_ILM_RAM_DW-1:0] i_ilm_ram_din,          
  output [`N101_ILM_RAM_DW-1:0] i_ilm_ram_dout,
  input               i_clk_ilm_ram,
  `endif

  `ifdef N101_LM_ITF_TYPE_AHBL 
      
  input  [1:0]       ilm_ahbl_htrans,   
  input              ilm_ahbl_hwrite,   
  input  [`N101_ILM_DATA_WIDTH-1:0]ilm_ahbl_hwdata,   
  input  [`N101_ILM_ADDR_WIDTH-1:0]ilm_ahbl_haddr,    
  input  [2:0]       ilm_ahbl_hsize,    
  output [`N101_ILM_DATA_WIDTH-1:0]ilm_ahbl_hrdata,   
  output [1:0]       ilm_ahbl_hresp,    
  output             ilm_ahbl_hready,   
  `endif
  
      `endif


  
  
  
     `ifdef N101_HAS_DLM 

  `ifdef N101_DLM_MASTER_SRAM 
  input               i_dlm_ram_cs,  
  input  [`N101_DLM_RAM_AW-1:0] i_dlm_ram_addr, 
  input  [`N101_DLM_RAM_MW-1:0] i_dlm_ram_wem,
  input  [`N101_DLM_RAM_DW-1:0] i_dlm_ram_din,          
  output [`N101_DLM_RAM_DW-1:0] i_dlm_ram_dout,
  input               i_clk_dlm_ram,
  `endif

  `ifdef N101_DLM_MASTER_AHBL 
      
  input  [1:0]       dlm_ahbl_htrans,   
  input              dlm_ahbl_hwrite,   
  input  [`N101_DLM_ADDR_WIDTH    -1:0]dlm_ahbl_haddr,    
  input  [2:0]       dlm_ahbl_hsize,    
  input  [`N101_DLM_DATA_WIDTH    -1:0]dlm_ahbl_hwdata,   
  output [`N101_DLM_DATA_WIDTH    -1:0]dlm_ahbl_hrdata,   
  output [1:0]       dlm_ahbl_hresp,    
  output             dlm_ahbl_hready,   
  `endif
  
      `endif
     


  input  test_mode,
  input  clk,
  input  rst_n
  );




     
  `ifdef N101_HAS_DLM 


      `ifdef N101_DLM_MASTER_AHBL 
  wire             dlm_icb_cmd_valid; 
  wire             dlm_icb_cmd_ready; 
  wire [1-1:0]     dlm_icb_cmd_read; 
  wire [`N101_DLM_ADDR_WIDTH-1:0]    dlm_icb_cmd_addr; 
  wire [`N101_DLM_DATA_WIDTH-1:0]    dlm_icb_cmd_wdata; 
  wire [`N101_DLM_DATA_WIDTH/8-1:0]  dlm_icb_cmd_wmask;

  wire             dlm_icb_rsp_valid; 
  wire             dlm_icb_rsp_ready; 
  wire             dlm_icb_rsp_err;
  wire [`N101_DLM_DATA_WIDTH-1:0]    dlm_icb_rsp_rdata; 

    n101_gnrl_ahbl2icb
  #(
    .AW(`N101_DLM_ADDR_WIDTH),
    .DW(`N101_XLEN)
    ) u_dlm_ahbl2icb (
      
    .ahbl2icb_active (),

    .ahbl_hsel       (1'b1      ),    
    .ahbl_htrans     (dlm_ahbl_htrans    ),
    .ahbl_hwrite     (dlm_ahbl_hwrite    ),
    .ahbl_haddr      (dlm_ahbl_haddr     ),
    .ahbl_hsize      (dlm_ahbl_hsize     ),
    .ahbl_hexcl      (1'b0     ),
    .ahbl_hwdata     (dlm_ahbl_hwdata    ),
	.ahbl_huser      (1'b0),
                      
    .ahbl_hrdata     (dlm_ahbl_hrdata    ),
    .ahbl_hresp      (dlm_ahbl_hresp     ),
    .ahbl_hresp_exok (),
    .ahbl_hready_in  (dlm_ahbl_hready),  
    .ahbl_hready_out (dlm_ahbl_hready),   

    .icb_cmd_valid (dlm_icb_cmd_valid),
    .icb_cmd_ready (dlm_icb_cmd_ready),
    .icb_cmd_read  (dlm_icb_cmd_read ),
    .icb_cmd_addr  (dlm_icb_cmd_addr ),
    .icb_cmd_wdata (dlm_icb_cmd_wdata),
    .icb_cmd_wmask (dlm_icb_cmd_wmask),
    .icb_cmd_size  (), 
    .icb_cmd_excl  (),
	.icb_cmd_sel   (),
	.icb_cmd_user  (),

    .icb_rsp_valid (dlm_icb_rsp_valid),
    .icb_rsp_ready (dlm_icb_rsp_ready),
    .icb_rsp_err   (dlm_icb_rsp_err  ),
    .icb_rsp_rdata (dlm_icb_rsp_rdata),
    .icb_rsp_excl_ok (1'b0),
       
    .clk           (clk  ),
    .rst_n         (rst_n) 
  );
     `endif
  `endif
     

  wire             i_dlm_icb_cmd_valid; 
  wire             i_dlm_icb_cmd_ready; 
  wire [1-1:0]     i_dlm_icb_cmd_read; 
  wire [`N101_DLM_ADDR_WIDTH-1:0]    i_dlm_icb_cmd_addr;
  wire [`N101_DLM_DATA_WIDTH-1:0]    i_dlm_icb_cmd_wdata; 
  wire [`N101_DLM_DATA_WIDTH/8-1:0]  i_dlm_icb_cmd_wmask;

  wire             i_dlm_icb_rsp_valid; 
  wire             i_dlm_icb_rsp_ready; 
  wire             i_dlm_icb_rsp_err;
  wire [`N101_DLM_DATA_WIDTH-1:0]    i_dlm_icb_rsp_rdata;


  n101_icb2to1_bus # (
    .ICB_FIFO_DP (0), 
    .ICB_FIFO_CUT_READY (0), 
    .AW (`N101_DLM_ADDR_WIDTH),
    .DW (`N101_XLEN),
      
    .ARBT_FIFO_OUTS_NUM   (2),
    .ARBT_FIFO_OUTS_CNT_W (2),
    .ARBT_FIFO_CUT_READY  (1),
    .ARBT_SCHEME          (0),
    .ARBT_ALLOW_0CYCL_RSP (0) 

  ) u_dlm_icb2to1_bus(

    .o_icb_cmd_valid  (i_dlm_icb_cmd_valid),
    .o_icb_cmd_ready  (i_dlm_icb_cmd_ready),
    .o_icb_cmd_addr   (i_dlm_icb_cmd_addr),
    .o_icb_cmd_read   (i_dlm_icb_cmd_read ),
    .o_icb_cmd_wdata  (i_dlm_icb_cmd_wdata),
    .o_icb_cmd_wmask  (i_dlm_icb_cmd_wmask),
    .o_icb_cmd_lock   (),
    .o_icb_cmd_excl   (),
    .o_icb_cmd_size   (),
    .o_icb_cmd_burst  (),
    .o_icb_cmd_beat   (),
    
    .o_icb_rsp_valid  (i_dlm_icb_rsp_valid),
    .o_icb_rsp_ready  (i_dlm_icb_rsp_ready),
    .o_icb_rsp_err    (i_dlm_icb_rsp_err  ),
    .o_icb_rsp_excl_ok(1'b0),
    .o_icb_rsp_rdata  (i_dlm_icb_rsp_rdata),

    .i0_icb_cmd_valid  (biu2dlm_icb_cmd_valid),
    .i0_icb_cmd_ready  (biu2dlm_icb_cmd_ready),
    .i0_icb_cmd_addr   (biu2dlm_icb_cmd_addr ),
    .i0_icb_cmd_read   (biu2dlm_icb_cmd_read ),
    .i0_icb_cmd_wdata  (biu2dlm_icb_cmd_wdata),
    .i0_icb_cmd_wmask  (biu2dlm_icb_cmd_wmask),
    .i0_icb_cmd_lock   (1'b0 ),
    .i0_icb_cmd_excl   (1'b0 ),
    .i0_icb_cmd_size   (2'b0 ),
    .i0_icb_cmd_burst  (3'b0),
    .i0_icb_cmd_beat   (2'b0 ),
    
    .i0_icb_rsp_valid  (biu2dlm_icb_rsp_valid),
    .i0_icb_rsp_ready  (biu2dlm_icb_rsp_ready),
    .i0_icb_rsp_err    (biu2dlm_icb_rsp_err  ),
    .i0_icb_rsp_excl_ok(),
    .i0_icb_rsp_rdata  (biu2dlm_icb_rsp_rdata),


     
  `ifdef N101_DLM_MASTER_AHBL 
    .i1_icb_cmd_valid  (dlm_icb_cmd_valid),
    .i1_icb_cmd_ready  (dlm_icb_cmd_ready),
    .i1_icb_cmd_addr   (dlm_icb_cmd_addr ),
    .i1_icb_cmd_read   (dlm_icb_cmd_read ),
    .i1_icb_cmd_wdata  (dlm_icb_cmd_wdata),
    .i1_icb_cmd_wmask  (dlm_icb_cmd_wmask),
    .i1_icb_cmd_lock   (1'b0 ),
    .i1_icb_cmd_excl   (1'b0 ),
    .i1_icb_cmd_size   (2'b0 ),
    .i1_icb_cmd_burst  (3'b0),
    .i1_icb_cmd_beat   (2'b0 ),
    
    .i1_icb_rsp_valid  (dlm_icb_rsp_valid),
    .i1_icb_rsp_ready  (dlm_icb_rsp_ready),
    .i1_icb_rsp_err    (dlm_icb_rsp_err  ),
    .i1_icb_rsp_excl_ok(),
    .i1_icb_rsp_rdata  (dlm_icb_rsp_rdata),
  `endif

  `ifndef N101_DLM_MASTER_AHBL 
     
    .i1_icb_cmd_valid  (1'b0),
    .i1_icb_cmd_ready  (),
    .i1_icb_cmd_addr   (`N101_DLM_ADDR_WIDTH'b0),
    .i1_icb_cmd_read   (1'b0 ),
    .i1_icb_cmd_wdata  (`N101_DLM_DATA_WIDTH'b0),
    .i1_icb_cmd_wmask  ({`N101_DLM_DATA_WIDTH/8{1'b0}}),
    .i1_icb_cmd_lock   (1'b0 ),
    .i1_icb_cmd_excl   (1'b0 ),
    .i1_icb_cmd_size   (2'b0 ),
    .i1_icb_cmd_burst  (3'b0),
    .i1_icb_cmd_beat   (2'b0 ),
    
    .i1_icb_rsp_valid  (),
    .i1_icb_rsp_ready  (1'b0),
    .i1_icb_rsp_err    (),
    .i1_icb_rsp_excl_ok(),
    .i1_icb_rsp_rdata  (),
     
  `endif
     

    .clk           (clk  ),
    .rst_n         (rst_n) 
  );




  wire                        dlm_ram_cs;  
  wire [`N101_DLM_RAM_AW-1:0] dlm_ram_addr; 
  wire [`N101_DLM_RAM_MW-1:0] dlm_ram_wem;
  wire [`N101_DLM_RAM_DW-1:0] dlm_ram_din;          
  wire [`N101_DLM_RAM_DW-1:0] dlm_ram_dout;
  wire                        clk_dlm_ram;

  n101_sram_icb_ctrl #(
      .DW     (`N101_DLM_DATA_WIDTH),
      .AW     (`N101_DLM_ADDR_WIDTH),
      .MW     (`N101_DLM_WMSK_WIDTH),
      .AW_LSB (2),
      .USR_W  (1) 
  ) u_dlm_icb_ctrl (
     .sram_ctrl_active (),
     .tcm_cgstop       (1'b0),

     
  `ifdef N101_DLM_MASTER_SRAM 
     .stall_uop_cmd   (i_dlm_ram_cs),
  `endif
  `ifndef N101_DLM_MASTER_SRAM 
     
     .stall_uop_cmd   (1'b0),
     
  `endif
     
     
     .i_icb_cmd_valid (i_dlm_icb_cmd_valid),
     .i_icb_cmd_ready (i_dlm_icb_cmd_ready),
     .i_icb_cmd_read  (i_dlm_icb_cmd_read ),
     .i_icb_cmd_addr  (i_dlm_icb_cmd_addr ), 
     .i_icb_cmd_wdata (i_dlm_icb_cmd_wdata), 
     .i_icb_cmd_wmask (i_dlm_icb_cmd_wmask), 
     .i_icb_cmd_usr   (),
  
     .i_icb_rsp_valid (i_dlm_icb_rsp_valid),
     .i_icb_rsp_ready (i_dlm_icb_rsp_ready),
     .i_icb_rsp_rdata (i_dlm_icb_rsp_rdata),
     .i_icb_rsp_usr   (),
  
     .ram_cs          (dlm_ram_cs  ),  
     .ram_addr        (dlm_ram_addr), 
     .ram_wem         (dlm_ram_wem ),
     .ram_din         (dlm_ram_din ),          
     .ram_dout        (dlm_ram_dout),
     .clk_ram         (clk_dlm_ram ),
  
     .clkgate_bypass       (test_mode  ),
     .clk             (clk  ),
     .rst_n           (rst_n)  
    );

  assign i_dlm_icb_rsp_err = 1'b0;

  wire              final_dlm_ram_cs;  
  wire [`N101_DLM_RAM_AW-1:0] final_dlm_ram_addr; 
  wire [`N101_DLM_RAM_MW-1:0] final_dlm_ram_wem;
  wire [`N101_DLM_RAM_DW-1:0] final_dlm_ram_din;          
  wire [`N101_DLM_RAM_DW-1:0] final_dlm_ram_dout;
  wire              final_clk_dlm_ram;

     
  `ifdef N101_DLM_MASTER_SRAM 
  assign final_dlm_ram_cs   = i_dlm_ram_cs ? i_dlm_ram_cs   : dlm_ram_cs  ;  
  assign final_dlm_ram_addr = i_dlm_ram_cs ? i_dlm_ram_addr : dlm_ram_addr; 
  assign final_dlm_ram_wem  = i_dlm_ram_cs ? i_dlm_ram_wem  : dlm_ram_wem ;
  assign final_dlm_ram_din  = i_dlm_ram_cs ? i_dlm_ram_din  : dlm_ram_din ;          
  assign final_clk_dlm_ram  = clk;

  assign dlm_ram_dout = final_dlm_ram_dout;
  assign i_dlm_ram_dout = final_dlm_ram_dout;
  `endif

  `ifndef N101_DLM_MASTER_SRAM 
     
  assign final_dlm_ram_cs   = dlm_ram_cs  ;  
  assign final_dlm_ram_addr = dlm_ram_addr; 
  assign final_dlm_ram_wem  = dlm_ram_wem ;
  assign final_dlm_ram_din  = dlm_ram_din ;          
  assign dlm_ram_dout = final_dlm_ram_dout;
  assign final_clk_dlm_ram  = clk_dlm_ram ;
     
  `endif
     




  n101_dlm_ram u_n101_dlm_ram (
    .sd   (1'b0),
    .ds   (1'b0),
    .ls   (1'b0),
  
    .cs   (final_dlm_ram_cs   ),
    .we   (|final_dlm_ram_wem   ),
    .addr (final_dlm_ram_addr ),
    .wem  (final_dlm_ram_wem  ),
    .din  (final_dlm_ram_din  ),
    .dout (final_dlm_ram_dout),
    .rst_n(1'b1      ),
    .clk  (final_clk_dlm_ram  )
    );
    







     

  `ifdef N101_HAS_ILM 


      `ifdef N101_LM_ITF_TYPE_AHBL 
  wire             ilm_icb_cmd_valid; 
  wire             ilm_icb_cmd_ready; 
  wire [1-1:0]     ilm_icb_cmd_read; 
  wire [`N101_ILM_ADDR_WIDTH-1:0]    ilm_icb_cmd_addr; 
  wire [`N101_ILM_DATA_WIDTH-1:0]    ilm_icb_cmd_wdata; 
  wire [`N101_ILM_DATA_WIDTH/8-1:0]  ilm_icb_cmd_wmask;

  wire             ilm_icb_rsp_valid; 
  wire             ilm_icb_rsp_ready; 
  wire             ilm_icb_rsp_err;
  wire [`N101_ILM_DATA_WIDTH-1:0]    ilm_icb_rsp_rdata; 

    n101_gnrl_ahbl2icb
  #(
    .AW(`N101_ILM_ADDR_WIDTH),
    .DW(`N101_XLEN)
    ) u_ilm_ahbl2icb (
      
    .ahbl2icb_active (),

    .ahbl_hsel       (1'b1      ),    
    .ahbl_htrans     (ilm_ahbl_htrans    ),
    .ahbl_hwrite     (ilm_ahbl_hwrite    ),
    .ahbl_hexcl      (1'b0    ),
    .ahbl_haddr      (ilm_ahbl_haddr     ),
    .ahbl_hsize      (ilm_ahbl_hsize     ),
    .ahbl_hwdata     (ilm_ahbl_hwdata     ),
	.ahbl_huser      (1'b0),
                      
    .ahbl_hrdata     (ilm_ahbl_hrdata    ),
    .ahbl_hresp      (ilm_ahbl_hresp     ),
    .ahbl_hresp_exok (),
    .ahbl_hready_in  (ilm_ahbl_hready),  
    .ahbl_hready_out (ilm_ahbl_hready),   

    .icb_cmd_valid (ilm_icb_cmd_valid),
    .icb_cmd_ready (ilm_icb_cmd_ready),
    .icb_cmd_read  (ilm_icb_cmd_read ),
    .icb_cmd_addr  (ilm_icb_cmd_addr ),
    .icb_cmd_wdata (ilm_icb_cmd_wdata),
    .icb_cmd_wmask (ilm_icb_cmd_wmask),
    .icb_cmd_size  (), 
    .icb_cmd_excl  (),
    .icb_cmd_sel   (),
	.icb_cmd_user  (),

    .icb_rsp_valid (ilm_icb_rsp_valid),
    .icb_rsp_ready (ilm_icb_rsp_ready),
    .icb_rsp_err   (ilm_icb_rsp_err  ),
    .icb_rsp_rdata (ilm_icb_rsp_rdata),
    .icb_rsp_excl_ok (1'b0),
       
    .clk           (clk  ),
    .rst_n         (rst_n) 
  );
     `endif
  `endif
     


  wire             i_ilm_icb_cmd_valid; 
  wire             i_ilm_icb_cmd_ready; 
  wire [1-1:0]     i_ilm_icb_cmd_read; 
  wire [`N101_ILM_ADDR_WIDTH-1:0]    i_ilm_icb_cmd_addr;
  wire [`N101_ILM_DATA_WIDTH-1:0]    i_ilm_icb_cmd_wdata; 
  wire [`N101_ILM_DATA_WIDTH/8-1:0]  i_ilm_icb_cmd_wmask;

  wire             i_ilm_icb_rsp_valid; 
  wire             i_ilm_icb_rsp_ready; 
  wire             i_ilm_icb_rsp_err;
  wire [`N101_ILM_DATA_WIDTH-1:0]    i_ilm_icb_rsp_rdata;


  n101_icb2to1_bus # (
    .ICB_FIFO_DP (0), 
    .ICB_FIFO_CUT_READY (0), 
    .AW (`N101_ILM_ADDR_WIDTH),
    .DW (`N101_XLEN),
      
    .ARBT_FIFO_OUTS_NUM   (2),
    .ARBT_FIFO_OUTS_CNT_W (2),
    .ARBT_FIFO_CUT_READY  (1),
    .ARBT_SCHEME          (0),
    .ARBT_ALLOW_0CYCL_RSP (0) 

  ) u_ilm_icb2to1_bus(

    .o_icb_cmd_valid  (i_ilm_icb_cmd_valid),
    .o_icb_cmd_ready  (i_ilm_icb_cmd_ready),
    .o_icb_cmd_addr   (i_ilm_icb_cmd_addr),
    .o_icb_cmd_read   (i_ilm_icb_cmd_read ),
    .o_icb_cmd_wdata  (i_ilm_icb_cmd_wdata),
    .o_icb_cmd_wmask  (i_ilm_icb_cmd_wmask),
    .o_icb_cmd_lock   (),
    .o_icb_cmd_excl   (),
    .o_icb_cmd_size   (),
    .o_icb_cmd_burst  (),
    .o_icb_cmd_beat   (),
    
    .o_icb_rsp_valid  (i_ilm_icb_rsp_valid),
    .o_icb_rsp_ready  (i_ilm_icb_rsp_ready),
    .o_icb_rsp_err    (i_ilm_icb_rsp_err  ),
    .o_icb_rsp_excl_ok(1'b0),
    .o_icb_rsp_rdata  (i_ilm_icb_rsp_rdata),

     
      `ifndef N101_D_SHARE_ILM 
     
    .i0_icb_cmd_valid  (biu2ilm_icb_cmd_valid),
    .i0_icb_cmd_ready  (biu2ilm_icb_cmd_ready),
    .i0_icb_cmd_addr   (biu2ilm_icb_cmd_addr ),
    .i0_icb_cmd_read   (biu2ilm_icb_cmd_read ),
    .i0_icb_cmd_wdata  (biu2ilm_icb_cmd_wdata),
    .i0_icb_cmd_wmask  (biu2ilm_icb_cmd_wmask),
    .i0_icb_cmd_lock   (1'b0 ),
    .i0_icb_cmd_excl   (1'b0 ),
    .i0_icb_cmd_size   (2'b0 ),
    .i0_icb_cmd_burst  (3'b0),
    .i0_icb_cmd_beat   (2'b0 ),
    
    .i0_icb_rsp_valid  (biu2ilm_icb_rsp_valid),
    .i0_icb_rsp_ready  (biu2ilm_icb_rsp_ready),
    .i0_icb_rsp_err    (biu2ilm_icb_rsp_err  ),
    .i0_icb_rsp_excl_ok(),
    .i0_icb_rsp_rdata  (biu2ilm_icb_rsp_rdata),
     
     `else
    .i0_icb_cmd_valid  (1'b0),
    .i0_icb_cmd_ready  (),
    .i0_icb_cmd_addr   (`N101_ILM_ADDR_WIDTH'b0),
    .i0_icb_cmd_read   (1'b0 ),
    .i0_icb_cmd_wdata  (`N101_ILM_DATA_WIDTH'b0),
    .i0_icb_cmd_wmask  ({`N101_ILM_DATA_WIDTH/8{1'b0}}),
    .i0_icb_cmd_lock   (1'b0 ),
    .i0_icb_cmd_excl   (1'b0 ),
    .i0_icb_cmd_size   (2'b0 ),
    .i0_icb_cmd_burst  (3'b0),
    .i0_icb_cmd_beat   (2'b0 ),
    
    .i0_icb_rsp_valid  (),
    .i0_icb_rsp_ready  (1'b0),
    .i0_icb_rsp_err    (),
    .i0_icb_rsp_excl_ok(),
    .i0_icb_rsp_rdata  (),

     `endif
     


     
  `ifdef N101_ILM_MASTER_AHBL 
    .i1_icb_cmd_valid  (ilm_icb_cmd_valid),
    .i1_icb_cmd_ready  (ilm_icb_cmd_ready),
    .i1_icb_cmd_addr   (ilm_icb_cmd_addr ),
    .i1_icb_cmd_read   (ilm_icb_cmd_read ),
    .i1_icb_cmd_wdata  (ilm_icb_cmd_wdata),
    .i1_icb_cmd_wmask  (ilm_icb_cmd_wmask),
    .i1_icb_cmd_lock   (1'b0 ),
    .i1_icb_cmd_excl   (1'b0 ),
    .i1_icb_cmd_size   (2'b0 ),
    .i1_icb_cmd_burst  (3'b0),
    .i1_icb_cmd_beat   (2'b0 ),
    
    .i1_icb_rsp_valid  (ilm_icb_rsp_valid),
    .i1_icb_rsp_ready  (ilm_icb_rsp_ready),
    .i1_icb_rsp_err    (ilm_icb_rsp_err  ),
    .i1_icb_rsp_excl_ok(),
    .i1_icb_rsp_rdata  (ilm_icb_rsp_rdata),
  `endif

  `ifndef N101_ILM_MASTER_AHBL 
     
    .i1_icb_cmd_valid  (1'b0),
    .i1_icb_cmd_ready  (),
    .i1_icb_cmd_addr   (`N101_ILM_ADDR_WIDTH'b0),
    .i1_icb_cmd_read   (1'b0 ),
    .i1_icb_cmd_wdata  (`N101_ILM_DATA_WIDTH'b0),
    .i1_icb_cmd_wmask  ({`N101_ILM_DATA_WIDTH/8{1'b0}}),
    .i1_icb_cmd_lock   (1'b0 ),
    .i1_icb_cmd_excl   (1'b0 ),
    .i1_icb_cmd_size   (2'b0 ),
    .i1_icb_cmd_burst  (3'b0),
    .i1_icb_cmd_beat   (2'b0 ),
    
    .i1_icb_rsp_valid  (),
    .i1_icb_rsp_ready  (1'b0),
    .i1_icb_rsp_err    (),
    .i1_icb_rsp_excl_ok(),
    .i1_icb_rsp_rdata  (),
     
  `endif
     

    .clk           (clk  ),
    .rst_n         (rst_n) 
  );





  wire              ilm_ram_cs;  
  wire [`N101_ILM_RAM_AW-1:0] ilm_ram_addr; 
  wire [`N101_ILM_RAM_MW-1:0] ilm_ram_wem;
  wire [`N101_ILM_RAM_DW-1:0] ilm_ram_din;          
  wire [`N101_ILM_RAM_DW-1:0] ilm_ram_dout;
  wire              clk_ilm_ram;

 n101_sram_icb_ctrl #(
      .DW     (`N101_ILM_DATA_WIDTH),
      .AW     (`N101_ILM_ADDR_WIDTH),
      .MW     (`N101_ILM_WMSK_WIDTH),
      .AW_LSB (2),
      .USR_W  (1) 
  ) u_ilm_icb_ctrl (
     .sram_ctrl_active (),
     .tcm_cgstop       (1'b0),

     
  `ifdef N101_ILM_MASTER_SRAM 
     .stall_uop_cmd   (i_ilm_ram_cs),
  `endif
  `ifndef N101_ILM_MASTER_SRAM 
     
     .stall_uop_cmd   (1'b0),
     
  `endif
     
     
     .i_icb_cmd_valid (i_ilm_icb_cmd_valid),
     .i_icb_cmd_ready (i_ilm_icb_cmd_ready),
     .i_icb_cmd_read  (i_ilm_icb_cmd_read ),
     .i_icb_cmd_addr  (i_ilm_icb_cmd_addr ), 
     .i_icb_cmd_wdata (i_ilm_icb_cmd_wdata), 
     .i_icb_cmd_wmask (i_ilm_icb_cmd_wmask), 
     .i_icb_cmd_usr   (),
  
     .i_icb_rsp_valid (i_ilm_icb_rsp_valid),
     .i_icb_rsp_ready (i_ilm_icb_rsp_ready),
     .i_icb_rsp_rdata (i_ilm_icb_rsp_rdata),
     .i_icb_rsp_usr   (),
  
     .ram_cs   (ilm_ram_cs  ),  
     .ram_addr (ilm_ram_addr), 
     .ram_wem  (ilm_ram_wem ),
     .ram_din  (ilm_ram_din ),          
     .ram_dout (ilm_ram_dout),
     .clk_ram  (clk_ilm_ram ),
  
     .clkgate_bypass(test_mode  ),
     .clk  (clk  ),
     .rst_n(rst_n)  
    );

  assign i_ilm_icb_rsp_err = 1'b0;

  wire              final_ilm_ram_cs;  
  wire [`N101_ILM_RAM_AW-1:0] final_ilm_ram_addr; 
  wire [`N101_ILM_RAM_MW-1:0] final_ilm_ram_wem;
  wire [`N101_ILM_RAM_DW-1:0] final_ilm_ram_din;          
  wire [`N101_ILM_RAM_DW-1:0] final_ilm_ram_dout;
  wire              final_clk_ilm_ram;

     
  `ifdef N101_ILM_MASTER_SRAM 
  assign final_ilm_ram_cs   = i_ilm_ram_cs ? i_ilm_ram_cs   : ilm_ram_cs  ;  
  assign final_ilm_ram_addr = i_ilm_ram_cs ? i_ilm_ram_addr : ilm_ram_addr; 
  assign final_ilm_ram_wem  = i_ilm_ram_cs ? i_ilm_ram_wem  : ilm_ram_wem ;
  assign final_ilm_ram_din  = i_ilm_ram_cs ? i_ilm_ram_din  : ilm_ram_din ;          
  assign final_clk_ilm_ram  = clk;

  assign ilm_ram_dout = final_ilm_ram_dout;
  assign i_ilm_ram_dout = final_ilm_ram_dout;
  `endif

  `ifndef N101_ILM_MASTER_SRAM 
     
  assign final_ilm_ram_cs   = ilm_ram_cs  ;  
  assign final_ilm_ram_addr = ilm_ram_addr; 
  assign final_ilm_ram_wem  = ilm_ram_wem ;
  assign final_ilm_ram_din  = ilm_ram_din ;          
  assign ilm_ram_dout = final_ilm_ram_dout;
  assign final_clk_ilm_ram  = clk_ilm_ram ;
     
  `endif
     

  n101_ilm_ram u_n101_ilm_ram (
    .sd   (1'b0),
    .ds   (1'b0),
    .ls   (1'b0),
  
    .cs   (final_ilm_ram_cs   ),
    .we   (|final_ilm_ram_wem ),
    .addr (final_ilm_ram_addr ),
    .wem  (final_ilm_ram_wem  ),
    .din  (final_ilm_ram_din  ),
    .dout (final_ilm_ram_dout),
    .rst_n(1'b1      ),
    .clk  (final_clk_ilm_ram  )
    );
    



endmodule
