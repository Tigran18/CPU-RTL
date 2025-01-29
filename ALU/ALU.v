module ALU(
    input [7:0] data1,
    input [7:0] data2,
    input [1:0] opcode,
    output reg [7:0] result
);

always @(*) begin
    case (opcode)
        2'b00: result = data1 + data2;
        2'b01: result = data1 - data2;
        2'b10: result = data1 & data2;
        2'b11: result = data1 | data2;
        default: result = 8'b0; // Safety default case
    endcase
end

endmodule