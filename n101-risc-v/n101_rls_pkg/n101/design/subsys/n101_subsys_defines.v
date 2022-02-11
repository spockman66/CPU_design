 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         




















  `include "n101_defines.v"
  `define N101_CFG_ADDR_SIZE_IS_32

`ifndef N101_CFG_HAS_ILM
   `ifndef N101_CFG_ILM_ADDR_WIDTH
  `define N101_CFG_ILM_ADDR_WIDTH  16
   `endif
  `define N101_ILM_ADDR_WIDTH  `N101_CFG_ILM_ADDR_WIDTH
  
  
  
  `define N101_ILM_RAM_DP      (1<<(`N101_CFG_ILM_ADDR_WIDTH-2)) 
  `define N101_ILM_RAM_AW          (`N101_CFG_ILM_ADDR_WIDTH-2) 
  `define N101_ILM_BASE_REGION  `N101_ADDR_SIZE-1:`N101_ILM_ADDR_WIDTH
  
    `define N101_ILM_DATA_WIDTH_IS_32
    `define N101_ILM_DATA_WIDTH  32
    `define N101_ILM_WMSK_WIDTH  4
  
    `define N101_ILM_RAM_ECC_DW  7
    `define N101_ILM_RAM_ECC_MW  1
  `ifndef N101_HAS_ECC 
    `define N101_ILM_RAM_DW      `N101_ILM_DATA_WIDTH
    `define N101_ILM_RAM_MW      `N101_ILM_WMSK_WIDTH
    `define N101_ILM_OUTS_NUM 1 
  `endif
`endif







`ifndef N101_CFG_HAS_DLM
  
  `ifndef N101_CFG_DLM_ADDR_WIDTH
  `define N101_CFG_DLM_ADDR_WIDTH  16
  `endif

  `define N101_DLM_ADDR_WIDTH  `N101_CFG_DLM_ADDR_WIDTH
  
  
  
  `define N101_DLM_RAM_DP      (1<<(`N101_CFG_DLM_ADDR_WIDTH-2)) 
  `define N101_DLM_RAM_AW          (`N101_CFG_DLM_ADDR_WIDTH-2) 
  `define N101_DLM_BASE_REGION  `N101_ADDR_SIZE-1:`N101_DLM_ADDR_WIDTH
  
    `define N101_DLM_DATA_WIDTH_IS_32
    `define N101_DLM_DATA_WIDTH  32
    `define N101_DLM_WMSK_WIDTH  4
  
    `define N101_DLM_RAM_ECC_DW  7
    `define N101_DLM_RAM_ECC_MW  1
  `ifndef N101_HAS_ECC 
    `define N101_DLM_RAM_DW      `N101_DLM_DATA_WIDTH
    `define N101_DLM_RAM_MW      `N101_DLM_WMSK_WIDTH
    `define N101_DLM_OUTS_NUM 1 
  `endif
`endif









`ifndef N101_CFG_HAS_DEBUG
   `define N101_DEBUG_BASE_REGION  `N101_ADDR_SIZE-1:`N101_ADDR_SIZE-20
`endif


