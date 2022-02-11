module n101_SRLatch (
  input set,
  input reset,
  output q
);

  reg latch;

  
  
  always @(set or reset)
  begin
    if (set)
      latch <= 1'b1;
    else if (reset)
      latch <= 1'b0;
  end

  assign q = latch;

endmodule
