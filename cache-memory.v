`timescale 1ns/1ns
module cache_mem(input clk, input write, read_adr,hit,miss, input[14:0] address, input[127:0] Datain, output reg valid, output reg[2:0] tag, checking_tag, output  [31:0] Dataout);
    
    reg [131:0] cache [0:1023];
    reg[9:0] index;
    reg[1:0] word_offset;
    always @(posedge clk) 
    begin
      if(read_adr == 1) begin
        tag = address[14:12];
        index = address[11:2];
        word_offset = address[1:0];
        valid = cache[index][131];
        checking_tag = cache[index][130:128];
      end
      if (write == 1) 
      begin
        cache[index] <= {1'b1, address[14:12], Datain};
      end
    end
    assign Dataout = hit ? cache[index][((word_offset + 1) * 32 - 1) -: 32] : (miss ?  cache[index][((word_offset + 1) * 32 - 1) -: 32] : Dataout);
endmodule
