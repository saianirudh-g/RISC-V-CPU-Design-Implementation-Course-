`timescale 1ns/1ps
module tb_top_week6;
reg clk, reset;
top_week6 uut(clk, reset);

initial begin
    $dumpfile("top_week6.vcd");
    $dumpvars(0, tb_top_week6);
    clk = 0; reset = 1;
    #10 reset = 0;
    #400 $finish;
end

always #5 clk = ~clk;
endmodule
