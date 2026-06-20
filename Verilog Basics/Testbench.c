module tb_inverter;
    reg a;
    wire y;

    inverter uut(.a(a), .y(y));

    initial begin
        a = 0;
        #10 a = 1;
        #10 a = 0;
        #10 $finish;
    end
endmodule
