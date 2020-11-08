//------------------------------------------------------------
// Module Name: ctl_core
// The control core
// Author: WangFw
// Date: 2020-10-18
//------------------------------------------------------------

module ctl_core(
  input rstn,
  input [5:0] op_code,
  input clk_src1,
  input clk_src2,
  input clk_src3,
  input clk_src4,
  output wire clk_out
);


reg [1:0] sel;

always @(op_code) begin
  if(!rstn) begin
    sel <= 2'b00;
  end
  else begin
    case(op_code)
      6'b000000: begin
        sel <= 2'b00;
      end
      6'b000001: begin
        sel <= 2'b00;
      end
      6'b000010: begin
        sel <= 2'b01;
      end
      6'b101010: begin
        sel <= 2'b10;
      end
      6'b101111: begin
        sel <= 2'b11;
      end
      6'b111111: begin
        sel <= 2'b11;
      end
      default: begin
        sel <= 2'b00;
      end
    endcase
  end
end


multi_clk_swt u(
.clk_src1(clk_src1),
.clk_src2(clk_src2),
.clk_src3(clk_src3),
.clk_src4(clk_src4),
.rstn(rstn),
.mode(sel),
.clk_out(clk_out));


endmodule

