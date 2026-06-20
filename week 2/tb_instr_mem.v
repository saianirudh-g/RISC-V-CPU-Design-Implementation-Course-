module tb_instr_mem;
reg [31:0] addr;
wire [31:0] instr;

instr_mem uut(addr, instr);

initial begin
    $dumpfile("instr_mem.vcd");
    $dumpvars(0, tb_instr_mem);
    addr = 0; #10;
    addr = 4; #10;
    addr = 8; #10;
    $finish;
end
endmodule