module ClockAmplifier (
    input clk_in,
    output clk_out
);

    reg [2:0] cntr = 3'b0; 
    assign clk_out = cntr[2];

    always @(posedge clk_in) begin
        cntr <= cntr + 1; 
    end

endmodule
