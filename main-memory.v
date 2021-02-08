`timescale 1ns/1ns
module main_mem(input clk, read_adr, input[14:0] address, output reg [127:0] readdata);
    reg[9:0] index;
    reg [31:0] w0,w1,w2,w3;
    integer offset, i;
    reg [31:0] mem [0:32767];
    initial begin 
      $readmemb("Data.txt", mem, 1024);
    end
    always @(posedge clk)
    begin
      if (read_adr == 1) begin
         readdata = {mem[address - address[1:0] + 3],mem[address-address[1:0] + 2],mem[address- address[1:0] + 1],mem[address- address[1:0]]};
      end
    end
endmodule
