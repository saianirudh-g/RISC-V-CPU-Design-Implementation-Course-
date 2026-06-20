module tb_branch_comp;
reg [31:0] a, b;
reg [2:0] funct3;
wire branch_taken;

branch_comp uut(a, b, funct3, branch_taken);

initial begin
    $dumpfile("branch_comp.vcd");
    $dumpvars(0, tb_branch_comp);
    a = 10; b = 10; funct3 = 3'b000; #10; // BEQ
    a = 10; b = 5;  funct3 = 3'b001; #10; // BNE
    a = 5;  b = 10; funct3 = 3'b100; #10; // BLT
    $finish;
end
endmodule
