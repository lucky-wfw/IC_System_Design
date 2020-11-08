//--------------------------------------------------------------
// module name: mini_sopc
// Connect the open_mips and inst_rom for test
// date: 2020-10-16
//--------------------------------------------------------------

`include"defines.v"

module mini_sopc(
  input clk,
  input rst
);

wire [`InstAddrBus] inst_addr;
wire [`InstBus] inst;
wire rom_ce;

open_mips_top open_mips0(.clk(clk),.rst(rst),
.rom_addr_o(inst_addr),.rom_data_i(inst),.rom_ce_o(rom_ce));

inst_rom inst_rom0(.ce(rom_ce),.addr(inst_addr),.inst(inst));

endmodule
