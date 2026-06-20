// instr_mem.v (replace contents)
module instr_mem(
    input wire [31:0] addr,
    output reg [31:0] instr
);
reg [31:0] mem [0:31];

initial begin
    // Simple RISC‑V program
    mem[0] = 32'h002081b3; // ADD x3, x1, x2
    mem[1] = 32'h40310233; // SUB x4, x2, x3
    mem[2] = 32'h00520313; // ADDI x6, x4, 5
    mem[3] = 32'h0062a423; // SW x6, 0(x5)
    mem[4] = 32'h0002a503; // LW x10, 0(x5)
    mem[5] = 32'h00a30463; // BEQ x6, x10, +8
    mem[6] = 32'h00000013; // NOP
    mem[7] = 32'h00000013; // NOP
end

always @(*) instr = mem[addr[6:2]];
endmodule
