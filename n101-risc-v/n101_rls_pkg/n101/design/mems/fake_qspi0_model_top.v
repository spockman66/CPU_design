 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         






`ifdef FAKE_FLASH_MODEL
module fake_qspi0_model_top (
  
  input  icb_cmd_valid, 
  output icb_cmd_ready, 
  input  [32-1:0] icb_cmd_addr, 
  input  icb_cmd_read,   
  input  [32-1:0] icb_cmd_wdata,

  
  output icb_rsp_valid, 
  input  icb_rsp_ready, 
  output [32-1:0] icb_rsp_rdata, 

  input  clk,
  input  rst_n
  );
        
  wire [32-1:0] model_dout; 

  assign icb_rsp_valid = icb_cmd_valid;
  assign icb_cmd_ready = icb_rsp_ready;
  assign icb_rsp_rdata = model_dout;


   fake_qspi0_model u_fake_qspi0_model (
     .model_addr (icb_cmd_addr[31:2]),
     .model_dout (model_dout) 
   );

endmodule
`endif
