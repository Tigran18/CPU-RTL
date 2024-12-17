`include "Scheme.v"

module tb_top;
    reg clk;
    reg reset;
    reg [7:0] sn1;
    wire y;

    top uut (
        .clk(clk),
        .reset(reset),
        .sn1(sn1),
        .y(y)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("scheme.vcd");    
        $dumpvars(0, tb_top);
        clk = 0;
        reset = 1;
        sn1 = 8'b00000000;

        #10 reset = 0;

        for (integer i = 0; i < 8; i += 1) begin
            #10 sn1 = sn1 + 1;
        end
        #80 $finish;
    end

    initial begin
        $monitor("Time: %0t | Reset: %b | sn1: %b | MUX Output: %b",  $time, reset, sn1, y);
    end
endmodule
