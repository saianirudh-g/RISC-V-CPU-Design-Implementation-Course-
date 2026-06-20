module tb_alu_control;
reg [2:0] funct3;
reg [6:0] funct7, opcode;
wire [3:0] alu_ctrl;

alu_control uut(funct3, funct7, opcode, alu_ctrl);

initial begin
    $dumpfile("alu_control.vcd");
    $dumpvars(0, tb_alu_control);
    opcode = 7'b0110011;
    funct7 = 7'b0000000; funct3 = 3'b000; #10; // ADD
    funct7 = 7'b0100000; funct3 = 3'b000; #10; // SUB
    funct7 = 7'b0000000; funct3 = 3'b111; #10; // AND
    $finish;
end
endmodule
