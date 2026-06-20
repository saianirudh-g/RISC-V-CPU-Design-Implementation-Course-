`timescale 1ns/1ps
module tb_top_week4;
reg clk, reset;
top_week4 uut(clk, reset);

initial begin
    $dumpfile("top_week4.vcd");
    $dumpvars(0, tb_top_week4);
    clk = 0; reset = 1;
    #10 reset = 0;
    #200 $finish;
end

always #5 clk = ~clk;
endmodule
