module tb_top_week2;
reg clk, reset;
top_week2 uut(clk, reset);

initial begin
    $dumpfile("top_week2.vcd");
    $dumpvars(0, tb_top_week2);
    clk = 0; reset = 1;
    #10 reset = 0;
    #100 $finish;
end

always #5 clk = ~clk;
endmodule
