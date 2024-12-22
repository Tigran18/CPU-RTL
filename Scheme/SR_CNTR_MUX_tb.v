`include "SR_CNTR_MUX.v"

module tb_top;
    reg clk;
    reg reset;
    reg [7:0] sn1;
    reg incr;
    reg en;
    wire y;

    always begin 
        #5 clk = ~clk;
        #10 en=~en;
        #15 incr=~incr;
    end

    top uut (
        .clk(clk),
        .reset(reset),
        .sn1(sn1),
        .incr(incr),
        .en(en),
        .y(y)
    );

    initial begin
        $dumpfile("SR_CNTR_MUX.vcd");    
        $dumpvars(0, tb_top);
        clk = 0;
        incr=1;
        en=1;
        reset = 1;
        sn1 = 8'b00000000;

        #10 reset = 0;

        for (integer i = 0; i < 256; i += 1) begin
            #10 sn1 = sn1 + 1;
        end
        #1000 $finish;
    end

    initial begin
        $monitor("Time: %0t | Reset: %b | sn1: %b | MUX Output: %b",  $time, reset, sn1, y);
    end
endmodule
