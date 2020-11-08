//------------------------------------------------------
// The testbench for multi_clk_swt
// Author: WangFW
// Date: 2020-10-18
//------------------------------------------------------

`timescale 1ns/1ns

module multi_clk_swt_tb();

reg clk_src1;
reg clk_src2;
reg clk_src3;
reg clk_src4;
reg rstn;
reg [1:0] mode;
wire clk_out;

initial begin
  clk_src1 = 0;
  clk_src2 = 0;
  clk_src3 = 0;
  clk_src4 = 0;
  rstn = 1;
  mode = 2'b00;
  #10 rstn = 0;
  #10 rstn = 1;
  #500 mode = 2'b01;
  #500 mode = 2'b10;
  #500 mode = 2'b11;
end

always #2 clk_src1<=~clk_src1;
always #3 clk_src2<=~clk_src2;
always #4 clk_src3<=~clk_src3;
always #5 clk_src4<=~clk_src4;

multi_clk_swt dut(
.clk_src1(clk_src1),
.clk_src2(clk_src2),
.clk_src3(clk_src3),
.clk_src4(clk_src4),
.rstn(rstn),
.mode(mode),
.clk_out(clk_out));

endmodule




