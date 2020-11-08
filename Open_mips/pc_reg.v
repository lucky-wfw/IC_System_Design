//--------------------------------------------------------
// The instruction address fetch module
// Date: 2020-10-12
//--------------------------------------------------------


`include "defines.v"

module pc_reg(
  input clk,                     // Clock signal
  input rst,                     // Reset signal
  output reg [`InstAddrBus] pc,  // Instruction Address
  output reg ce                  // The enable signal of memory of instruction
);

always @(posedge clk) begin
  if(rst==`RstEnable) begin
    ce <= `ChipDisable;
  end
  else begin
    ce <= `ChipEnable;
  end
end

always @(posedge clk) begin
  if(ce==`ChipDisable) begin
    pc <= 32'h00000000;
  end
  else begin
    pc <= pc + 4'h4;
  end
end

endmodule

