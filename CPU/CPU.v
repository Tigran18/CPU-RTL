`include "../SRAM/SRAM.v"
`include "../ALU/ALU.v"

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

reg [3:0]programm_counter;
reg [7:0] data_in;
wire [7:0] result;
wire [7:0] instruction;

always@(posedge clk)begin
    if(reset)begin
        reg1 <= 8'b0;
        reg2 <= 8'b0;
        reg3 <= 8'b0;
        reg4 <= 8'b0;
        programm_counter<=4'b0;
    end
    else begin
        programm_counter<=programm_counter+1;
        if(~we)begin
            case(instruction[7:6])
                2'b00:begin
                    reg1<=instruction[3:0];
                end
                2'b01:begin
                    reg2<=instruction[3:0];
                end
                2'b10:begin
                    reg3<=instruction[3:0];
                end
                2'b11:begin
                    reg4<=instruction[3:0];
                end
            endcase
        end
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
    .data_in(data_in),
    .instruction(instruction)
);

ALU u_ALU(
    .data1(reg1),
    .data2(reg2),
    .cs(cs),
    .opcode(instruction[5:4]),
    .result(result)
);

endmodule