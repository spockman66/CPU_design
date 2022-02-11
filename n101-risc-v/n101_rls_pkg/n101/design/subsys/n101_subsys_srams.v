 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         



















`include "n101_defines.v"

module n101_subsys_srams(


  `ifdef N101_HAS_ICACHE 
  input  rst_icache_ram,

  input                            icache_tag0_cs,  
  input                            icache_tag0_we,  
  input  [`N101_ICACHE_TAG_RAM_AW-1:0] icache_tag0_addr, 
  input  [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag0_wdata,          
  output [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag0_rdata,
  input                        clk_icache_tag0,

  input                            icache_data0_cs,  
  input                            icache_data0_we,  
  input  [`N101_ICACHE_DATA_RAM_AW-1:0] icache_data0_addr, 
  input  [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data0_wdata,          
  output [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data0_rdata,
  input                        clk_icache_data0,

    `ifdef N101_ICACHE_2WAYS
  input                            icache_tag1_cs,  
  input                            icache_tag1_we,  
  input  [`N101_ICACHE_TAG_RAM_AW-1:0] icache_tag1_addr, 
  input  [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag1_wdata,          
  output [`N101_ICACHE_TAG_RAM_DW-1:0] icache_tag1_rdata,
  input                        clk_icache_tag1,
  
  input                            icache_data1_cs,  
  input                            icache_data1_we,  
  input  [`N101_ICACHE_DATA_RAM_AW-1:0] icache_data1_addr, 
  input  [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data1_wdata,          
  output [`N101_ICACHE_DATA_RAM_DW-1:0] icache_data1_rdata,
  input                        clk_icache_data1,
    `endif
  `endif

  input  dummy

);


                                                      


  
  `ifdef N101_HAS_ICACHE 

  n101_icache_ram #(
    .DP(`N101_ICACHE_TAG_RAM_DP),
    .DW(`N101_ICACHE_TAG_RAM_DW),
    .MW(`N101_ICACHE_TAG_RAM_MW),
    .AW(`N101_ICACHE_TAG_RAM_AW) 
  )u_n101_icache_w0_tram (
    .sd   (1'b0   ),
    .ds   (1'b0   ),
    .ls   (1'b0   ),
  
    .cs   (icache_tag0_cs   ),
    .we   (icache_tag0_we   ),
    .addr (icache_tag0_addr ),
    .wem  ({`N101_ICACHE_TAG_RAM_MW{icache_tag0_we}}  ),
    .din  (icache_tag0_wdata  ),
    .dout (icache_tag0_rdata ),
    .rst_n(rst_icache_ram  ),
    .clk  (clk_icache_tag0  )
    );
    
    
  n101_icache_ram #(
    .DP(`N101_ICACHE_DRAM_DP),
    .DW(`N101_ICACHE_DATA_RAM_DW),
    .MW(`N101_ICACHE_DATA_RAM_MW),
    .AW(`N101_ICACHE_DATA_RAM_AW) 
  )u_n101_icache_w0_dram (
    .sd   (1'b0   ),
    .ds   (1'b0   ),
    .ls   (1'b0   ),
  
    .cs   (icache_data0_cs   ),
    .we   (icache_data0_we   ),
    .addr (icache_data0_addr ),
    .wem  ({`N101_ICACHE_DATA_RAM_MW{icache_data0_we}}  ),
    .din  (icache_data0_wdata  ),
    .dout (icache_data0_rdata ),
    .rst_n(rst_icache_ram  ),
    .clk  (clk_icache_data0  )
    );

     `ifdef N101_ICACHE_2WAYS
  n101_icache_ram #(
    .DP(`N101_ICACHE_TAG_RAM_DP),
    .DW(`N101_ICACHE_TAG_RAM_DW),
    .MW(`N101_ICACHE_TAG_RAM_MW),
    .AW(`N101_ICACHE_TAG_RAM_AW) 
  )u_n101_icache_w1_tram (
    .sd   (1'b0   ),
    .ds   (1'b0   ),
    .ls   (1'b0   ),
  
    .cs   (icache_tag1_cs   ),
    .we   (icache_tag1_we   ),
    .addr (icache_tag1_addr ),
    .wem  ({`N101_ICACHE_TAG_RAM_MW{icache_tag1_we}}  ),
    .din  (icache_tag1_wdata  ),
    .dout (icache_tag1_rdata ),
    .rst_n(rst_icache_ram  ),
    .clk  (clk_icache_tag1  )
    );


  n101_icache_ram#(
    .DP(`N101_ICACHE_DRAM_DP),
    .DW(`N101_ICACHE_DATA_RAM_DW),
    .MW(`N101_ICACHE_DATA_RAM_MW),
    .AW(`N101_ICACHE_DATA_RAM_AW) 
  )u_n101_icache_w1_dram (
    .sd   (1'b0   ),
    .ds   (1'b0   ),
    .ls   (1'b0   ),
  
    .cs   (icache_data1_cs   ),
    .we   (icache_data1_we   ),
    .addr (icache_data1_addr ),
    .wem  ({`N101_ICACHE_DATA_RAM_MW{icache_data1_we }} ),
    .din  (icache_data1_wdata  ),
    .dout (icache_data1_rdata ),
    .rst_n(rst_icache_ram  ),
    .clk  (clk_icache_data1  )
    );
    `endif

  `endif


endmodule
