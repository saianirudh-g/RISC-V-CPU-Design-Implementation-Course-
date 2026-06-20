`timescale 1ns/1ps

module tb_top_week3;

    reg clk;
    reg reset;

    // Instantiate the top module
    top_week3 uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Dumpfile setup
        $dumpfile("top_week3.vcd");
        $dumpvars(0, tb_top_week3);

        // Initialize
        clk = 0;
        reset = 1;

        // Release reset
        #10 reset = 0;

        // Run simulation
        #200 $finish;
    end

endmodule
