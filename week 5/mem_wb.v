module mem_wb(
    input wire clk,
    input wire reset,
    input wire [31:0] mem_data_in,
    input wire [31:0] alu_result_in,
    output wire [31:0] mem_data_out,
    output wire [31:0] alu_result_out
);
pipe_reg #(32) MEM_REG(clk, reset, mem_data_in, mem_data_out);
pipe_reg #(32) ALU_REG(clk, reset, alu_result_in, alu_result_out);
endmodule
