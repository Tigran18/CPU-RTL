`include "CNTR_MUX_SR.v"

module tb();

reg clk;
reg res;
reg en;
reg [7:0]in;
wire out;

always #5 clk=~clk;

Scheme u_scheme(
    .clk(clk),
    .res(res),
    .en(en),
    .in(in),
    .out(out)
);

integer i;

initial begin
    $dumpfile("CNTR_MUX_SR.vcd");
    $dumpvars(0, u_scheme);
    res=1;
    clk=0;
    en=0;
    #15;
    res=0;
    en=1;
    for(i=0; i<256; i=i+1)begin
        in=i;
        #10;
    end
    $finish;
end

initial begin
    $monitor("Input = %b | Out = %b", in, out);
end

endmodule