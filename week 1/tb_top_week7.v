`timescale 1ns/1ps

module tb_top_week7;

    reg clk;
    reg reset;

    // Instantiate the top-level module
    top_week7 uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // VCD dump
        $dumpfile("top_week7.vcd");
        $dumpvars(0, tb_top_week7);

        // Initialize
        clk = 0;
        reset = 1;

        // Release reset
        #20 reset = 0;

        // Run simulation long enough to fill + drain pipeline
        #500 $finish;
    end

endmodule
