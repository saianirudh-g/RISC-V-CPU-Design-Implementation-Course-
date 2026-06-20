module ex_mem(
    input wire clk,
    input wire reset,
    input wire [31:0] alu_result_in,
    input wire [31:0] rs2_data_in,
    output wire [31:0] alu_result_out,
    output wire [31:0] rs2_data_out
);
pipe_reg #(32) ALU_REG(clk, reset, alu_result_in, alu_result_out);
pipe_reg #(32) RS2_REG(clk, reset, rs2_data_in, rs2_data_out);
endmodule
