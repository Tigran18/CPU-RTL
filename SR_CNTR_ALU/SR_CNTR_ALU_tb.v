`include "SR_CNTR_ALU.v"

module SCHEME_tb;

    reg clk;
    reg res;
    reg d;
    reg inc;
    reg EN;

    wire [7:0]out;

    SCHEME u_scheme (
        .clk(clk), 
        .res(res), 
        .d(d), 
        .inc(inc),
        .EN(EN),
        .out(out)
    );

    initial begin
        clk = 0; 
        EN=1;
        inc=0;
    end

    always begin
        #5 clk = ~clk;
        #1 EN=~EN;
        #1 inc=~inc;
    end

    initial begin
        $dumpfile("SR_CNTR_ALU.vcd");
        $dumpvars(0, u_scheme);
        res = 1;
        d = 1'b0;
        res=0;
        for(integer i=0; i<32; i=i+1) begin
            d=~d;
            #10;
        end
        #20 $finish;
    end

    initial begin
        $monitor("Time=%0d clk=%b res=%b d=%b out=%b", $time, clk, res, d, out);
    end

endmodule
