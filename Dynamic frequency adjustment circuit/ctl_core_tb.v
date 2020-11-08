//------------------------------------------------------
// The testbench for ctl_core
// Author: WangFW
// Date: 2020-10-18
//------------------------------------------------------

`timescale 1ns/1ns

module ctl_core_tb();

reg clk_src1;
reg clk_src2;
reg clk_src3;
reg clk_src4;
reg rstn;
reg [5:0] op_code;
wire clk_out;

initial begin
  clk_src1 = 0;
  clk_src2 = 0;
  clk_src3 = 0;
  clk_src4 = 0;
  rstn = 1;
  op_code = 6'b000000;
  #10 rstn = 0;
  #10 rstn = 1;
  #500 op_code = 6'b000001;
  #500 op_code = 6'b000010;
  #500 op_code = 6'b101010;
  #500 op_code = 6'b101111;
  #500 op_code = 6'b111111;
end

always #2 clk_src1<=~clk_src1;
always #3 clk_src2<=~clk_src2;
always #4 clk_src3<=~clk_src3;
always #5 clk_src4<=~clk_src4;

ctl_core dut(
.clk_src1(clk_src1),
.clk_src2(clk_src2),
.clk_src3(clk_src3),
.clk_src4(clk_src4),
.rstn(rstn),
.op_code(op_code),
.clk_out(clk_out));

endmodule




