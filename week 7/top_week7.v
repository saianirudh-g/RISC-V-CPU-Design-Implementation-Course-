module top_week7(
    input wire clk,
    input wire reset
);

// =========================
// IF STAGE
// =========================
wire [31:0] pc_out, pc_next, instr;
pc PC(clk, reset, pc_next, pc_out);
instr_mem IM(pc_out, instr);

// =========================
// IF/ID PIPELINE REGISTER
// =========================
wire [31:0] pc_id, instr_id;
if_id IFID(
    .clk(clk),
    .reset(reset),
    .pc_in(pc_out),
    .instr_in(instr),
    .pc_out(pc_id),
    .instr_out(instr_id)
);

// =========================
// ID STAGE
// =========================
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;

decoder DEC(instr_id, opcode, rd, funct3, rs1, rs2, funct7);

wire [31:0] rs1_data, rs2_data;
regfile RF(clk, reset, rs1, rs2, wb_data, rd, reg_write_wb, rs1_data, rs2_data);

wire [31:0] imm;
imm_gen IG(instr_id, imm);

// =========================
// ID/EX PIPELINE REGISTER
// =========================
wire [31:0] rs1_ex, rs2_ex, imm_ex;
wire [3:0] alu_ctrl_ex;

id_ex IDEX(
    .clk(clk),
    .reset(reset),
    .rs1_data_in(rs1_data),
    .rs2_data_in(rs2_data),
    .imm_in(imm),
    .alu_ctrl_in(alu_ctrl),
    .rs1_data_out(rs1_ex),
    .rs2_data_out(rs2_ex),
    .imm_out(imm_ex),
    .alu_ctrl_out(alu_ctrl_ex)
);

// =========================
// HAZARD + FORWARDING
// =========================
wire stall;
hazard_unit HU(rs1, rs2, rd_ex, mem_read_ex, stall);

wire [1:0] forward_a, forward_b;
forward_unit FU(rs1_ex, rs2_ex, rd_mem, rd_wb, reg_write_mem, reg_write_wb, forward_a, forward_b);

// =========================
// EX STAGE
// =========================
wire [31:0] alu_in1, alu_in2;

// Forwarding MUXes
assign alu_in1 = (forward_a == 2'b10) ? alu_result_mem :
                 (forward_a == 2'b01) ? wb_data :
                 rs1_ex;

assign alu_in2 = (forward_b == 2'b10) ? alu_result_mem :
                 (forward_b == 2'b01) ? wb_data :
                 rs2_ex;

wire [31:0] alu_result;
alu ALU(alu_in1, alu_in2, alu_ctrl_ex, alu_result, );

// Branch logic
wire branch_taken;
branch_comp BC(alu_in1, alu_in2, funct3, branch_taken);

// =========================
// EX/MEM PIPELINE REGISTER
// =========================
wire [31:0] alu_result_mem, rs2_mem;
ex_mem EXMEM(clk, reset, alu_result, rs2_ex, alu_result_mem, rs2_mem);

// =========================
// MEM STAGE
// =========================
wire [31:0] mem_data;
data_mem DM(clk, mem_read_ex, mem_write_ex, alu_result_mem, rs2_mem, mem_data);

// =========================
// MEM/WB PIPELINE REGISTER
// =========================
wire [31:0] mem_data_wb, alu_result_wb;
mem_wb MEMWB(clk, reset, mem_data, alu_result_mem, mem_data_wb, alu_result_wb);

// =========================
// WB STAGE
// =========================
wire [31:0] wb_data;
writeback_mux WB(alu_result_wb, mem_data_wb, mem_to_reg_wb, wb_data);

// =========================
// PERFORMANCE COUNTER
// =========================
wire instr_complete = reg_write_wb;
wire [31:0] cycle_count, instr_count;

perf_counter PERF(clk, reset, instr_complete, cycle_count, instr_count);

// PC update
assign pc_next = pc_out + 4;

endmodule
