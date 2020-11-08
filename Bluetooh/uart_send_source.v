//--------------------------------------------
// Module Name: uart_send_source
// Supply the data source for send
// Author: WangFW
// Created on 2020-11-6
//--------------------------------------------

module uart_send_source(
  input sys_clk,
  input sys_rst_n,
  input key,
  output reg enable,
  output reg [7:0] dout
);

reg d0, d1;
wire flag;

assign flag = d1 && (~d0);

always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    d0 <= 1'b0;
    d1 <= 1'b0;
  end
  else begin
    d0 <= key;
    d1 <= d0;
  end
end

always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    enable <= 1'b0;
    dout <= 8'd0;
  end
  else begin
    if(flag == 1'b1) begin
      enable <= 1'b1;
      dout <= 8'b1010_1010;
    end
    else begin
      enable <= 1'b0;
      dout <= dout;
    end
  end
end


endmodule
