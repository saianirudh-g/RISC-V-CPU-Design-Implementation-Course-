module if_id(
    input wire clk,
    input wire reset,
    input wire [31:0] pc_in,
    input wire [31:0] instr_in,
    output wire [31:0] pc_out,
    output wire [31:0] instr_out
);
pipe_reg #(32) PC_REG(clk, reset, pc_in, pc_out);
pipe_reg #(32) INSTR_REG(clk, reset, instr_in, instr_out);
endmodule
