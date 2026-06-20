module pipe_reg #(parameter WIDTH = 32)(
    input wire clk,
    input wire reset,
    input wire [WIDTH-1:0] in_data,
    output reg [WIDTH-1:0] out_data
);
always @(posedge clk or posedge reset) begin
    if (reset)
        out_data <= 0;
    else
        out_data <= in_data;
end
endmodule
