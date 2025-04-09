module sram #(
    parameter addr=4,
    parameter width=8,
    parameter length=16
)
(
    input clk,
    input cs,
    input [addr-1:0] address,
    output reg [width-1:0] data_out
);

reg [width-1:0] data [length-1:0];

initial begin
    data[0]  = 8'b00010010;
    data[1]  = 8'b00100100;
    data[2]  = 8'b01010000;
    data[3]  = 8'b00010101;
    data[4]  = 8'b00101110;
    data[5]  = 8'b10110000;
    data[6]  = 8'b11010110;
    data[7]  = 8'b00100011;
    data[8]  = 8'b01011000;
    data[9]  = 8'b11010100;
    data[10] = 8'b00011010;
    data[11] = 8'b00111011;
    data[12] = 8'b10111100;
    data[13] = 8'b11011011;
    data[14] = 8'b00011111;
    data[15] = 8'b11111111;
    
    data_out = 0;
end

always @(posedge clk) begin
    if (cs) begin
        data_out <= data[address];
    end
end

endmodule
