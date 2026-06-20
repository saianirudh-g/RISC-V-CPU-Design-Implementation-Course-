module top_week7(
    input wire clk,
    input wire reset
);

// =========================
// IF STAGE
// =========================
wire [31:0] pc_out, pc_next, instr;

assign pc_next = pc_out + 4;

pc PC(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc_out(pc_out)
);

instr_mem IM(
    .addr(pc_out),
    .instr(instr)
);

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

decoder DEC(
    .instr(instr_id),
    .opcode(opcode),
    .rd(rd),
    .funct3(funct3),
    .rs1(rs1),
    .rs2(rs2),
    .funct7(funct7)
);

wire [31:0] rs1_data, rs2_data;

// Writeback side signals (stubbed)
wire [31:0] wb_data;
wire        reg_write_wb;
wire [4:0]  rd_wb;

assign reg_write_wb = 1'b0;   // no actual writes (stub)
assign rd_wb        = 5'd0;   // no real destination (stub)

regfile RF(
    .clk(clk),
    .we(reg_write_wb),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd_wb),
    .wd(wb_data),
    .rd1(rs1_data),
    .rd2(rs2_data)
);

wire [31:0] imm;

imm_gen IG(
    .instr(instr_id),
    .imm_out(imm)
);

// ALU control
wire [3:0] alu_ctrl;

alu_control AC(
    .funct3(funct3),
    .funct7(funct7),
    .opcode(opcode),
    .alu_ctrl(alu_ctrl)
);

// =========================
// ID/EX PIPELINE REGISTER
// =========================
wire [31:0] rs1_ex, rs2_ex, imm_ex;
wire [3:0]  alu_ctrl_ex;

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
// HAZARD UNIT (stubbed control)
// =========================
wire stall;
wire [4:0] rd_ex;
wire       mem_read_ex;

assign rd_ex       = 5'd0;   // no real EX dest (stub)
assign mem_read_ex = 1'b0;   // no real load (stub)

hazard_unit HU(
    .rs1(rs1),
    .rs2(rs2),
    .rd_ex(rd_ex),
    .mem_read_ex(mem_read_ex),
    .stall(stall)
);

// =========================
// FORWARDING UNIT (stubbed control)
// =========================
wire [1:0] forward_a, forward_b;
wire [4:0] rd_mem;
wire       reg_write_mem;

assign rd_mem       = 5'd0;  // no real MEM dest (stub)
assign reg_write_mem = 1'b0; // no real MEM write (stub)

forward_unit FU(
    .rs1_ex(rs1_ex[4:0]),
    .rs2_ex(rs2_ex[4:0]),
    .rd_mem(rd_mem),
    .rd_wb(rd_wb),
    .reg_write_mem(reg_write_mem),
    .reg_write_wb(reg_write_wb),
    .forward_a(forward_a),
    .forward_b(forward_b)
);

// =========================
// EX STAGE
// =========================
wire [31:0] alu_in1, alu_in2;

assign alu_in1 =
    (forward_a == 2'b10) ? alu_result_mem :
    (forward_a == 2'b01) ? wb_data :
    rs1_ex;

assign alu_in2 =
    (forward_b == 2'b10) ? alu_result_mem :
    (forward_b == 2'b01) ? wb_data :
    rs2_ex;

wire [31:0] alu_result;
wire        alu_zero;

alu ALU(
    .a(alu_in1),
    .b(alu_in2),
    .alu_ctrl(alu_ctrl_ex),
    .result(alu_result),
    .zero(alu_zero)
);

// Branch comparator
wire branch_taken;

branch_comp BC(
    .a(alu_in1),
    .b(alu_in2),
    .funct3(funct3),
    .branch_taken(branch_taken)
);

// =========================
// EX/MEM PIPELINE REGISTER
// =========================
wire [31:0] alu_result_mem, rs2_mem;

ex_mem EXMEM(
    .clk(clk),
    .reset(reset),
    .alu_result_in(alu_result),
    .rs2_data_in(rs2_ex),
    .alu_result_out(alu_result_mem),
    .rs2_data_out(rs2_mem)
);

// =========================
// MEM STAGE
// =========================
wire [31:0] mem_data;
wire        mem_write_ex;

assign mem_write_ex = 1'b0; // stub: no stores

data_mem DM(
    .clk(clk),
    .mem_read(mem_read_ex),
    .mem_write(mem_write_ex),
    .addr(alu_result_mem),
    .write_data(rs2_mem),
    .read_data(mem_data)
);

// =========================
// MEM/WB PIPELINE REGISTER
// =========================
wire [31:0] mem_data_wb, alu_result_wb;

mem_wb MEMWB(
    .clk(clk),
    .reset(reset),
    .mem_data_in(mem_data),
    .alu_result_in(alu_result_mem),
    .mem_data_out(mem_data_wb),
    .alu_result_out(alu_result_wb)
);

// =========================
// WB STAGE
// =========================
wire mem_to_reg_wb;

assign mem_to_reg_wb = 1'b0; // stub: always take ALU result

writeback_mux WB(
    .alu_result(alu_result_wb),
    .mem_data(mem_data_wb),
    .mem_to_reg(mem_to_reg_wb),
    .wb_data(wb_data)
);

// =========================
// PERFORMANCE COUNTER
// =========================
wire instr_complete;
wire [31:0] cycle_count, instr_count;

assign instr_complete = reg_write_wb; // will be 0 with current stub

perf_counter PERF(
    .clk(clk),
    .reset(reset),
    .instr_complete(instr_complete),
    .cycle_count(cycle_count),
    .instr_count(instr_count)
);

endmodule
