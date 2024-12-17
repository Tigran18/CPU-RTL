`include "clk.v"

module tb();

reg clk=1'b0;

always begin
    #1 clk=~clk;
end

wire new_clk;


clk u_clk(
    .clk(clk),
    .new_clk(new_clk)
);

initial begin
    $dumpfile("clk.vcd");
    $dumpvars(0, u_clk);
    $monitor("%b and %b", clk, new_clk);
    #10;
    $finish;
end

endmodule