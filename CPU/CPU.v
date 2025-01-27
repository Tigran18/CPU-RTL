`include "C:/Users/HP/Desktop/Verilog/SRAM/SRAM.v"
`include "C:/Users/HP/Desktop/Verilog/SRAM/ALU.v"

module CPU(
    input clk,
    input cs,
    input reset,
    input [7:0] instruction,
    output reg [7:0] reg1,
    output reg [7:0] reg2,
    output reg [7:0] reg3,
    output reg [7:0] reg4
);

reg [7:0] result;

always@(posedge clk)begin
    if(reset)begin
        reg1 <= 8'b0;
        reg2 <= 8'b0;
        reg3 <= 8'b0;
        reg4 <= 8'b0;
    end
    else begin
        case(instruction[7:6])
            2'b00: reg1 <= result;
            2'b01: reg2 <= result;
            2'b10: reg3 <= result;
            2'b11: reg4 <= result;
        endcase
    end
end

SRAM u_SRAM(
    .clk(clk),
    .CS(cs),
    .addr(instruction[7:0]),
//    input [WIDTH-1:0] data_in,
    .data_out1(data1),
    .data_out2(data2)
);

ALU u_ALU(
    .data1(data1),
    .data2(data2),
    .opcode(instruction[2:0]),
    .result(result)
);

endmodule