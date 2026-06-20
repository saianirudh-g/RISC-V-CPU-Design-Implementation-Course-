module tb_alu;

reg [31:0] a, b;
reg [3:0] alu_ctrl;
wire [31:0] result;
wire zero;

alu uut(a, b, alu_ctrl, result, zero);

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_alu);

    a = 10; b = 5;

    alu_ctrl = 4'b0000; #10; // ADD
    alu_ctrl = 4'b0001; #10; // SUB
    alu_ctrl = 4'b0010; #10; // AND
    alu_ctrl = 4'b0011; #10; // OR
    alu_ctrl = 4'b0100; #10; // XOR
    alu_ctrl = 4'b0101; #10; // SLT

    $finish;
end

endmodule