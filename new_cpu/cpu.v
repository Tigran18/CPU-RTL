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
    $readmemb("/home/tigran1809/Verilog/CPU-RTL/new_cpu/file.txt", data);
end

always @(posedge clk) begin
    if (cs) begin
        data_out <= data[address];
    end
end

endmodule
