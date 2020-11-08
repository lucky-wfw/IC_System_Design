//---------------------------------------------------------------------
// RegFile module
// It implements 32 32-bit registers, which can read two registers 
// and write one register at the same time.
// date: 2020-10-13
//---------------------------------------------------------------------


`include"defines.v"


module regfile(
  input clk,
  input rst,

  // write port
  input we,
  input [`RegAddrBus] waddr,
  input [`RegBus] wdata,

  // read port1
  input re1,
  input [`RegAddrBus] raddr1,
  output reg[`RegBus] rdata1,

  // read port 2
  input re2,
  input [`RegAddrBus] raddr2,
  output reg[`RegBus] rdata2
);


// deefine 32 32-bits registers
reg [`RegBus] regs[0:`RegNum-1];

// write operation
always @(posedge clk) begin
  if(rst==`RstDisable) begin
    if((we==`WriteEnable)&&(waddr!=`RegNumLog2'h0)) begin
      regs[waddr] <= wdata;
    end
  end
end

// read posrt-1 operation
always @(*) begin
  if(rst==`RstEnable) begin
    rdata1 <= `ZeroWord;
  end
  else if(raddr1==`RegNumLog2'h0) begin
    rdata1 <= `ZeroWord;
  end
  else if((raddr1==waddr)&&(we==`WriteEnable)&&(re1==`ReadEnable)) begin
    rdata1 <= wdata;
  end
  else if(re1==`ReadEnable) begin
    rdata1 <= regs[raddr1];
  end
  else begin
    rdata1 <= `ZeroWord;
  end
end


// read posrt-2 operation
always @(*) begin
  if(rst==`RstEnable) begin
    rdata2 <= `ZeroWord;
  end
  else if(raddr2==`RegNumLog2'h0) begin
    rdata2 <= `ZeroWord;
  end
  else if((raddr2==waddr)&&(we==`WriteEnable)&&(re2==`ReadEnable)) begin
    rdata2 <= wdata;
  end
  else if(re2==`ReadEnable) begin
    rdata2 <= regs[raddr2];
  end
  else begin
    rdata2 <= `ZeroWord;
  end
end

endmodule
