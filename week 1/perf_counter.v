module perf_counter(
    input wire clk,
    input wire reset,
    input wire instr_complete,
    output reg [31:0] cycle_count,
    output reg [31:0] instr_count
);
always @(posedge clk or posedge reset) begin
    if (reset) begin
        cycle_count <= 0;
        instr_count <= 0;
    end else begin
        cycle_count <= cycle_count + 1;
        if (instr_complete)
            instr_count <= instr_count + 1;
    end
end
endmodule
