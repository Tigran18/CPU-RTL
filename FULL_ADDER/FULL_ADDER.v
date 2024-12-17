module FA(
    input a,
    input b,
    input cin,
    output s,
    output cout
);

assign s = (a ^ b) ^ cin;
assign cout = ((a ^ b) & cin) | (a & b);

endmodule

module bit_FA8(
    input [7:0] a,      
    input [7:0] b,      
    input cin,          
    output [8:0] s,     
    output cout         
);

genvar i;
wire [7:0] carry;  

generate
    for (i = 0; i < 8; i = i + 1) begin: adder
        if (i == 0) begin
            FA u_fa (
                .a(a[i]),
                .b(b[i]),
                .cin(cin),
                .s(s[i]),
                .cout(carry[i])
            );
        end 
        else begin
            FA u_fa (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i-1]),
                .s(s[i]),
                .cout(carry[i])
            );
        end
    end
endgenerate

assign s[8] = carry[7];

endmodule
