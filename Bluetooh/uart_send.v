//----------------------------------------------------------------
// Module Name: uart_send
// The send part of UART
// Author: WangFW
// Created on 2020-11-6
//----------------------------------------------------------------

module uart_send(
  input sys_clk,
  input sys_rst_n,
  input uart_en,
  input [7:0] uart_din,
  output reg uart_txd
);


//--------------------------------------------------------
// Parameter define
//--------------------------------------------------------
parameter CLK_FREQ = 50000;
parameter UART_BPS = 9600;
localparam BPS_CNT = CLK_FREQ/UART_BPS;


//--------------------------------------------------------
// Registers define
//--------------------------------------------------------
reg uart_en_d0;
reg uart_en_d1;
reg [15:0] clk_cnt;
reg [3:0] tx_cnt;
reg tx_flag;
reg [7:0] tx_data;

//--------------------------------------------------------
// Wires define
//--------------------------------------------------------
wire en_flag;

//--------------------------------------------------------
// enable valid
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    uart_en_d0 <= 1'b0;
    uart_en_d1 <= 1'b0;
  end
  else begin
    uart_en_d0 <= uart_en;
    uart_en_d1 <= uart_en_d0;
  end
end

// posedge of enable signal
assign en_flag = (~uart_en_d1) && uart_en_d0;


//--------------------------------------------------------
// enable valid
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    tx_flag <= 1'b0;
    tx_data <= 8'd0;
  end
  else if(en_flag == 1'b1) begin
    tx_flag <= 1'b1;
    tx_data <= uart_din;
  end
  else begin
    if((tx_cnt == 4'd9)&&(clk_cnt == BPS_CNT/2)) begin
      tx_flag <= 1'b0;
      tx_data <= 8'd0;
    end
    else begin
      tx_flag <= tx_flag;
      tx_data <= tx_data;
    end
  end
end


//--------------------------------------------------------
// start clock counter and data counter
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    clk_cnt <= 16'd0;
    tx_cnt <= 4'd0;
  end
  else if(tx_flag == 1'b1) begin
    if(clk_cnt < (BPS_CNT - 1)) begin
      clk_cnt <= clk_cnt + 1'b1;
      tx_cnt <= tx_cnt;
    end
    else begin
      clk_cnt <= 16'd0;
      tx_cnt <= tx_cnt + 1'b1;
    end
  end
  else begin
    clk_cnt <= 16'd0;
    tx_cnt <= 4'd0;
  end
end


//--------------------------------------------------------
// send the data to uart_txd
//--------------------------------------------------------
always @(posedge sys_clk, negedge sys_rst_n) begin
  if(!sys_rst_n) begin
    uart_txd <= 1'b1;
  end
  else if(tx_flag) begin
    case(tx_cnt)
      4'd0: uart_txd <= 1'b0;
      4'd1: uart_txd <= tx_data[0];
      4'd2: uart_txd <= tx_data[1];
      4'd3: uart_txd <= tx_data[2];
      4'd4: uart_txd <= tx_data[3];
      4'd5: uart_txd <= tx_data[4];
      4'd6: uart_txd <= tx_data[5];
      4'd7: uart_txd <= tx_data[6];
      4'd8: uart_txd <= tx_data[7];
      4'd9: uart_txd <= 1'b1;
      default: ;
    endcase
  end
  else begin
    uart_txd <= 1'b1;
  end
end

endmodule

