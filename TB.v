`timescale 1ns/1ns
module TB();
  reg clk,rst;
  wire hit, miss; 
  reg[14:0] address;
  wire[31:0] Data;
  memory Mem(clk, rst, address, Data, hit, miss);
  initial clk = 0;
  always #10 clk = !clk;
  initial address = 15'b000010000000000;
  always #20 begin
   if (address != 15'b010010000000000) begin
     if(hit == 1'b1 || miss == 1'b1) begin
       address = address + 15'b000000000000001;
     end
  end
   if (address == 15'b010010000000000) $stop;
  end
endmodule 
    