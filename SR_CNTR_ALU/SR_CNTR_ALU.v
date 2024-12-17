module dff(
    input clk, 
    input res,
    input d,
    output reg q
);

initial begin
    q = 0;
end

always@(posedge clk or posedge res) begin
    if(res)
        q <= 1'b0;
    else
        q <= d; 
end

endmodule

module SR(
    input clk, 
    input res, 
    input d, 
    output [7:0] q
);

genvar i;
generate 
    for(i = 0; i < 8; i = i + 1) begin
        if(i == 0) begin
            dff u_dff(
                .clk(clk),
                .res(res),
                .d(d),
                .q(q[i])
            );
        end else begin
            dff u_dff(
                .clk(clk),
                .res(res),
                .d(q[i-1]),
                .q(q[i])
            );
        end
    end
endgenerate

endmodule

module counter(
    input clk,
    input res,
    input EN,
    input inc,
    input [7:0]in,
    output reg [7:0]out
); 

always@(posedge clk or posedge res) begin
    if(res)begin
        out<=8'b00000000;
    end
    else begin 
        if(EN) begin
            if(inc) begin
                out <= in + 1;
            end
            else begin
                out <= in - 1;
            end
        end
    end
end

endmodule

module adder(
    input a,
    input b,
    input cin,
    output s,
    output cout
);

assign s = (a ^ b) ^ cin;
assign cout = ((a ^ b) & cin) | (a & b);

endmodule

module full_adder(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [8:0] s,
    output [7:0] cout
);

genvar i;
wire [7:0] carry;

generate
    for(i = 0; i < 8; i = i + 1) begin: full_adder_gen
        if(i == 0) begin
            adder u_adder(
                .a(a[i]),
                .b(b[i]),
                .cin(cin),
                .s(s[i]),
                .cout(carry[i])
            );
        end else begin
            adder u_adder(
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

module SCHEME(
    input clk,
    input res, 
    input d,
    input inc,
    input EN,
    output [7:0] out
);

wire [15:0] q;  
wire [7:0] out1, out2;
reg cin = 0;  
wire [7:0] carry;
wire [8:0] s;

SR u_sr1(
    .clk(clk),
    .res(res),
    .d(d),
    .q(q[15:8]) 
);

SR u_sr2(
    .clk(clk),
    .res(res),
    .d(d),
    .q(q[7:0])  
);

counter u_cntr1(
    .clk(clk),
    .res(res),
    .EN(EN),
    .inc(inc),
    .in(q[15:8]),
    .out(out1)  
);

counter u_cntr2(
    .clk(clk),
    .res(res),
    .EN(EN),
    .inc(inc),
    .in(q[7:0]),
    .out(out2)  
);

full_adder u_fa(
    .a(out1),
    .b(out2),
    .cin(cin), 
    .s(s),
    .cout(carry)
);

assign out = s[7:0];

endmodule
