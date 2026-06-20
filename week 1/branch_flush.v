module branch_flush(
    input wire branch_taken,
    output reg flush
);
always @(*) begin
    flush = branch_taken ? 1 : 0;
end
endmodule
