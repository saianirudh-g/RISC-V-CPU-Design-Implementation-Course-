module alu(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] alu_ctrl,
    output reg [31:0] result,
    output wire zero
);

assign zero = (result == 0);

always @(*) begin
    case(alu_ctrl)
        4'b0000: result = a + b;
        4'b0001: result = a - b;
        4'b0010: result = a & b;
        4'b0011: result = a | b;
        4'b0100: result = a ^ b;
        4'b0101: result = ($signed(a) < $signed(b)) ? 1 : 0;
        default: result = 0;
    endcase
end

endmodule