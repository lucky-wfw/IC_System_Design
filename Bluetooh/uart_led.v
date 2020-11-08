//-------------------------------------------------------------------
// Module Name: uart_led
// Leds control by data received by uart
// Author: WangFW
// Created on 2020-11-8
//-------------------------------------------------------------------


module uart_led(
  input sys_clk,
  input sys_rst_n,
  input [7:0] data,
  output reg[3:0] led
  
);

always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    led <= 4'b0000;
  end
  else begin
    case(data)
      8'd0: led <= led;
      8'd1: led <= 4'b0001;
      8'd2: led <= 4'b0010;
      8'd3: led <= 4'b0100;
      8'd4: led <= 4'b1000;
      8'd5: led <= 4'b1111;
      8'd6: led <= 4'b1010;
      8'd7: led <= 4'b0101;
      default: led <= 4'b0000;
    endcase
  end
end

endmodule