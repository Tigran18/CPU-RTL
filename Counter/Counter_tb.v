`include "Counter.v"

module counter_tb;

    // Testbench signals
    reg clk;
    reg reset;
    wire [3:0] q;

    // Instantiate the counter module
    counter uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Generate a clock with a period of 10 ns
    end

    // Test sequence
    initial begin
        // Dump waveforms for simulation (optional)
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);

        // Initialize inputs
        reset = 1;  // Assert reset
        #10;
        
        reset = 0;  // Deassert reset
        #50;        // Run the counter for 50 ns

        reset = 1;  // Assert reset again to check reset functionality
        #10;

        reset = 0;  // Deassert reset
        #10;        // Run the counter again for 50 ns

        $finish;    // End the simulation
    end

    // Display counter value
    always @(q) begin
        $display("Time = %0t: Counter = %b", $time, q);
    end

endmodule
