`include "clk.v"

module TestClockAmplifier;

    reg clk_in;
    wire clk_out;

    ClockAmplifier clk_amp (
        .clk_in(clk_in),
        .clk_out(clk_out)
    );

    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in; 
    end

    initial begin
        $monitor("Time=%0t: clk_in=%b, clk_out=%b", $time, clk_in, clk_out);
        #200 $finish; 
    end

endmodule
