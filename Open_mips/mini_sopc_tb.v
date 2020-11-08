//------------------------------------------------------------
// The testbench of mini_sopc
// date: 2020-10-16
//------------------------------------------------------------

`include"defines.v"

`timescale 1ns/1ps

module mini_sopc_tb();

reg clock_50;
reg rst;

initial begin
  clock_50 = 1'b0;
  forever #10 clock_50 = ~clock_50;
end

initial begin
  rst = `RstEnable;
  #195 rst = `RstDisable;
  #1000 $stop;
end

mini_sopc mini_sopc0(.clk(clock_50),.rst(rst));

endmodule
