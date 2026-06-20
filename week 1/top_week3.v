module top_week3(
    input wire clk,
    input wire reset
);
wire [31:0] pc_out, pc_next, instr;
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;
wire [3:0] alu_ctrl;
wire [31:0] alu_result;
wire branch_taken;

assign pc_next = branch_taken ? pc_out + 4 : pc_out + 4;

pc PC(clk, reset, pc_next, pc_out);
instr_mem IM(pc_out, instr);
decoder DEC(instr, opcode, rd, funct3, rs1, rs2, funct7);
alu_control AC(funct3, funct7, opcode, alu_ctrl);
alu ALU(32'd10, 32'd5, alu_ctrl, alu_result, ); // example operands
branch_comp BC(32'd10, 32'd5, funct3, branch_taken);
endmodule
