module decoder(
    input [7:0]register1,
    input [7:0]register2,
    input [7:0]register3,
    input [7:0]register4,
    input [1:0]sel,
    output reg[7:0]data
);

always @(sel) begin
    case(sel)
        2'b00: data = register1;
        2'b01: data = register2;
        2'b10: data = register3;
        2'b11: data = register4;
    endcase
end

endmodule