module SRAM #(
    parameter ADDR=8, 
    parameter WIDTH=32, 
    parameter LENGTH=256
    )(
    input clk,
    input CS,
    input WE,
    input [ADDR-1:0] addr,
//    input [WIDTH-1:0] data_in,
    output [WIDTH-1:0] instruction,
    output reg[WIDTH-1:0] data_out
);

reg [WIDTH-1:0] mem[0:LENGTH-1];
assign instruction=mem[addr];

initial begin
    $readmemb("C:/Users/HP/Desktop/Verilog/SRAM/file.txt", mem);
end

always @(posedge clk) begin
    if(CS)begin
        if (WE) begin
            mem[addr] <= data_in;
        end 
        else begin
            data_out <= mem[addr];
        end
    end
end

endmodule
