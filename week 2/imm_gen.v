module imm_gen(
    input wire [31:0] instr,
    output reg [31:0] imm_out
);
always @(*) begin
    case (instr[6:0])
        7'b0010011: imm_out = {{20{instr[31]}}, instr[31:20]}; // I‑type
        7'b0100011: imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S‑type
        7'b1100011: imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B‑type
        default: imm_out = 0;
    endcase
end
endmodule
