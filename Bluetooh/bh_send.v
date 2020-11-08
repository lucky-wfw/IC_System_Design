//----------------------------------------------------------------
// Module Name: bh_send
// Use uart port to test bluetooh module
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------------


module bh_send(
  input sys_clk,
  input sys_rst_n,
  input key,
  output uart_txd
);


//-----------------------------------------
// Parameters definition
//-----------------------------------------
wire enable;
wire [7:0] data;


//-----------------------------------------
// Module connect
//-----------------------------------------

uart_send_source src1(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .key(key),
  .enable(enable),
  .dout(data)
);


uart_send send1(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .uart_en(enable),
  .uart_din(data),
  .uart_txd(uart_txd)
);


endmodule
