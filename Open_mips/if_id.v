//----------------------------------------------------------------
// if_id module
// Temporarily save the instruction obtained in the pointing phase 
// and the corresponding address
// Date: 2020-10-12
//----------------------------------------------------------------

`include"defines.v"

module if_id(
  input clk,                       // clock signal
  input rst,                       // reset signal
  input [`InstAddrBus] if_pc,      // The address of instruction
  input [`InstBus] if_inst,        // The instruction
  output reg[`InstAddrBus] id_pc,  // The decode address
  output reg[`InstBus] id_inst     // The instruction of decode 
);

always @(posedge clk) begin
  if(rst==`RstEnable) begin
    id_pc <= `ZeroWord;
    id_inst <= `ZeroWord;
  end
  else begin
    id_pc <= if_pc;
    id_inst <= if_inst;
  end
end

endmodule
