`include "xor.v"

module tb;

reg a;
reg b;
wire out;

xor_gate u_xor(  // Use the updated module name
    .a(a),
    .b(b),
    .out(out)
);

initial begin
    $dumpfile("u_xor.vcd");  
    $dumpvars(0, u_xor);      

    #5;
    a = 0;
    b = 0;
    #10;
    b = 1;
    #5;
    a = 1;
    b = 0;
    #10;
    b = 1;  
    #10;
    $finish;
end

initial begin
    $monitor("a=%b, b=%b, out=%b", a, b, out);
end

endmodule
