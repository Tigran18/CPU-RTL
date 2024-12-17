`timescale 1ns / 1ns
`include "AND.v"

module AND_tb;
    reg a;
    reg b;
    wire c;
    AND u_and(a, b, c);
    initial begin
        $dumpfile("AND_tb.vcd");
        $dumpvars(0, AND_tb);
        a=1'b0; b=1'b0;
        #2a=1'b0; b=1'b1;
        #2a=1'b1; b=1'b0;
        #2a=1'b1; b=1'b1;
        #20;
        $display("Test Complete");
    end
endmodule