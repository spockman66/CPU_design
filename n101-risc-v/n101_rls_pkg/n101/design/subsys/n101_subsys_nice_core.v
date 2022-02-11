 /*                                                                      
  *  Copyright (c) 2018-2019 Nuclei System Technology, Inc.              
  *  All rights reserved.                                                
  */                                                                     
                                                                         


















`include "n101_defines.v"

`ifdef N101_HAS_NICE
module n101_subsys_nice_core (
    
    input                         nice_clk             ,
    input                         nice_rst_n	          ,
    output                        nice_active	      ,
    output                        nice_mem_holdup	  ,

    
    input                         nice_req_valid       ,
    output                        nice_req_ready       ,
    input  [`N101_XLEN-1:0]       nice_req_inst        ,
    input  [`N101_XLEN-1:0]       nice_req_rs1         ,
    input  [`N101_XLEN-1:0]       nice_req_rs2         ,
    input                         nice_req_mmode       ,

    
    output                        nice_1cyc_type       ,
    output [`N101_XLEN-1:0]       nice_1cyc_rdat       ,	
    output                        nice_1cyc_err        ,
    
    output                        nice_rsp_valid       ,
    input                         nice_rsp_ready       ,
    output [`N101_XLEN-1:0]       nice_rsp_rdat        ,
    output                        nice_rsp_err    	  ,

    
    output                        nice_icb_cmd_valid   ,
    input                         nice_icb_cmd_ready   ,
    output [`N101_ADDR_SIZE-1:0]  nice_icb_cmd_addr    ,
    output                        nice_icb_cmd_read    ,
    output [`N101_XLEN-1:0]       nice_icb_cmd_wdata   ,

    output [1:0]                  nice_icb_cmd_size    ,
    output                        nice_icb_cmd_mmode   ,
    
    input                         nice_icb_rsp_valid   ,
    output                        nice_icb_rsp_ready   ,
    input  [`N101_XLEN-1:0]       nice_icb_rsp_rdata   ,
    input                         nice_icb_rsp_err	

);

   localparam ROWBUF_DP = 4;
   localparam ROWBUF_IDX_W = 2;
   localparam ROW_IDX_W = 2;
   localparam COL_IDX_W = 4;
   localparam PIPE_NUM = 3;























   
   
   
   wire [6:0] opcode      = {7{nice_req_valid}} & nice_req_inst[6:0];
   wire [2:0] rv32_func3  = {3{nice_req_valid}} & nice_req_inst[14:12];
   wire [6:0] rv32_func7  = {7{nice_req_valid}} & nice_req_inst[31:25];




   wire opcode_custom3 = (opcode == 7'b1111011); 

   wire rv32_func3_000 = (rv32_func3 == 3'b000); 
   wire rv32_func3_001 = (rv32_func3 == 3'b001); 
   wire rv32_func3_010 = (rv32_func3 == 3'b010); 
   wire rv32_func3_011 = (rv32_func3 == 3'b011); 
   wire rv32_func3_100 = (rv32_func3 == 3'b100); 
   wire rv32_func3_101 = (rv32_func3 == 3'b101); 
   wire rv32_func3_110 = (rv32_func3 == 3'b110); 
   wire rv32_func3_111 = (rv32_func3 == 3'b111); 

   wire rv32_func7_0000000 = (rv32_func7 == 7'b0000000); 
   wire rv32_func7_0000001 = (rv32_func7 == 7'b0000001); 
   wire rv32_func7_0000010 = (rv32_func7 == 7'b0000010); 
   wire rv32_func7_0000011 = (rv32_func7 == 7'b0000011); 
   wire rv32_func7_0000100 = (rv32_func7 == 7'b0000100); 
   wire rv32_func7_0000101 = (rv32_func7 == 7'b0000101); 
   wire rv32_func7_0000110 = (rv32_func7 == 7'b0000110); 
   wire rv32_func7_0000111 = (rv32_func7 == 7'b0000111); 

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   wire custom3_add      = opcode_custom3 & rv32_func3_111 & rv32_func7_0000000; 
   wire custom3_lbuf     = opcode_custom3 & rv32_func3_010 & rv32_func7_0000001; 
   wire custom3_sbuf     = opcode_custom3 & rv32_func3_010 & rv32_func7_0000010; 
   wire custom3_pipeadd  = opcode_custom3 & rv32_func3_111 & rv32_func7_0000011; 
   wire custom3_wsetup   = opcode_custom3 & rv32_func3_010 & rv32_func7_0000100; 
   wire custom3_rsetup   = opcode_custom3 & rv32_func3_100 & rv32_func7_0000101; 
   wire custom3_rowsum   = opcode_custom3 & rv32_func3_110 & rv32_func7_0000110; 
   wire custom3_crowbuf  = opcode_custom3 & rv32_func3_000 & rv32_func7_0000111; 

   
   
   
   wire custom_1cyc_op = custom3_add | custom3_wsetup | custom3_rsetup | custom3_crowbuf;

   
   
   
   wire custom_multi_cyc_op = custom3_lbuf | custom3_sbuf | custom3_pipeadd | custom3_rowsum;
   
   wire custom_mem_op = custom3_lbuf | custom3_sbuf | custom3_rowsum;
 
   
   
   
   parameter NICE_FSM_WIDTH = 3; 
   parameter IDLE     = 3'd0; 
   parameter LBUF     = 3'd1; 
   parameter SBUF     = 3'd2; 
   parameter PIPE     = 3'd3; 
   parameter ROWSUM   = 3'd4; 

   wire [NICE_FSM_WIDTH-1:0] state_r; 
   wire [NICE_FSM_WIDTH-1:0] nxt_state; 
   wire [NICE_FSM_WIDTH-1:0] state_idle_nxt; 
   wire [NICE_FSM_WIDTH-1:0] state_lbuf_nxt; 
   wire [NICE_FSM_WIDTH-1:0] state_sbuf_nxt; 
   wire [NICE_FSM_WIDTH-1:0] state_pipe_nxt; 
   wire [NICE_FSM_WIDTH-1:0] state_rowsum_nxt; 

   wire nice_req_hsked;
   wire nice_rsp_hsked;
   wire nice_icb_rsp_hsked;
   wire illgel_instr = ~(custom_1cyc_op | custom_multi_cyc_op);

   wire state_idle_exit_ena; 
   wire state_lbuf_exit_ena; 
   wire state_sbuf_exit_ena; 
   wire state_pipe_exit_ena; 
   wire state_rowsum_exit_ena; 
   wire state_rbuf_exit_ena; 
   wire state_ena; 

   wire state_is_idle     = (state_r == IDLE); 
   wire state_is_lbuf     = (state_r == LBUF); 
   wire state_is_sbuf     = (state_r == SBUF); 
   wire state_is_pipe     = (state_r == PIPE); 
   wire state_is_rowsum   = (state_r == ROWSUM); 

   assign state_idle_exit_ena = state_is_idle & nice_req_hsked & ~custom_1cyc_op & ~illgel_instr; 
   assign state_idle_nxt =  custom3_lbuf    ? LBUF   : 
                            custom3_sbuf    ? SBUF   :
                            custom3_pipeadd ? PIPE   :
                            ROWSUM;

   wire lbuf_icb_rsp_hsked_last; 
   assign state_lbuf_exit_ena = state_is_lbuf & lbuf_icb_rsp_hsked_last; 
   assign state_lbuf_nxt = IDLE;

   wire sbuf_icb_rsp_hsked_last; 
   assign state_sbuf_exit_ena = state_is_sbuf & sbuf_icb_rsp_hsked_last; 
   assign state_sbuf_nxt = IDLE;

   wire pipe_empty; 
   assign state_pipe_exit_ena = state_is_pipe & pipe_empty; 
   assign state_pipe_nxt = IDLE;

   wire rowsum_done; 
   assign state_rowsum_exit_ena = state_is_rowsum & rowsum_done; 
   assign state_rowsum_nxt = IDLE;

   assign nxt_state =   ({NICE_FSM_WIDTH{state_idle_exit_ena   }} & state_idle_nxt   )
                      | ({NICE_FSM_WIDTH{state_lbuf_exit_ena   }} & state_lbuf_nxt   ) 
                      | ({NICE_FSM_WIDTH{state_sbuf_exit_ena   }} & state_sbuf_nxt   ) 
                      | ({NICE_FSM_WIDTH{state_pipe_exit_ena   }} & state_pipe_nxt   ) 
                      | ({NICE_FSM_WIDTH{state_rowsum_exit_ena }} & state_rowsum_nxt ) 
                      ;

   assign state_ena =   state_idle_exit_ena | state_lbuf_exit_ena   | state_sbuf_exit_ena
                      | state_pipe_exit_ena | state_rowsum_exit_ena;

   n101_gnrl_dfflr #(NICE_FSM_WIDTH)   state_dfflr (state_ena, nxt_state, state_r, nice_clk, nice_rst_n);

   
   
   
   wire [ROW_IDX_W-1:0]  clonum = 2'b10;  
   
   wire [`N101_XLEN-1:0] custom3_add_res  = nice_req_rs1 + nice_req_rs2; 

   
   wire [ROWBUF_IDX_W-1:0] lbuf_cnt_r; 
   wire [ROWBUF_IDX_W-1:0] lbuf_cnt_nxt; 
   wire lbuf_cnt_clr;
   wire lbuf_cnt_incr;
   wire lbuf_cnt_ena;
   wire lbuf_cnt_last;
   wire lbuf_icb_rsp_hsked;
   wire nice_rsp_valid_lbuf;
   wire nice_icb_cmd_valid_lbuf;

   assign lbuf_icb_rsp_hsked = state_is_lbuf & nice_icb_rsp_hsked;
   assign lbuf_icb_rsp_hsked_last = lbuf_icb_rsp_hsked & lbuf_cnt_last;
   assign lbuf_cnt_last = (lbuf_cnt_r == clonum);
   assign lbuf_cnt_clr = custom3_lbuf & nice_req_hsked;
   assign lbuf_cnt_incr = lbuf_icb_rsp_hsked & ~lbuf_cnt_last;
   assign lbuf_cnt_ena = lbuf_cnt_clr | lbuf_cnt_incr;
   assign lbuf_cnt_nxt =   ({ROWBUF_IDX_W{lbuf_cnt_clr }} & {ROWBUF_IDX_W{1'b0}})
                         | ({ROWBUF_IDX_W{lbuf_cnt_incr}} & (lbuf_cnt_r + 1'b1) )
                         ;

   n101_gnrl_dfflr #(ROWBUF_IDX_W)   lbuf_cnt_dfflr (lbuf_cnt_ena, lbuf_cnt_nxt, lbuf_cnt_r, nice_clk, nice_rst_n);

   
   assign nice_rsp_valid_lbuf = state_is_lbuf & lbuf_cnt_last & nice_icb_rsp_valid;

   
   assign nice_icb_cmd_valid_lbuf = (state_is_lbuf & (lbuf_cnt_r < clonum));

   
   wire [ROWBUF_IDX_W-1:0] sbuf_cnt_r; 
   wire [ROWBUF_IDX_W-1:0] sbuf_cnt_nxt; 
   wire sbuf_cnt_clr;
   wire sbuf_cnt_incr;
   wire sbuf_cnt_ena;
   wire sbuf_cnt_last;
   wire sbuf_icb_cmd_hsked;
   wire sbuf_icb_rsp_hsked;
   wire nice_rsp_valid_sbuf;
   wire nice_icb_cmd_valid_sbuf;
   wire nice_icb_cmd_hsked;

   assign sbuf_icb_cmd_hsked = (state_is_sbuf | (state_is_idle & custom3_sbuf)) & nice_icb_cmd_hsked;
   assign sbuf_icb_rsp_hsked = state_is_sbuf & nice_icb_rsp_hsked;
   assign sbuf_icb_rsp_hsked_last = sbuf_icb_rsp_hsked & sbuf_cnt_last;
   assign sbuf_cnt_last = (sbuf_cnt_r == clonum);
   
   assign sbuf_cnt_clr = sbuf_icb_rsp_hsked_last;
   assign sbuf_cnt_incr = sbuf_icb_rsp_hsked & ~sbuf_cnt_last;
   assign sbuf_cnt_ena = sbuf_cnt_clr | sbuf_cnt_incr;
   assign sbuf_cnt_nxt =   ({ROWBUF_IDX_W{sbuf_cnt_clr }} & {ROWBUF_IDX_W{1'b0}})
                         | ({ROWBUF_IDX_W{sbuf_cnt_incr}} & (sbuf_cnt_r + 1'b1) )
                         ;

   n101_gnrl_dfflr #(ROWBUF_IDX_W)   sbuf_cnt_dfflr (sbuf_cnt_ena, sbuf_cnt_nxt, sbuf_cnt_r, nice_clk, nice_rst_n);

   
   assign nice_rsp_valid_sbuf = state_is_sbuf & sbuf_cnt_last & nice_icb_rsp_valid;

   wire [ROWBUF_IDX_W-1:0] sbuf_cmd_cnt_r; 
   wire [ROWBUF_IDX_W-1:0] sbuf_cmd_cnt_nxt; 
   wire sbuf_cmd_cnt_clr;
   wire sbuf_cmd_cnt_incr;
   wire sbuf_cmd_cnt_ena;
   wire sbuf_cmd_cnt_last;

   assign sbuf_cmd_cnt_last = (sbuf_cmd_cnt_r == clonum);
   assign sbuf_cmd_cnt_clr = sbuf_icb_rsp_hsked_last;
   assign sbuf_cmd_cnt_incr = sbuf_icb_cmd_hsked & ~sbuf_cmd_cnt_last;
   assign sbuf_cmd_cnt_ena = sbuf_cmd_cnt_clr | sbuf_cmd_cnt_incr;
   assign sbuf_cmd_cnt_nxt =   ({ROWBUF_IDX_W{sbuf_cmd_cnt_clr }} & {ROWBUF_IDX_W{1'b0}})
                             | ({ROWBUF_IDX_W{sbuf_cmd_cnt_incr}} & (sbuf_cmd_cnt_r + 1'b1) )
                             ;
   n101_gnrl_dfflr #(ROWBUF_IDX_W)   sbuf_cmd_cnt_dfflr (sbuf_cmd_cnt_ena, sbuf_cmd_cnt_nxt, sbuf_cmd_cnt_r, nice_clk, nice_rst_n);

   
   assign nice_icb_cmd_valid_sbuf = (state_is_sbuf & (sbuf_cmd_cnt_r <= clonum) & (sbuf_cnt_r != clonum));

   
   wire pipe_req_hsked = (custom3_pipeadd & nice_req_hsked) | (state_is_pipe & nice_req_hsked);
   wire pipe_req_valid = (custom3_pipeadd & nice_req_valid);
   wire pipe_rsp_hsked = state_is_pipe & nice_rsp_hsked;
   wire pipe_rsp_ready = state_is_pipe & nice_rsp_ready;
   wire [`N101_XLEN-1:0] pipe_res_pre = nice_req_rs1 + nice_req_rs2; 
   wire [`N101_XLEN-1:0] pipe_res;
   wire state_pipe_req_ready;
   wire nice_rsp_valid_pipe;

   wire [`N101_XLEN-1:0] i_pipe_pack [PIPE_NUM-1:0];
   wire [`N101_XLEN-1:0] o_pipe_pack [PIPE_NUM-1:0];
   wire [PIPE_NUM-1:0] i_pipe_vld;
   wire [PIPE_NUM-1:0] i_pipe_rdy;
   wire [PIPE_NUM-1:0] o_pipe_vld;
   wire [PIPE_NUM-1:0] o_pipe_rdy;

   assign i_pipe_vld = {o_pipe_vld[PIPE_NUM-2:0], pipe_req_valid};
   assign o_pipe_rdy = {nice_rsp_ready, i_pipe_rdy[PIPE_NUM-1:1]};
   assign pipe_res = o_pipe_pack[PIPE_NUM-1];
   assign state_pipe_req_ready = state_is_pipe & i_pipe_rdy[0] & custom3_pipeadd;
   assign pipe_empty = ~(|o_pipe_vld[PIPE_NUM-2:0]) & o_pipe_vld[PIPE_NUM-1] & ~pipe_req_hsked & nice_rsp_hsked ; 

   
   assign nice_rsp_valid_pipe = state_is_pipe & o_pipe_vld[PIPE_NUM-1];


   genvar i;
   generate 
     for (i=0; i<PIPE_NUM; i=i+1) begin:gen_pipe_stage
       if(i==0) begin: pipe_0
         assign i_pipe_pack[i] = pipe_res_pre;
       end
       else begin
         assign i_pipe_pack[i] = o_pipe_pack[i-1];
       end

       n101_gnrl_pipe_stage # (
         .CUT_READY(0),
         .DP(1),
         .DW(`N101_XLEN)
       ) nice_pipe_stage (
         .i_vld(i_pipe_vld[i]), 
         .i_rdy(i_pipe_rdy[i]), 
         .i_dat(i_pipe_pack[i]),
         .o_vld(o_pipe_vld[i]), 
         .o_rdy(o_pipe_rdy[i]), 
         .o_dat(o_pipe_pack[i]),
         .clk  (nice_clk),
         .rst_n(nice_rst_n)  
       );
     end
   endgenerate

   
   
   
   
   
   
   
   
   wire matrix_cfg_ena = custom3_wsetup & nice_req_hsked;
   wire [`N101_XLEN-1:0] matrix_cfg_nxt = {{`N101_XLEN-ROW_IDX_W{1'b0}},nice_req_rs1[ROW_IDX_W-1:0]};
   wire [`N101_XLEN-1:0] matrix_cfg_r;
   
   n101_gnrl_dfflr #(`N101_XLEN)   matrix_cfg_dfflr (matrix_cfg_ena, matrix_cfg_nxt, matrix_cfg_r, nice_clk, nice_rst_n);

   
   wire [`N101_XLEN-1:0] custom3_rsetup_res = ({`N101_XLEN{custom3_rsetup}} & matrix_cfg_r); 

   
   
   wire [ROWBUF_IDX_W-1:0] rowbuf_cnt_r; 
   wire [ROWBUF_IDX_W-1:0] rowbuf_cnt_nxt; 
   wire rowbuf_cnt_clr;
   wire rowbuf_cnt_incr;
   wire rowbuf_cnt_ena;
   wire rowbuf_cnt_last;
   wire rowbuf_icb_rsp_hsked;
   wire rowbuf_rsp_hsked;
   wire nice_rsp_valid_rowsum;

   assign rowbuf_rsp_hsked = nice_rsp_valid_rowsum & nice_rsp_ready;
   assign rowbuf_icb_rsp_hsked = state_is_rowsum & nice_icb_rsp_hsked;
   assign rowbuf_cnt_last = (rowbuf_cnt_r == clonum);
   assign rowbuf_cnt_clr = rowbuf_icb_rsp_hsked & rowbuf_cnt_last;
   assign rowbuf_cnt_incr = rowbuf_icb_rsp_hsked & ~rowbuf_cnt_last;
   assign rowbuf_cnt_ena = rowbuf_cnt_clr | rowbuf_cnt_incr;
   assign rowbuf_cnt_nxt =   ({ROWBUF_IDX_W{rowbuf_cnt_clr }} & {ROWBUF_IDX_W{1'b0}})
                           | ({ROWBUF_IDX_W{rowbuf_cnt_incr}} & (rowbuf_cnt_r + 1'b1))
                           ;
   
   
   

   n101_gnrl_dfflr #(ROWBUF_IDX_W)   rowbuf_cnt_dfflr (rowbuf_cnt_ena, rowbuf_cnt_nxt, rowbuf_cnt_r, nice_clk, nice_rst_n);

   
   wire rcv_data_buf_ena;
   wire rcv_data_buf_set;
   wire rcv_data_buf_clr;
   wire rcv_data_buf_valid;
   wire [`N101_XLEN-1:0] rcv_data_buf; 
   wire [ROWBUF_IDX_W-1:0] rcv_data_buf_idx; 
   wire [ROWBUF_IDX_W-1:0] rcv_data_buf_idx_nxt; 

   assign rcv_data_buf_set = rowbuf_icb_rsp_hsked;
   assign rcv_data_buf_clr = rowbuf_rsp_hsked;
   assign rcv_data_buf_ena = rcv_data_buf_clr | rcv_data_buf_set;
   assign rcv_data_buf_idx_nxt =   ({ROWBUF_IDX_W{rcv_data_buf_clr}} & {ROWBUF_IDX_W{1'b0}})
                                 | ({ROWBUF_IDX_W{rcv_data_buf_set}} & rowbuf_cnt_r        );

   n101_gnrl_dfflr #(1)   rcv_data_buf_valid_dfflr (1'b1, rcv_data_buf_ena, rcv_data_buf_valid, nice_clk, nice_rst_n);
   n101_gnrl_dfflr #(`N101_XLEN)   rcv_data_buf_dfflr (rcv_data_buf_ena, nice_icb_rsp_rdata, rcv_data_buf, nice_clk, nice_rst_n);
   n101_gnrl_dfflr #(ROWBUF_IDX_W)   rowbuf_cnt_d_dfflr (rcv_data_buf_ena, rcv_data_buf_idx_nxt, rcv_data_buf_idx, nice_clk, nice_rst_n);

   
   wire [`N101_XLEN-1:0] rowsum_acc_r;
   wire [`N101_XLEN-1:0] rowsum_acc_nxt;
   wire [`N101_XLEN-1:0] rowsum_acc_adder;
   wire rowsum_acc_ena;
   wire rowsum_acc_set;
   wire rowsum_acc_flg;
   wire nice_icb_cmd_valid_rowsum;
   wire [`N101_XLEN-1:0] rowsum_res;

   assign rowsum_acc_set = rcv_data_buf_valid & (rcv_data_buf_idx == {ROWBUF_IDX_W{1'b0}});
   assign rowsum_acc_flg = rcv_data_buf_valid & (rcv_data_buf_idx != {ROWBUF_IDX_W{1'b0}});
   assign rowsum_acc_adder = rcv_data_buf + rowsum_acc_r;
   assign rowsum_acc_ena = rowsum_acc_set | rowsum_acc_flg;
   assign rowsum_acc_nxt =   ({`N101_XLEN{rowsum_acc_set}} & rcv_data_buf)
                           | ({`N101_XLEN{rowsum_acc_flg}} & rowsum_acc_adder)
                           ;
 
   n101_gnrl_dfflr #(`N101_XLEN)   rowsum_acc_dfflr (rowsum_acc_ena, rowsum_acc_nxt, rowsum_acc_r, nice_clk, nice_rst_n);

   assign rowsum_done = state_is_rowsum & nice_rsp_hsked;
   assign rowsum_res  = rowsum_acc_r;

   
   assign nice_rsp_valid_rowsum = state_is_rowsum & (rcv_data_buf_idx == clonum) & ~rowsum_acc_flg;

   
   assign nice_icb_cmd_valid_rowsum = state_is_rowsum & (rcv_data_buf_idx < clonum) & ~rowsum_acc_flg;

   
   wire rowbuf_clr = custom3_crowbuf & nice_req_hsked;

   
   
   
   
   
   
   wire [`N101_XLEN-1:0] rowbuf_r [ROWBUF_DP-1:0];
   wire [`N101_XLEN-1:0] rowbuf_wdat [ROWBUF_DP-1:0];
   wire [ROWBUF_DP-1:0]  rowbuf_we;
   wire [ROWBUF_IDX_W-1:0] rowbuf_idx_mux; 
   wire [`N101_XLEN-1:0] rowbuf_wdat_mux; 
   wire rowbuf_wr_mux; 
   
   
   
   wire [ROWBUF_IDX_W-1:0] lbuf_idx = lbuf_cnt_r; 
   wire lbuf_wr = lbuf_icb_rsp_hsked; 
   wire [`N101_XLEN-1:0] lbuf_wdata = nice_icb_rsp_rdata;

   
   wire [ROWBUF_IDX_W-1:0] rowsum_idx = rcv_data_buf_idx; 
   wire rowsum_wr = rcv_data_buf_valid; 
   wire [`N101_XLEN-1:0] rowsum_wdata = rowbuf_r[rowsum_idx] + rcv_data_buf;

   
   assign rowbuf_wdat_mux =   ({`N101_XLEN{lbuf_wr  }} & lbuf_wdata  )
                            | ({`N101_XLEN{rowsum_wr}} & rowsum_wdata)
                            ;
   assign rowbuf_wr_mux   =  lbuf_wr | rowsum_wr;
   assign rowbuf_idx_mux  =   ({ROWBUF_IDX_W{lbuf_wr  }} & lbuf_idx  )
                            | ({ROWBUF_IDX_W{rowsum_wr}} & rowsum_idx)
                            ;  

   
   generate 
     for (i=0; i<ROWBUF_DP; i=i+1) begin:gen_rowbuf
       assign rowbuf_we[i] =   (rowbuf_wr_mux & (rowbuf_idx_mux == i[ROWBUF_IDX_W-1:0]))
                             | rowbuf_clr
                             ;
  
       assign rowbuf_wdat[i] =   ({`N101_XLEN{rowbuf_we[i]}} & rowbuf_wdat_mux   )
                               | ({`N101_XLEN{rowbuf_clr}}   & {`N101_XLEN{1'b0}})
                               ;
  
       n101_gnrl_dfflr #(`N101_XLEN) rowbuf_dfflr (rowbuf_we[i], rowbuf_wdat[i], rowbuf_r[i], nice_clk, nice_rst_n);
     end
   endgenerate

   
   wire [`N101_XLEN-1:0] maddr_acc_r; 
   assign nice_icb_cmd_hsked = nice_icb_cmd_valid & nice_icb_cmd_ready; 
   
   wire lbuf_maddr_ena    =   (state_is_idle & custom3_lbuf & nice_icb_cmd_hsked)
                            | (state_is_lbuf & nice_icb_cmd_hsked)
                            ;

   
   wire sbuf_maddr_ena    =   (state_is_idle & custom3_sbuf & nice_icb_cmd_hsked)
                            | (state_is_sbuf & nice_icb_cmd_hsked)
                            ;

   
   wire rowsum_maddr_ena  =   (state_is_idle & custom3_rowsum & nice_icb_cmd_hsked)
                            | (state_is_rowsum & nice_icb_cmd_hsked)
                            ;

   
   
   wire  maddr_ena = lbuf_maddr_ena | sbuf_maddr_ena | rowsum_maddr_ena;
   wire  maddr_ena_idle = maddr_ena & state_is_idle;

   wire [`N101_XLEN-1:0] maddr_acc_op1 = maddr_ena_idle ? nice_req_rs1 : maddr_acc_r; 
   wire [`N101_XLEN-1:0] maddr_acc_op2 = maddr_ena_idle ? `N101_XLEN'h4 : `N101_XLEN'h4; 

   wire [`N101_XLEN-1:0] maddr_acc_next = maddr_acc_op1 + maddr_acc_op2;
   wire  maddr_acc_ena = maddr_ena;

   n101_gnrl_dfflr #(`N101_XLEN)   maddr_acc_dfflr (maddr_acc_ena, maddr_acc_next, maddr_acc_r, nice_clk, nice_rst_n);

   
   
   
   assign nice_req_hsked = nice_req_valid & nice_req_ready;
   assign nice_req_ready =   (state_is_idle & (custom_mem_op ? nice_icb_cmd_ready : 1'b1))
                          | (state_is_pipe & state_pipe_req_ready)
                          ;
   
   
   
   assign nice_1cyc_type = nice_req_hsked & (custom_1cyc_op | illgel_instr);
   
   assign nice_1cyc_rdat =   ({`N101_XLEN{custom3_add}}    & custom3_add_res   )
                          | ({`N101_XLEN{custom3_rsetup}} & custom3_rsetup_res)
                          ; 
   assign nice_1cyc_err  = (nice_req_hsked & illgel_instr);

   
   
   
   assign nice_rsp_hsked = nice_rsp_valid & nice_rsp_ready; 
   assign nice_icb_rsp_hsked = nice_icb_rsp_valid & nice_icb_rsp_ready;
   assign nice_rsp_valid = nice_rsp_valid_rowsum | nice_rsp_valid_pipe | nice_rsp_valid_sbuf | nice_rsp_valid_lbuf;
   assign nice_rsp_rdat  =   ({`N101_XLEN{state_is_pipe  }} & pipe_res   )
                          | ({`N101_XLEN{state_is_rowsum}} & rowsum_res )
                          ; 

   
   
   
   
   assign nice_rsp_err   =   (nice_icb_rsp_hsked & nice_icb_rsp_err);

   
   
   
   
   
   
   
   
   
   assign nice_icb_rsp_ready = 1'b1; 
   wire [ROWBUF_IDX_W-1:0] sbuf_idx = sbuf_cmd_cnt_r; 

   assign nice_icb_cmd_valid =   (state_is_idle & nice_req_valid & custom_mem_op)
                              | nice_icb_cmd_valid_lbuf
                              | nice_icb_cmd_valid_sbuf
                              | nice_icb_cmd_valid_rowsum
                              ;
   assign nice_icb_cmd_addr  = (state_is_idle & custom_mem_op) ? nice_req_rs1 :
                              state_is_pipe ? `N101_XLEN'b0 : 
                              maddr_acc_r;
   assign nice_icb_cmd_read  = (state_is_idle & custom_mem_op) ? (custom3_lbuf | custom3_rowsum) : 
                              state_is_sbuf ? 1'b0 : 
                              1'b1;
   assign nice_icb_cmd_wdata = (state_is_idle & custom3_sbuf) ? rowbuf_r[sbuf_idx] :
                              state_is_sbuf ? rowbuf_r[sbuf_idx] : 
                              `N101_XLEN'b0; 

   assign nice_icb_cmd_size  = 2'b10;
   assign nice_icb_cmd_mmode = 1'b1;
   assign nice_mem_holdup    =  state_is_lbuf | state_is_sbuf | state_is_rowsum; 

   
   
   
   assign nice_active = state_is_idle ? nice_req_valid : 1'b1;

endmodule
`endif


