module ALU(
    input [7:0] data1,
    input [7:0] data2,
    input cs,
    input [1:0] opcode,
    output [7:0] result
);

    reg [7:0] result;

    always @(*) begin
        if(~cs) begin
            case(opcode)
                2'b00: result = data1 + data2;
                2'b01: result = data1 - data2;
                2'b10: result = data1 & data2;
                2'b11: result = data1 | data2;
            endcase
        end
    end

endmodule