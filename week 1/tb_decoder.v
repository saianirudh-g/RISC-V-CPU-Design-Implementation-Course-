module tb_decoder;
reg [31:0] instr;
wire [6:0] opcode;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;
wire [6:0] funct7;

decoder uut(instr, opcode, rd, funct3, rs1, rs2, funct7);

initial begin
    $dumpfile("decoder.vcd");
    $dumpvars(0, tb_decoder);
    instr = 32'h002081B3; #10;
    instr = 32'h00310233; #10;
    $finish;
end
endmodule
