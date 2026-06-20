`timescale 1ns/1ps
module tb_top_week8;
reg clk, reset;
top_week7 uut(clk, reset);

initial begin
    $dumpfile("top_week8.vcd");
    $dumpvars(0, tb_top_week8);
    clk = 0; reset = 1;
    #20 reset = 0;
    #2000 $finish;
end

always #5 clk = ~clk;
endmodule
