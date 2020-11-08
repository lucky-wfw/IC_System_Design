//----------------------------------------------------------
// Module Name: uart_send_tb
// The testbench of uart_send
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------

`timescale 1ns/1ns

module uart_send_tb();

reg sys_clk;
reg sys_rst_n;
reg uart_en;
reg [7:0] uart_din;
wire uart_txd;

initial begin
  sys_clk = 0;
  sys_rst_n = 1;
  uart_en = 0;
  uart_din = 8'd0;
  #10 sys_rst_n = 0;
  #10 sys_rst_n = 1;

  send(8'b1010_1010);

end


task send(input [7:0] din);
begin
  @(posedge sys_clk)
  uart_en = 1'b0;
  @(posedge sys_clk)
  uart_en = 1'b1;
  uart_din = din;
  @(posedge sys_clk)
  uart_en = 1'b0;
end
endtask

uart_send dut(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .uart_en(uart_en),
  .uart_din(uart_din),
  .uart_txd(uart_txd)
);
  

always #2 sys_clk <= ~sys_clk;



endmodule


