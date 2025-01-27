module SRAM #(parameter ADDR=8, parameter WIDTH=32, parameter LENGTH=256)(
    input clk,
    input CS,
    input [ADDR-1:0] addr,
//    input [WIDTH-1:0] data_in,
    output reg[WIDTH-1:0] data_out1,
    output reg[WIDTH-1:0] data_out2,
);

reg [WIDTH-1:0] mem[0:LENGTH-1];

initial begin
    $readmemb("C:/Users/HP/Desktop/Verilog/SRAM/file.txt", mem);
end

always @(posedge clk) begin
    if(CS) begin
        if(instruction[7:4]!=4'b0000) begin
            data_out1 <= mem[addr[15:8]];
            data_out2 <= mem[addr[7:0]];
        end
        else begin
            mem[addr[7:0]] <= data_out1;
        end 
    end
end

// always @(posedge clk) begin
//     if (WE) begin
//         mem[addr] <= data_in;
//     end 
//     else begin
//         data_out <= mem[addr];
//     end
// end

endmodule
