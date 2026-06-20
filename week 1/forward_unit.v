module forward_unit(
    input wire [4:0] rs1_ex,
    input wire [4:0] rs2_ex,
    input wire [4:0] rd_mem,
    input wire [4:0] rd_wb,
    input wire reg_write_mem,
    input wire reg_write_wb,
    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);
always @(*) begin
    // Default: no forwarding
    forward_a = 2'b00;
    forward_b = 2'b00;

    // Forward from MEM stage
    if (reg_write_mem && (rd_mem != 0) && (rd_mem == rs1_ex))
        forward_a = 2'b10;
    if (reg_write_mem && (rd_mem != 0) && (rd_mem == rs2_ex))
        forward_b = 2'b10;

    // Forward from WB stage
    if (reg_write_wb && (rd_wb != 0) && (rd_wb == rs1_ex))
        forward_a = 2'b01;
    if (reg_write_wb && (rd_wb != 0) && (rd_wb == rs2_ex))
        forward_b = 2'b01;
end
endmodule
