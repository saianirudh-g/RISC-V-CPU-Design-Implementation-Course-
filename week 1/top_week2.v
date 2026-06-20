module top_week2(
    input wire clk,
    input wire reset
);
wire [31:0] pc_out, pc_next, instr;
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;

assign pc_next = pc_out + 4;

pc PC(clk, reset, pc_next, pc_out);
instr_mem IM(pc_out, instr);
decoder DEC(instr, opcode, rd, funct3, rs1, rs2, funct7);
endmodule
