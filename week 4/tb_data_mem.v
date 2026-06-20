module tb_data_mem;
reg clk, mem_read, mem_write;
reg [31:0] addr, write_data;
wire [31:0] read_data;

data_mem uut(clk, mem_read, mem_write, addr, write_data, read_data);

initial begin
    $dumpfile("data_mem.vcd");
    $dumpvars(0, tb_data_mem);

    clk = 0;
    mem_read = 0;
    mem_write = 1;
    addr = 8; write_data = 32'hA5A5A5A5;
    #10 mem_write = 0; mem_read = 1;
    #10 addr = 8;
    #10 $finish;
end

always #5 clk = ~clk;
endmodule
