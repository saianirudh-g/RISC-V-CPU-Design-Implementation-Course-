module tb_imm_gen;
reg [31:0] instr;
wire [31:0] imm_out;

imm_gen uut(instr, imm_out);

initial begin
    $dumpfile("imm_gen.vcd");
    $dumpvars(0, tb_imm_gen);
    instr = 32'h00108113; #10; // I‑type
    instr = 32'h00510223; #10; // S‑type
    instr = 32'hFE010EE3; #10; // B‑type
    $finish;
end
endmodule
