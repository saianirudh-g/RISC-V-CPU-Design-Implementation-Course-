module hazard_unit(
    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd_ex,
    input wire mem_read_ex,
    output reg stall
);
always @(*) begin
    if (mem_read_ex && ((rd_ex == rs1) || (rd_ex == rs2)))
        stall = 1; // stall pipeline
    else
        stall = 0;
end
endmodule
