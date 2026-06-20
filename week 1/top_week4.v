module top_week4(
    input wire clk,
    input wire reset
);
wire [31:0] pc_out, pc_next, instr;
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;
wire [3:0] alu_ctrl;
wire [31:0] alu_result, mem_data, wb_data;
wire mem_read, mem_write, mem_to_reg, reg_write;

assign pc_next = pc_out + 4;

pc PC(clk, reset, pc_next, pc_out);
instr_mem IM(pc_out, instr);
decoder DEC(instr, opcode, rd, funct3, rs1, rs2, funct7);
alu_control AC(funct3, funct7, opcode, alu_ctrl);
alu ALU(32'd10, 32'd5, alu_ctrl, alu_result, );
data_mem DM(clk, mem_read, mem_write, alu_result, 32'hA5A5A5A5, mem_data);
writeback_mux WB(alu_result, mem_data, mem_to_reg, wb_data);
endmodule
