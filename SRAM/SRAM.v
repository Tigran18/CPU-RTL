module SRAM(
    input clk,
    input res,
    input WE,
    input [7:0] addr,
    input [31:0] data_in,
    output reg [31:0] data_out
);

reg [31:0] mem[0:255];
integer i;  

always @(posedge clk or posedge res) begin
    if (res) begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = 0;
        end
    end else begin
        if (WE) begin
            mem[addr] <= data_in;
        end 
        else begin
            data_out <= mem[addr];
        end
    end
end

endmodule
