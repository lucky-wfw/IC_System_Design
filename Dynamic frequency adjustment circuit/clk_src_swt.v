//-----------------------------------------------------------
// Module Name: clk_src_swt
// Used to switch between two clock sources without glitch.
// Date: 2020-10-18
// Author: WangFW
//-----------------------------------------------------------

module clk_src_swt(
  input rstn,
  input clk_src1,
  input clk_src2,
  input sel,
  output clk_out
);

// some defines for wire connect
reg q1_p;
reg q1_n;
reg q2_p;
reg q2_n;

always @(negedge clk_src1 or negedge rstn) begin
  if(!rstn) begin
    q1_p <= 1'b0;
    q1_n <= 1'b1;
  end
  else begin
    q1_p <= sel && q2_n;
    q1_n <= ~(sel && q2_n);
  end
end

always @(negedge clk_src2 or negedge rstn) begin
  if(!rstn) begin
    q2_p <= 1'b0;
    q2_n <= 1'b1;
  end
  else begin
    q2_p <= (~sel) && q1_n;
    q2_n <= ~((~sel) && q1_n);
  end
end

assign clk_out = (clk_src1 && q1_p) || (clk_src2 && q2_p);


endmodule

