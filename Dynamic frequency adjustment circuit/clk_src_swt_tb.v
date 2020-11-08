//-----------------------------------------------
// The testbench of clk_src_swt
// Author: WangFW
// Date: 2020-10-18
//-----------------------------------------------

`timescale 10ns/1ns

module clk_src_swt_tb();
reg clk1;
reg clk0;
reg sel;
reg rstn;
wire clkout;

initial begin
  clk1=0;
  clk0=0;
  sel=0;
  rstn=1;
  #10 rstn=0;
  #10 rstn=1;
  #50 sel=1;
  #50 sel=0;
end

always #2 clk1<=~clk1;
always #4 clk0<=~clk0;

clk_src_swt dut(.clk_src1(clk1),.clk_src2(clk0),.rstn(rst_n),.sel(sel),.clk_out(clkout));

endmodule
