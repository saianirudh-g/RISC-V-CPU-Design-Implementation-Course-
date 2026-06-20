module top_week6(
    input wire clk,
    input wire reset
);
wire [31:0] pc_out, instr, alu_result, mem_data, wb_data;
wire [4:0] rs1_ex, rs2_ex, rd_ex, rd_mem, rd_wb;
wire mem_read_ex, reg_write_mem, reg_write_wb;
wire stall, flush;
wire [1:0] forward_a, forward_b;
wire branch_taken;

pc PC(clk, reset, , pc_out);
instr_mem IM(pc_out, instr);
hazard_unit HU(rs1_ex, rs2_ex, rd_ex, mem_read_ex, stall);
forward_unit FU(rs1_ex, rs2_ex, rd_mem, rd_wb, reg_write_mem, reg_write_wb, forward_a, forward_b);
branch_flush BF(branch_taken, flush);
endmodule
