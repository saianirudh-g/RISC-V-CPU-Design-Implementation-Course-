module top_week5(
    input wire clk,
    input wire reset
);
wire [31:0] pc_out, pc_next, instr;
wire [31:0] pc_id, instr_id;
wire [31:0] rs1_data, rs2_data, imm, alu_result, mem_data, wb_data;
wire [3:0] alu_ctrl;

assign pc_next = pc_out + 4;

pc PC(clk, reset, pc_next, pc_out);
instr_mem IM(pc_out, instr);
if_id IFID(clk, reset, pc_out, instr, pc_id, instr_id);
decoder DEC(instr_id, , , , , , ); // connect fields
alu_control AC( , , , alu_ctrl);
id_ex IDEX(clk, reset, rs1_data, rs2_data, imm, alu_ctrl, rs1_data, rs2_data, imm, alu_ctrl);
alu ALU(rs1_data, rs2_data, alu_ctrl, alu_result, );
ex_mem EXMEM(clk, reset, alu_result, rs2_data, alu_result, rs2_data);
data_mem DM(clk, , , alu_result, rs2_data, mem_data);
mem_wb MEMWB(clk, reset, mem_data, alu_result, mem_data, alu_result);
writeback_mux WB(alu_result, mem_data, , wb_data);
endmodule
