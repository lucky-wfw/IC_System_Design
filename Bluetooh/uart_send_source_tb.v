//----------------------------------------------------------
// Module Name: uart_send_source_tb
// The testbench of uart_send_source
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------


`timescale 1ns/1ns

module uart_send_source_tb();

reg sys_clk;
reg sys_rst_n;
reg key;
wire enable;
wire [7:0] dout;

initial begin
  sys_clk = 0;
  sys_rst_n = 1;
  key = 1'b1;
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

uart_send_source dut(
  .sys_clk(sys_clk),
  .sys_rst_n(sys_rst_n),
  .key(key),
  .enable(enable),
  .dout(dout)
);

endmodule
