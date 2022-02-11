 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















`include "n101_defines.v"
`include "n101_subsys_defines.v"

`ifdef N101_HAS_BUS_PARITY

module n101_subsys_bpty (

  input             bptylvl,

  `ifdef N101_HAS_ILM
  `ifdef N101_LM_ITF_TYPE_AHBL 
      
  input [1:0]       ilm_htrans,   
  input             ilm_hwrite,
  input             ilm_hmastlock,
  input [`N101_ILM_DATA_WIDTH-1:0] ilm_hwdata,   
  input [`N101_ILM_ADDR_WIDTH-1:0]ilm_haddr,    
  input [2:0]       ilm_hsize, 
  input [2:0]       ilm_hburst, 
  input [3:0]       ilm_hprot, 
                                      
                                      
                                      
  input  [`N101_ILM_DATA_WIDTH-1:0]ilm_hrdata,   
  input  [1:0]       ilm_hresp, 
  input              ilm_hready,   
       `ifdef N101_HAS_BUS_PARITY
  input  [1:0]       ilm_hcmdbpty,
  input  [3:0]       ilm_hwdatabpty,
  input  [3:0]       ilm_haddrbpty,

  output [3:0]       ilm_hrdatabpty,
  output             ilm_hrspbpty,
  input              ilm_phfatal,
       `endif
  `endif
  `endif

  `ifdef N101_HAS_DLM
  `ifdef N101_LM_ITF_TYPE_AHBL 
      
  input  [1:0]       dlm_htrans,   
  input              dlm_hwrite,
  input              dlm_hmastlock,
  input  [`N101_DLM_DATA_WIDTH-1:0] dlm_hwdata,   
  input  [`N101_DLM_ADDR_WIDTH-1:0] dlm_haddr,    
  input  [2:0]       dlm_hsize, 
  input  [2:0]       dlm_hburst, 
  input  [3:0]       dlm_hprot, 
                                      
                                      
  input  [1:0]       dlm_master,
                                      
  input  [`N101_DLM_DATA_WIDTH-1:0]dlm_hrdata,   
  input  [1:0]       dlm_hresp, 
  input              dlm_hready,   
       `ifdef N101_HAS_BUS_PARITY
  input  [1:0]       dlm_hcmdbpty,
  input  [3:0]       dlm_hwdatabpty,
  input  [3:0]       dlm_haddrbpty,

  output [3:0]       dlm_hrdatabpty,
  output             dlm_hrspbpty,
  input              dlm_phfatal,
       `endif
  `endif
  `endif

  `ifdef N101_HAS_MEM_ITF
  `ifdef N101_MEM_TYPE_AHBL 
      
  input  [1:0]       htrans,   
  input              hwrite,
  input              hmastlock,
  input  [`N101_XLEN    -1:0] hwdata,   
  input  [`N101_ADDR_SIZE    -1:0] haddr,    
  input  [2:0]       hsize, 
  input  [2:0]       hburst, 
  input  [3:0]       hprot, 
                                      
                                      
  input  [1:0]       master,
                                      
  input  [`N101_XLEN    -1:0]hrdata,   
  input  [1:0]       hresp, 
  input              hready,   
       `ifdef N101_HAS_BUS_PARITY
  input  [1:0]       hcmdbpty,
  input  [3:0]       hwdatabpty,
  input  [3:0]       haddrbpty,

  output [3:0]       hrdatabpty,
  output             hrspbpty,
  input              phfatal,
       `endif
  `endif
  `endif


  input  clk,
  input  rst_n
  );


`ifdef N101_LM_ITF_TYPE_AHBL 
`ifdef N101_HAS_ILM 
n101_subsys_ahb_bpty #(
  .ADDR_SIZE (`N101_ILM_ADDR_WIDTH)
 ) n101_subsys_ahb_ilm_bpty
(
    .bptylvl    (bptylvl       ),   
    .htrans     (ilm_htrans    ),
    .hsize      (ilm_hsize     ), 
    .hburst     (ilm_hburst    ),
    .hprot      (ilm_hprot     ), 
    .hwrite     (ilm_hwrite    ),   
    .hmastlock  (ilm_hmastlock ),   
    .master     (2'b0          ),
    .hwdata     (ilm_hwdata    ),   
    .haddr      (ilm_haddr     ),    
    .hrdata     (ilm_hrdata    ),   
    .hresp      (ilm_hresp     ),  
    .hready     (ilm_hready    ), 
    .hcmdbpty   (ilm_hcmdbpty  ),
    .hwdatabpty (ilm_hwdatabpty),
    .haddrbpty  (ilm_haddrbpty ),
    .hrspbpty   (ilm_hrspbpty  ),
    .hrdatabpty (ilm_hrdatabpty),
    .phfatal    (ilm_phfatal   ),
    .clk        (clk           ),   
    .rst_n      (rst_n         )
);
`endif


`ifdef N101_HAS_DLM 
n101_subsys_ahb_bpty #(
  .ADDR_SIZE (`N101_DLM_ADDR_WIDTH)
 ) n101_subsys_ahb_dlm_bpty
(
    .bptylvl    (bptylvl       ),   
    .htrans     (dlm_htrans    ),
    .hsize      (dlm_hsize     ), 
    .hburst     (dlm_hburst    ),
    .hprot      (dlm_hprot     ), 
    .hwrite     (dlm_hwrite    ),   
    .hmastlock  (dlm_hmastlock ),   
    .master     (dlm_master    ),
    .hwdata     (dlm_hwdata    ),   
    .haddr      (dlm_haddr     ),    
    .hrdata     (dlm_hrdata    ),   
    .hresp      (dlm_hresp     ),  
    .hready     (dlm_hready    ), 
    .hcmdbpty   (dlm_hcmdbpty  ),
    .hwdatabpty (dlm_hwdatabpty),
    .haddrbpty  (dlm_haddrbpty ),
    .hrspbpty   (dlm_hrspbpty  ),
    .hrdatabpty (dlm_hrdatabpty),
    .phfatal    (dlm_phfatal   ),
    .clk        (clk           ),   
    .rst_n      (rst_n         )
);
`endif

`endif

`ifdef N101_HAS_MEM_ITF 
`ifdef N101_MEM_TYPE_AHBL 
n101_subsys_ahb_bpty #(
  .ADDR_SIZE (`N101_ADDR_SIZE)
 ) n101_subsys_ahb_mem_bpty
(
    .bptylvl    (bptylvl       ),   
    .htrans     (htrans        ),
    .hsize      (hsize         ), 
    .hburst     (hburst        ),
    .hprot      (hprot         ), 
    .hwrite     (hwrite        ),   
    .hmastlock  (hmastlock     ),   
    .master     (master        ),
    .hwdata     (hwdata        ),   
    .haddr      (haddr         ),    
    .hrdata     (hrdata        ),   
    .hresp      (hresp         ),  
    .hready     (hready        ), 
    .hcmdbpty   (hcmdbpty      ),
    .hwdatabpty (hwdatabpty    ),
    .haddrbpty  (haddrbpty     ),
    .hrspbpty   (hrspbpty      ),
    .hrdatabpty (hrdatabpty    ),
    .phfatal    (phfatal       ),
    .clk        (clk           ),   
    .rst_n      (rst_n         )
);
`endif
`endif







  endmodule

`endif
