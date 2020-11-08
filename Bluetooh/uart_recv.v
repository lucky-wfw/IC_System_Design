//-------------------------------------------------------------------
// Module Name: uart_recv
// The receive part of UART 
// Author: WangFW
// Created on 2020-11-5
//-------------------------------------------------------------------

module uart_recv(
  input sys_clk,
  input sys_rst_n,
  input uart_rxd,
  output reg uart_done,
  output reg [7:0] uart_data
);


//--------------------------------------------------------
// Parameter define
//--------------------------------------------------------
parameter CLK_FREQ = 50000000;
parameter UART_BPS = 9600;
localparam BPS_CNT = CLK_FREQ/UART_BPS;

//--------------------------------------------------------
// Registers define
//--------------------------------------------------------
reg uart_rxd_d0;
reg uart_rxd_d1;
// receive one bit' clock cycle
reg [15:0] clk_cnt;
// The number of receive bits
reg [3:0] rx_cnt;
reg rx_flag;
reg [7:0] rxdata;

//--------------------------------------------------------
// Wire define
//--------------------------------------------------------
wire start_flag;

//--------------------------------------------------------
// Determine the start flag: negedge of rxd
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    uart_rxd_d0 <= 1'b0;
    uart_rxd_d1 <= 1'b0;
  end
  else begin
    uart_rxd_d0 <= uart_rxd;
    uart_rxd_d1 <= uart_rxd_d0;
  end
end

assign start_flag = uart_rxd_d1 && (~uart_rxd_d0);

//--------------------------------------------------------
// start_flag valid, receive data
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    rx_flag <= 1'b0;
  end
  else begin
    if(start_flag == 1'b1) begin
      rx_flag <= 1'b1;
    end
    // one bit receive completed
    else if((rx_cnt == 4'd9)&&(clk_cnt == BPS_CNT/2)) begin
      rx_flag <= 1'b0;
    end
    else begin
      rx_flag <= rx_flag;
    end
  end
end

//--------------------------------------------------------
// counter the clock cycles during one bit data
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    clk_cnt <= 16'd0;
    rx_cnt <= 4'd0;
  end
  else if(rx_flag == 1'b1) begin
    if(clk_cnt < (BPS_CNT - 1)) begin
      clk_cnt <= clk_cnt + 1'b1;
      rx_cnt <= rx_cnt;
    end
    else begin
      clk_cnt <= 16'd0;
      rx_cnt <= rx_cnt + 1'b1;
    end
  end
  else begin
    clk_cnt <= 16'd0;
    rx_cnt <= 4'd0;
  end
end

//--------------------------------------------------------
// read the every bit data
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    rxdata <= 8'd0;
  end
  else if(rx_flag == 1'b1) begin
    if(clk_cnt == BPS_CNT/2) begin
      case(rx_cnt)
        4'd1: rxdata[0] <= uart_rxd_d1;
        4'd2: rxdata[1] <= uart_rxd_d1;
        4'd3: rxdata[2] <= uart_rxd_d1;
        4'd4: rxdata[3] <= uart_rxd_d1;
        4'd5: rxdata[4] <= uart_rxd_d1;
        4'd6: rxdata[5] <= uart_rxd_d1;
        4'd7: rxdata[6] <= uart_rxd_d1;
        4'd8: rxdata[7] <= uart_rxd_d1;
        default: ;
      endcase
    end
    else begin
      rxdata <= rxdata;
    end
  end
  else begin
    rxdata <= 8'd0;
  end
end

//--------------------------------------------------------
// output the data and valid flag
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    uart_data <= 8'd0;
    uart_done <= 1'b0;
  end
  else if(rx_cnt == 4'd9) begin
    uart_data <= rxdata;
    uart_done <= 1'b1;
  end
  else begin
    uart_data <= 8'd0;
    uart_done <= 1'b0;
  end
end



endmodule
