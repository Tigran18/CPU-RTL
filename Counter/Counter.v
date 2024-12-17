module counter (
    input clk,          // Clock signal
    input reset,        // Reset signal
    output reg [3:0] q  // 4-bit output
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 4'b0000;   // Reset the counter
        else
            q <= q + 1;     // Increment the counter
    end
endmodule
