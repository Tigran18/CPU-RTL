`include "FULL_ADDER.v"

module FA_tb();

reg cin = 1'b0;
reg [7:0] a = 8'b00000000, b = 8'b00000000;
wire [8:0] s;
wire cout;

bit_FA8 u_fa (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);

integer i, j;

initial begin
    $dumpfile("FULL_ADDER.vcd");
    $dumpvars(0, u_fa);
    for (i = 0; i < 8; i = i + 1) begin  
        for(j=0; j<8; j=j+1) begin
            b=b+1;
            #10;
        end
        a=a+1;
        #10;
        b=0;
    end
end

initial begin
    $monitor("%d + %d = %d\n", a, b, s[8:0]);
end
    

endmodule
