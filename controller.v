`timescale 1ns/1ns
module cache_controller(input clk, rst, valid, input[2:0] tag, checking_tag, output reg write, read_adr, hit, miss);
  reg[1:0] ns,ps;
  integer hit_count, total;
  initial begin  hit_count = 0; total = 0;ns = 0; end
  always @(ps,valid,checking_tag, tag) begin
    ns = 2'b0;
    {miss, hit, write, read_adr} = 4'b0;
    case(ps)
      2'b0: begin 
        read_adr = 1;
        ns = 2'b01;
      end
      2'b01: begin
        if(valid == 1 && tag == checking_tag) begin
          ns = 2'b0;
          hit = 1'b1;
          hit_count = hit_count + 1;
          total = total + 1;
          $display ("hit: %d, total: %d, hit rate: %d",hit_count, total, (hit_count * 100 / total));
        end
        else begin
          ns = 2'b10;
        end
      end
      2'b10: begin
        write = 1;
        ns = 2'b11;
      end
      2'b11: begin
        miss = 1'b1;
        ns = 2'b0;
        total = total + 1;
         $display ("hit: %d, total: %d, hit rate: %d",hit_count, total, (hit_count * 100 / total));
      end
    endcase
  end
  always @(posedge clk, posedge rst) begin
    if(rst) ps <= 2'b0; 
    else  ps <= ns;
      
  end     
endmodule