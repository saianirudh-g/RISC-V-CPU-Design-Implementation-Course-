module control_unit(
    input wire [6:0] opcode,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg reg_write
);
always @(*) begin
    case (opcode)
        7'b0110011: begin // R-type
            alu_src = 0; mem_read = 0; mem_write = 0; branch = 0; reg_write = 1;
        end
        7'b0000011: begin // Load
            alu_src = 1; mem_read = 1; mem_write = 0; branch = 0; reg_write = 1;
        end
        7'b0100011: begin // Store
            alu_src = 1; mem_read = 0; mem_write = 1; branch = 0; reg_write = 0;
        end
        7'b1100011: begin // Branch
            alu_src = 0; mem_read = 0; mem_write = 0; branch = 1; reg_write = 0;
        end
        default: begin
            alu_src = 0; mem_read = 0; mem_write = 0; branch = 0; reg_write = 0;
        end
    endcase
end
endmodule
