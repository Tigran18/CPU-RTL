`include "../SRAM/SRAM.v"
`include "../ALU/ALU.v"
`include "../Decoder/Decoder.v"

module CPU(
    input clk,
    input cs,
    input we,
    input reset,
    output reg [7:0] reg1,
    output reg [7:0] reg2,
    output reg [7:0] reg3,
    output reg [7:0] reg4,
    output [7:0] reg5
);

reg [3:0] program_counter;
reg [7:0] data_in;
wire [7:0] result;
wire [7:0] instruction;
wire [7:0] data1;
wire [7:0] data2;

assign reg5 = result;

always @(posedge clk) begin
    if (reset) begin
        reg1 <= 8'b0;
        reg2 <= 8'b0;
        reg3 <= 8'b0;
        reg4 <= 8'b0;
        program_counter <= 4'b0;
    end else begin
        program_counter <= program_counter + 1;
        if (~we) begin
            if (instruction[7:6] == 2'b00) begin
                case (instruction[5:4])
                    2'b00: reg1 <= instruction[7:0]; // Verify this indexing
                    2'b01: reg2 <= instruction[7:0]; // Verify this indexing
                    2'b10: reg3 <= instruction[7:0]; // Verify this indexing
                    2'b11: reg4 <= instruction[7:0]; // Verify this indexing
                endcase
            end
        end else begin
            data_in <= reg5;
        end
    end
end

decoder u1_decoder(
    .register1(reg1),
    .register2(reg2),
    .register3(reg3),
    .register4(reg4),
    .sel(instruction[3:2]),
    .data(data1)
);

decoder u2_decoder(
    .register1(reg1),
    .register2(reg2),
    .register3(reg3),
    .register4(reg4),
    .sel(instruction[1:0]),
    .data(data2)
);

SRAM #(
    .ADDR(4),
    .WIDTH(8),
    .LENGTH(16)
) u_SRAM(
    .clk(clk),
    .CS(cs),
    .WE(we),
    .addr(program_counter),
    .data_in(data_in),
    .data_out(instruction)
);

ALU u_ALU(
    .data1(data1),
    .data2(data2),
    .opcode(instruction[5:4]),
    .result(result)
);

endmodule
