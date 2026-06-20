`timescale 1ns/1ps
module tb_top_week5;
reg clk, reset;
top_week5 uut(clk, reset);

initial begin
    $dumpfile("top_week5.vcd");
    $dumpvars(0, tb_top_week5);
    clk = 0; reset = 1;
    #10 reset = 0;
    #300 $finish;
end

always #5 clk = ~clk;
endmodule
