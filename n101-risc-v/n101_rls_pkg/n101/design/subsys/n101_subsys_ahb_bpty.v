 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         


















`include "n101_defines.v" 

`ifdef N101_HAS_BUS_PARITY

module n101_subsys_ahb_bpty #(
  parameter ADDR_SIZE = 32
 )
(
  input                            bptylvl    ,   
  input  [1:0]                     htrans     ,
  input  [2:0]                     hsize      , 
  input  [2:0]                     hburst     ,
  input  [3:0]                     hprot      , 
  input                            hwrite     ,   
  input                            hmastlock  ,   
  input  [1:0]                     master     ,
  input  [`N101_XLEN-1:0]          hwdata     ,   
  input  [ADDR_SIZE-1:0]           haddr      ,    
  input  [`N101_XLEN-1:0]          hrdata     ,   
  input  [1:0]                     hresp      ,  
  input                            hready     , 
  input  [1:0]                     hcmdbpty   ,
  input  [3:0]                     hwdatabpty ,
  input  [3:0]                     haddrbpty  ,
  output                           hrspbpty   ,
  output [3:0]                     hrdatabpty ,
  input                            phfatal    ,
  input                            clk        ,   
  input                            rst_n   
);



wire [3:0]  hrdatabpty_pre;


n101_parity_gen # (
  .DW (8)
) u_n101_parity_gen0 (
    .i_dat      (hrdata[7:0]          ),
    .parity_bit (hrdatabpty_pre[0]    )
);

n101_parity_gen # (
  .DW (8)
) u_n101_parity_gen1 (
    .i_dat      (hrdata[15:8]         ),
    .parity_bit (hrdatabpty_pre[1]    )
);

n101_parity_gen # (
  .DW (8)
) u_n101_parity_gen2 (
    .i_dat      (hrdata[23:16]        ),
    .parity_bit (hrdatabpty_pre[2]    )
);

n101_parity_gen # (
  .DW (8)
) u_n101_parity_gen3 (
    .i_dat      (hrdata[31:24]        ),
    .parity_bit (hrdatabpty_pre[3]    )
);

assign hrdatabpty = bptylvl ? ~hrdatabpty_pre : hrdatabpty_pre;


wire hrspbpty_pre;


wire [7:0] hrspbpack = {5'b0, hresp, hready};

n101_parity_gen # (
  .DW (8)
) u_n101_parity_gen4 (
    .i_dat      (hrspbpack[7:0]   ),
    .parity_bit (hrspbpty_pre     )
);

assign hrspbpty = bptylvl ? ~hrspbpty_pre : hrspbpty_pre;

endmodule 

`endif
