module branch_comp(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] funct3,
    output reg branch_taken
);
always @(*) begin
    case (funct3)
        3'b000: branch_taken = (a == b); // BEQ
        3'b001: branch_taken = (a != b); // BNE
        3'b100: branch_taken = ($signed(a) < $signed(b)); // BLT
        3'b101: branch_taken = ($signed(a) >= $signed(b)); // BGE
        default: branch_taken = 0;
    endcase
end
endmodule
