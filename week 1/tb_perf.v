module tb_perf;
reg clk, reset;
wire [31:0] cycle_count, instr_count;
wire instr_complete;

perf_counter PC(clk, reset, instr_complete, cycle_count, instr_count);

initial begin
    $dumpfile("perf.vcd");
    $dumpvars(0, tb_perf);
    clk = 0; reset = 1;
    #10 reset = 0;
    repeat (100) begin
        #5 clk = ~clk;
        instr_complete = (cycle_count % 5 == 0); // simulate completion every 5 cycles
    end
    $display("CPI = %f", cycle_count / instr_count);
    $display("Throughput = %f instructions per cycle", instr_count / cycle_count);
    $finish;
end
endmodule
