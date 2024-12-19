module Subtr(
    input a,
    input b,
    input cin,
    output s,
    output cout
);

    assign s = a ^ b ^ cin;
    assign cout = (~(a ^ b) & cin) | (~a & b);

endmodule

module Full_Subtr(
    input [7:0] a,       
    input [7:0] b,       
    input cin,           
    output [8:0] s,      
    output [7:0] cout    
);

    genvar i;

    generate 
        for (i = 0; i < 8; i = i + 1) begin: bit_sub
            if (i == 0) begin
                Subtr u_subtr (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .s(s[i]),
                    .cout(cout[i])
                );
            end else begin
                Subtr u_subtr (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cout[i-1]),
                    .s(s[i]),
                    .cout(cout[i])
                );
            end
        end
    endgenerate

    assign s[8] = cout[7];

endmodule
