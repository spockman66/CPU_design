module n101_ResetCatchAndSync(
  input   clock,
  input   reset,
  input   test_mode,
  output  io_sync_reset
);
  wire  reset_n_catch_reg_clock;
  wire  reset_n_catch_reg_reset;
  wire [2:0] reset_n_catch_reg_io_d;
  wire [2:0] reset_n_catch_reg_io_q;
  wire  reset_n_catch_reg_io_en;
  wire [1:0] T_6;
  wire [2:0] T_7;
  wire  T_8;
  wire  T_9;
  n101_AsyncResetRegVec_36 reset_n_catch_reg (
    .clock(reset_n_catch_reg_clock),
    .reset(reset_n_catch_reg_reset),
    .io_d(reset_n_catch_reg_io_d),
    .io_q(reset_n_catch_reg_io_q),
    .io_en(reset_n_catch_reg_io_en)
  );
  assign io_sync_reset = test_mode ? reset : T_9;
  assign reset_n_catch_reg_clock = clock;
  assign reset_n_catch_reg_reset = reset;
  assign reset_n_catch_reg_io_d = T_7;
  assign reset_n_catch_reg_io_en = 1'h1;
  assign T_6 = reset_n_catch_reg_io_q[2:1];
  assign T_7 = {1'h1,T_6};
  assign T_8 = reset_n_catch_reg_io_q[0];
  assign T_9 = ~ T_8;
endmodule

