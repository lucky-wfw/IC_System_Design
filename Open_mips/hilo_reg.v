//---------------------------------------------------------
// module name: hilo_reg.v
// used to realize the specifical registers
// Date: 2020-10-18
//---------------------------------------------------------

`include"defines.v"

module hilo_reg(
  input clk,
  input rst,
  input we,
  input [`RegBus] hi_i,
  input [`RegBus] lo_i,

  output reg [`RegBus] hi_o,
  output reg [`RegBus] lo_o
);


always @(posedge clk) begin
  if(rst==`RstEnable) begin
    hi_o <= `ZeroWord;
    lo_o <= `ZeroWord;
  end
  else if((we==`WriteEnable)) begin
    hi_o <= hi_i;
    lo_o <= lo_i;
  end
end

endmodule
