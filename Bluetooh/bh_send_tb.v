//----------------------------------------------------------
// Module Name: bh_send_tb
// The testbench of bh_send
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------


`timescale 1ns/1ns

module bh_send_tb();

reg sys_clk;
reg sys_rst_n;
reg key;
wire uart_txd;

initial begin
  sys_clk = 0;
  sys_rst_n = 1;
  key = 1;
  #10 sys_rst_n = 0;
  #10 sys_rst_n = 1;

  work();

end


task work();
begin
  @(posedge sys_clk)
  key = 1'b1;
  @(posedge sys_clk)
  key = 1'b0;
  @(posedge sys_clk)
  key = 1'b0;
  @(posedge sys_clk)
  key = 1'b1;
end
endtask


always #2 sys_clk <= ~sys_clk;

bh_send dut(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .key(key),
  .uart_txd(uart_txd)
);

endmodule

