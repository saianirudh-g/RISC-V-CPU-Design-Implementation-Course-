module top_week1(
    input wire clk
);

wire [31:0] rd1, rd2, alu_out;

regfile RF(
    .clk(clk),
    .we(1'b1),
    .rs1(5'd1),
    .rs2(5'd2),
    .rd(5'd3),
    .wd(32'd50),
    .rd1(rd1),
    .rd2(rd2)
);

alu ALU(
    .a(rd1),
    .b(rd2),
    .alu_ctrl(4'b0000),
    .result(alu_out)
);

endmodule