







































































`include "n101_i2c_master_defines.v"

module n101_i2c_master_byte_ctrl (
    clk, rst, nReset, ena, clk_cnt, start, stop, read, write, ack_in, din,
    cmd_ack, ack_out, dout, i2c_busy, i2c_al, scl_i, scl_o, scl_oen, sda_i, sda_o, sda_oen );

    
    
    
    input clk;     
    input rst;     
    input nReset;  
    input ena;     

    input [15:0] clk_cnt; 

    
    input       start;
    input       stop;
    input       read;
    input       write;
    input       ack_in;
    input [7:0] din;

    
    output       cmd_ack;
    reg cmd_ack;
    output       ack_out;
    reg ack_out;
    output       i2c_busy;
    output       i2c_al;
    output [7:0] dout;

    
    input  scl_i;
    output scl_o;
    output scl_oen;
    input  sda_i;
    output sda_o;
    output sda_oen;


    
    
    

    
    parameter [4:0] ST_IDLE  = 5'b0_0000;
    parameter [4:0] ST_START = 5'b0_0001;
    parameter [4:0] ST_READ  = 5'b0_0010;
    parameter [4:0] ST_WRITE = 5'b0_0100;
    parameter [4:0] ST_ACK   = 5'b0_1000;
    parameter [4:0] ST_STOP  = 5'b1_0000;

    
    reg  [3:0] core_cmd;
    reg        core_txd;
    wire       core_ack, core_rxd;

    
    reg [7:0] sr; 
    reg       shift, ld;

    
    wire       go;
    reg  [2:0] dcnt;
    wire       cnt_done;

    
    
    

    
    n101_i2c_master_bit_ctrl bit_controller (
        .clk     ( clk      ),
        .rst     ( rst      ),
        .nReset  ( nReset   ),
        .ena     ( ena      ),
        .clk_cnt ( clk_cnt  ),
        .cmd     ( core_cmd ),
        .cmd_ack ( core_ack ),
        .busy    ( i2c_busy ),
        .al      ( i2c_al   ),
        .din     ( core_txd ),
        .dout    ( core_rxd ),
        .scl_i   ( scl_i    ),
        .scl_o   ( scl_o    ),
        .scl_oen ( scl_oen  ),
        .sda_i   ( sda_i    ),
        .sda_o   ( sda_o    ),
        .sda_oen ( sda_oen  )
    );

    
    assign go = (read | write | stop) & ~cmd_ack;

    
    assign dout = sr;

    
    always @(posedge clk or negedge nReset)
      if (!nReset)
        sr <= #1 8'h0;
      else if (rst)
        sr <= #1 8'h0;
      else if (ld)
        sr <= #1 din;
      else if (shift)
        sr <= #1 {sr[6:0], core_rxd};

    
    always @(posedge clk or negedge nReset)
      if (!nReset)
        dcnt <= #1 3'h0;
      else if (rst)
        dcnt <= #1 3'h0;
      else if (ld)
        dcnt <= #1 3'h7;
      else if (shift)
        dcnt <= #1 dcnt - 3'h1;

    assign cnt_done = ~(|dcnt);

    
    
    
    reg [4:0] c_state; 

    always @(posedge clk or negedge nReset)
      if (!nReset)
        begin
            core_cmd <= #1 `I2C_CMD_NOP;
            core_txd <= #1 1'b0;
            shift    <= #1 1'b0;
            ld       <= #1 1'b0;
            cmd_ack  <= #1 1'b0;
            c_state  <= #1 ST_IDLE;
            ack_out  <= #1 1'b0;
        end
      else if (rst | i2c_al)
       begin
           core_cmd <= #1 `I2C_CMD_NOP;
           core_txd <= #1 1'b0;
           shift    <= #1 1'b0;
           ld       <= #1 1'b0;
           cmd_ack  <= #1 1'b0;
           c_state  <= #1 ST_IDLE;
           ack_out  <= #1 1'b0;
       end
    else
      begin
          
          core_txd <= #1 sr[7];
          shift    <= #1 1'b0;
          ld       <= #1 1'b0;
          cmd_ack  <= #1 1'b0;

          case (c_state) 
            ST_IDLE:
              if (go)
                begin
                    if (start)
                      begin
                          c_state  <= #1 ST_START;
                          core_cmd <= #1 `I2C_CMD_START;
                      end
                    else if (read)
                      begin
                          c_state  <= #1 ST_READ;
                          core_cmd <= #1 `I2C_CMD_READ;
                      end
                    else if (write)
                      begin
                          c_state  <= #1 ST_WRITE;
                          core_cmd <= #1 `I2C_CMD_WRITE;
                      end
                    else 
                      begin
                          c_state  <= #1 ST_STOP;
                          core_cmd <= #1 `I2C_CMD_STOP;
                      end

                    ld <= #1 1'b1;
                end

            ST_START:
              if (core_ack)
                begin
                    if (read)
                      begin
                          c_state  <= #1 ST_READ;
                          core_cmd <= #1 `I2C_CMD_READ;
                      end
                    else
                      begin
                          c_state  <= #1 ST_WRITE;
                          core_cmd <= #1 `I2C_CMD_WRITE;
                      end

                    ld <= #1 1'b1;
                end

            ST_WRITE:
              if (core_ack)
                if (cnt_done)
                  begin
                      c_state  <= #1 ST_ACK;
                      core_cmd <= #1 `I2C_CMD_READ;
                  end
                else
                  begin
                      c_state  <= #1 ST_WRITE;       
                      core_cmd <= #1 `I2C_CMD_WRITE; 
                      shift    <= #1 1'b1;
                  end

            ST_READ:
              if (core_ack)
                begin
                    if (cnt_done)
                      begin
                          c_state  <= #1 ST_ACK;
                          core_cmd <= #1 `I2C_CMD_WRITE;
                      end
                    else
                      begin
                          c_state  <= #1 ST_READ;       
                          core_cmd <= #1 `I2C_CMD_READ; 
                      end

                    shift    <= #1 1'b1;
                    core_txd <= #1 ack_in;
                end

            ST_ACK:
              if (core_ack)
                begin
                   if (stop)
                     begin
                         c_state  <= #1 ST_STOP;
                         core_cmd <= #1 `I2C_CMD_STOP;
                     end
                   else
                     begin
                         c_state  <= #1 ST_IDLE;
                         core_cmd <= #1 `I2C_CMD_NOP;

                         
                         cmd_ack  <= #1 1'b1;
                     end

                     
                     ack_out <= #1 core_rxd;

                     core_txd <= #1 1'b1;
                 end
               else
                 core_txd <= #1 ack_in;

            ST_STOP:
              if (core_ack)
                begin
                    c_state  <= #1 ST_IDLE;
                    core_cmd <= #1 `I2C_CMD_NOP;

                    
                    cmd_ack  <= #1 1'b1;
                end

          endcase
      end
endmodule
