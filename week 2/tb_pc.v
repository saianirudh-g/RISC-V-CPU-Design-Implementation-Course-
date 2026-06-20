module tb_pc;
reg clk, reset;
wire [31:0] pc_out;
reg [31:0] pc_next;

pc uut(clk, reset, pc_next, pc_out);

initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0, tb_pc);
    clk = 0; reset = 1; pc_next = 0;
    #10 reset = 0;
    pc_next = 4; #10;
    pc_next = 8; #10;
    pc_next = 12; #10;
    $finish;
end

always #5 clk = ~clk;
endmodule