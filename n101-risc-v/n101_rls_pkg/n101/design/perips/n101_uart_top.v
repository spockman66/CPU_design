


















module n101_uart_top(
  input   clk,
  input   rst_n,

  input                      i_icb_cmd_valid,
  output                     i_icb_cmd_ready,
  input  [`N101_ADDR_SIZE-1:0]            i_icb_cmd_addr, 
  input                      i_icb_cmd_read, 
  input  [32-1:0]            i_icb_cmd_wdata,
  
  output                     i_icb_rsp_valid,
  input                      i_icb_rsp_ready,
  output [32-1:0]            i_icb_rsp_rdata,

  output  io_interrupts_0_0,                
  output  io_port_txd,
  input   io_port_rxd
);

  wire  io_in_0_a_ready;
  assign  i_icb_cmd_ready  = io_in_0_a_ready;
  wire  io_in_0_a_valid  = i_icb_cmd_valid;
  wire  [2:0] io_in_0_a_bits_opcode  = i_icb_cmd_read ? 3'h4 : 3'h0;
  wire  [2:0] io_in_0_a_bits_param  = 3'b0;
  wire  [2:0] io_in_0_a_bits_size = 3'd2;
  wire  [4:0] io_in_0_a_bits_source  = 5'b0;
  wire  [28:0] io_in_0_a_bits_address  = {9'b0,i_icb_cmd_addr[19:0]};
  wire  [3:0] io_in_0_a_bits_mask  = 4'b1111;
  wire  [31:0] io_in_0_a_bits_data  = i_icb_cmd_wdata;

  
  wire  io_in_0_d_ready = i_icb_rsp_ready;

  wire  [2:0] io_in_0_d_bits_opcode;
  wire  [1:0] io_in_0_d_bits_param;
  wire  [2:0] io_in_0_d_bits_size;
  wire  [4:0] io_in_0_d_bits_source;
  wire  io_in_0_d_bits_sink;
  wire  [1:0] io_in_0_d_bits_addr_lo;
  wire  [31:0] io_in_0_d_bits_data;
  wire  io_in_0_d_bits_error;
  wire  io_in_0_d_valid;

  assign  i_icb_rsp_valid = io_in_0_d_valid;
  assign  i_icb_rsp_rdata = io_in_0_d_bits_data;

  
  wire  io_in_0_b_ready = 1'b0;
  wire  io_in_0_b_valid;
  wire  [2:0] io_in_0_b_bits_opcode;
  wire  [1:0] io_in_0_b_bits_param;
  wire  [2:0] io_in_0_b_bits_size;
  wire  [4:0] io_in_0_b_bits_source;
  wire  [28:0] io_in_0_b_bits_address;
  wire  [3:0] io_in_0_b_bits_mask;
  wire  [31:0] io_in_0_b_bits_data;

  
  wire  io_in_0_c_ready;
  wire  io_in_0_c_valid = 1'b0;
  wire  [2:0] io_in_0_c_bits_opcode = 3'b0;
  wire  [2:0] io_in_0_c_bits_param = 3'b0;
  wire  [2:0] io_in_0_c_bits_size = 3'd2;
  wire  [4:0] io_in_0_c_bits_source = 5'b0;
  wire  [28:0] io_in_0_c_bits_address = 29'b0;
  wire  [31:0] io_in_0_c_bits_data = 32'b0;
  wire  io_in_0_c_bits_error = 1'b0;

  
  wire  io_in_0_e_ready;
  wire  io_in_0_e_valid = 1'b0;
  wire  io_in_0_e_bits_sink = 1'b0;

n101_uart u_n101_uart(
  .clock                            (clk                              ),
  .reset                            (~rst_n                            ),
  .io_interrupts_0_0                (io_interrupts_0_0                ),

  .io_in_0_a_ready                  (io_in_0_a_ready                  ),
  .io_in_0_a_valid                  (io_in_0_a_valid                  ),
  .io_in_0_a_bits_opcode            (io_in_0_a_bits_opcode            ),
  .io_in_0_a_bits_param             (io_in_0_a_bits_param             ),
  .io_in_0_a_bits_size              (io_in_0_a_bits_size              ),
  .io_in_0_a_bits_source            (io_in_0_a_bits_source            ),
  .io_in_0_a_bits_address           (io_in_0_a_bits_address           ),
  .io_in_0_a_bits_mask              (io_in_0_a_bits_mask              ),
  .io_in_0_a_bits_data              (io_in_0_a_bits_data              ),
  .io_in_0_b_ready                  (io_in_0_b_ready                  ),
  .io_in_0_b_valid                  (io_in_0_b_valid                  ),
  .io_in_0_b_bits_opcode            (io_in_0_b_bits_opcode            ),
  .io_in_0_b_bits_param             (io_in_0_b_bits_param             ),
  .io_in_0_b_bits_size              (io_in_0_b_bits_size              ),
  .io_in_0_b_bits_source            (io_in_0_b_bits_source            ),
  .io_in_0_b_bits_address           (io_in_0_b_bits_address           ),
  .io_in_0_b_bits_mask              (io_in_0_b_bits_mask              ),
  .io_in_0_b_bits_data              (io_in_0_b_bits_data              ),
  .io_in_0_c_ready                  (io_in_0_c_ready                  ),
  .io_in_0_c_valid                  (io_in_0_c_valid                  ),
  .io_in_0_c_bits_opcode            (io_in_0_c_bits_opcode            ),
  .io_in_0_c_bits_param             (io_in_0_c_bits_param             ),
  .io_in_0_c_bits_size              (io_in_0_c_bits_size              ),
  .io_in_0_c_bits_source            (io_in_0_c_bits_source            ),
  .io_in_0_c_bits_address           (io_in_0_c_bits_address           ),
  .io_in_0_c_bits_data              (io_in_0_c_bits_data              ),
  .io_in_0_c_bits_error             (io_in_0_c_bits_error             ),
  .io_in_0_d_ready                  (io_in_0_d_ready                  ),
  .io_in_0_d_valid                  (io_in_0_d_valid                  ),
  .io_in_0_d_bits_opcode            (io_in_0_d_bits_opcode            ),
  .io_in_0_d_bits_param             (io_in_0_d_bits_param             ),
  .io_in_0_d_bits_size              (io_in_0_d_bits_size              ),
  .io_in_0_d_bits_source            (io_in_0_d_bits_source            ),
  .io_in_0_d_bits_sink              (io_in_0_d_bits_sink              ),
  .io_in_0_d_bits_addr_lo           (io_in_0_d_bits_addr_lo           ),
  .io_in_0_d_bits_data              (io_in_0_d_bits_data              ),
  .io_in_0_d_bits_error             (io_in_0_d_bits_error             ),
  .io_in_0_e_ready                  (io_in_0_e_ready                  ),
  .io_in_0_e_valid                  (io_in_0_e_valid                  ),
  .io_in_0_e_bits_sink              (io_in_0_e_bits_sink              ),

  .io_port_txd                      (io_port_txd                      ),
  .io_port_rxd                      (io_port_rxd                      ) 
);

endmodule
