//--------------------------------------------------------------
// Module Name: multi_clk_swt
// Used to switch between four clock sources without glitch 
// according to different power needings.
// Author: WangFw
// mode: 
//      00 - lowest power  - src1
//      01 - lower power   - src2
//      10 - higher power  - src3
//      11 - highest power - src4
//--------------------------------------------------------------

module multi_clk_swt(
  input clk_src1,
  input clk_src2,
  input clk_src3,
  input clk_src4,
  input rstn,
  input [1:0] mode,
  output clk_out
);

wire clk_u1;
wire clk_u2;

clk_src_swt u1(.rstn(rstn),
               .clk_src1(clk_src1),
               .clk_src2(clk_src2),
               .sel(~mode[0]),
               .clk_out(clk_u1));

clk_src_swt u2(.rstn(rstn),
               .clk_src1(clk_src3),
               .clk_src2(clk_src4),
               .sel(~mode[0]),
               .clk_out(clk_u2));

clk_src_swt u3(.rstn(rstn),
               .clk_src1(clk_u1),
               .clk_src2(clk_u2),
               .sel(~mode[1]),
               .clk_out(clk_out));



endmodule

