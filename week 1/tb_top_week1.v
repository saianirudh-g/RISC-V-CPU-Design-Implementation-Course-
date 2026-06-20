module tb_top_week1;

reg clk;

top_week1 uut(clk);

initial begin
    $dumpfile("top_week1.vcd");
    $dumpvars(0, tb_top_week1);

    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #100 $finish;
end

endmodule