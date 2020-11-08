//----------------------------------------------------------------
// Module Name: bh_send
// Use uart port to test bluetooh module
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------------
// Date: 2020-11-8
// Add read data part and led control
//----------------------------------------------------------------


module BH(
  input sys_clk,
  input sys_rst_n,
  input key,
  input uart_rxd,
  output ATK_KEY,
  output uart_txd,
  output [3:0] led
);


//-----------------------------------------
// Parameters definition
//-----------------------------------------
wire enable;
wire [7:0] data;

wire [7:0] recv_data;
wire uart_done;


assign ATK_KEY = 1'b0;

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


uart_recv(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .uart_rxd(uart_rxd),
  .uart_done(uart_done),
  .uart_data(recv_data)
);

uart_led(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .data(recv_data),
  .led(led)
);


endmodule
