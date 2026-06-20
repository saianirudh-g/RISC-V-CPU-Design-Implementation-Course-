module id_ex(
    input wire clk,
    input wire reset,
    input wire [31:0] rs1_data_in,
    input wire [31:0] rs2_data_in,
    input wire [31:0] imm_in,
    input wire [3:0] alu_ctrl_in,
    output wire [31:0] rs1_data_out,
    output wire [31:0] rs2_data_out,
    output wire [31:0] imm_out,
    output wire [3:0] alu_ctrl_out
);
pipe_reg #(32) RS1_REG(clk, reset, rs1_data_in, rs1_data_out);
pipe_reg #(32) RS2_REG(clk, reset, rs2_data_in, rs2_data_out);
pipe_reg #(32) IMM_REG(clk, reset, imm_in, imm_out);
pipe_reg #(4)  ALU_CTRL_REG(clk, reset, alu_ctrl_in, alu_ctrl_out);
endmodule
