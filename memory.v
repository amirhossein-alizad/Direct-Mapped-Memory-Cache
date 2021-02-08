`timescale 1ns/1ns
module memory(input clk, rst, input[14:0] address, output[31:0] Dataout, output hit, miss);
  wire valid, write, read_adr;
  wire[2:0] tag, checking_tag;
  wire[127:0] Datain;
  
  cache_mem cache(clk, write, read_adr, hit, miss, address, Datain, valid, tag ,checking_tag, Dataout);
  main_mem main(clk, read_adr, address, Datain);
  cache_controller controller(clk, rst, valid, tag, checking_tag,  write, read_adr, hit, miss);
  
endmodule
