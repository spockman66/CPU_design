 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         


















`include "n101_defines.v"
`include "n101_subsys_defines.v"



module n101_ilm_ram(

  input                              sd,
  input                              ds,
  input                              ls,

  input                              cs,  
  input                              we,  
  input  [`N101_ILM_RAM_AW-1:0] addr, 
  input  [`N101_ILM_RAM_MW-1:0] wem,
  input  [`N101_ILM_RAM_DW-1:0] din,          
  output [`N101_ILM_RAM_DW-1:0] dout,
  input                              rst_n,
  input                              clk

);

  n101_gnrl_ram #(
      `ifndef N101_HAS_ECC
    .FORCE_X2ZERO(0),
      `endif
    .DP(`N101_ILM_RAM_DP),
    .DW(`N101_ILM_RAM_DW),
    .MW(`N101_ILM_RAM_MW),
    .AW(`N101_ILM_RAM_AW) 
  ) u_n101_ilm_gnrl_ram(
  .sd  (sd  ),
  .ds  (ds  ),
  .ls  (ls  ),

  .rst_n (rst_n ),
  .clk (clk ),
  .cs  (cs  ),
  .we  (we  ),
  .addr(addr),
  .din (din ),
  .wem (wem ),
  .dout(dout)
  );
                                                      
endmodule
