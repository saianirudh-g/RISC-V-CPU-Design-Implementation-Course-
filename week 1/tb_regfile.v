module tb_regfile;

reg clk;
reg we;
reg [4:0] rs1, rs2, rd;
reg [31:0] wd;
wire [31:0] rd1, rd2;

regfile uut(clk, we, rs1, rs2, rd, wd, rd1, rd2);

initial begin
    $dumpfile("regfile.vcd");
    $dumpvars(0, tb_regfile);

    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    we = 1;
    rd = 5; wd = 32'hA5A5A5A5;
    #10;

    we = 0;
    rs1 = 5;
    rs2 = 0;
    #10;

    $finish;
end

endmodule