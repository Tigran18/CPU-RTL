module ALU(
    input [7:0] data1,
    input [7:0] data2,
    input [2:0] opcode,
    output [7:0] result
);

    reg [7:0] result;

    always @(*) begin
        case(opcode)
            3'b000: result = data1 + data2;
            3'b001: result = data1 - data2;
            3'b010: result = data1 & data2;
            3'b011: result = data1 | data2;
            3'b100: result = data1 ^ data2;
            3'b101: result = data1 << 1;
            3'b110: result = data1 >> 1;
            3'b111: result = data1;
        endcase
    end

endmodule