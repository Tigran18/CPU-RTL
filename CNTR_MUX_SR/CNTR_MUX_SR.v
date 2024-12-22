//counter description

module cntr(
    input clk,
    input res,
    input en,
    output reg [2:0]ctr
);

always@(posedge clk or posedge res) begin
    if(res) begin
        ctr<=0;
    end
    else begin
        if(en) begin
            ctr<=ctr+1;
        end
    end
end

endmodule

//multiplexor 8-1 description

module mux8_1(
    input [7:0]in,
    input [2:0]sel,
    output out
);

assign out=in[sel];

endmodule

//dff description for shift register

module dff(
    input clk,
    input res,
    input d,
    output reg q
);

always@(posedge clk or posedge res) begin
    if(res) begin
        q<=0;
    end
    else begin
        q<=d;
    end
end

endmodule

//shift register description

module SR(
    input clk,
    input res,
    input en,
    input d,
    output q_out
);

wire [7:0] q;  
genvar i;

generate
    for(i=0; i<8; i=i+1) begin: SR
        if(i == 0) begin
            dff u_dff(
                .clk(clk),
                .res(res),
                .d(en ? d : q[0]), 
                .q(q[i])
            );
        end
        else if(i < 7) begin
            dff u_dff(
                .clk(clk),
                .res(res),
                .d(en ? q[i-1] : q[i]),  
                .q(q[i])
            );
        end
        else begin
            dff u_dff(
                .clk(clk),
                .res(res),
                .d(en ? q[i-1] : q[i]),  
                .q(q_out)
            );
        end
    end
endgenerate

endmodule

//description of the whole scheme

module Scheme(
    input clk,
    input res,
    input en,
    input [7:0]in,
    output out
);

wire d;
wire [2:0]ctr;

cntr u_cntr(
    .clk(clk),
    .res(res),
    .en(en),
    .ctr(ctr)
);

mux8_1 u_mux(
    .in(in),
    .sel(ctr),
    .out(d)
);

SR u_sr(
    .clk(clk),
    .res(res),
    .en(en),
    .d(d),
    .q_out(out)
);

endmodule