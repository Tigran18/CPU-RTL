//`include "C:/Users/HP/Desktop/Verilog/SRAM/SRAM.v"
//`include "C:/Users/HP/Desktop/Verilog/SRAM/ALU.v"

module CPU(
    input clk,
    input cs,
    input we,
    input reset,
    output reg [7:0] reg1,
    output reg [7:0] reg2,
    output reg [7:0] reg3,
    output reg [7:0] reg4
);

reg [3:0] programm_counter;
wire [7:0] result;
wire [7:0] instruction;
wire [7:0] data;

always@(posedge clk)begin
    if(reset)begin
        reg1 <= 8'b0;
        reg2 <= 8'b0;
        reg3 <= 8'b0;
        reg4 <= 8'b0;
    end
    else begin
        programm_counter<=programm_counter+1;
        case(instruction[7:6])
            2'b00:begin
                reg1<=result;
            end
            2'b01:begin
                reg2<=result;
            end
            2'b10:begin
                reg3<=result;
            end
            2'b11:begin
                reg4<=result;
            end
        endcase
    end
end

SRAM #(
    .ADDR(4),
    .WIDTH(8),
    .LENGTH(16)
)u_SRAM(
    .clk(clk),
    .CS(cs),
    .WE(we),
    .addr(programm_counter),
    .data_out(data)
);

ALU u_ALU(
    .data1(reg1),
    .data2(reg2),
    .opcode(instruction[5:4]),
    .result(result)
);

endmodule