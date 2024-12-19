`include "Full_Subtractor.v"

module Full_Subtr_tb();

reg [7:0]a;
reg [7:0]b;

reg cin;

wire [8:0]s;
wire [7:0]cout;

Full_Subtr u_fs(
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);

integer i;
integer j;

initial begin
    cin=0;
    a=8'b0;
    b=8'b0;
    for(i=0; i<8; i++) begin
        for(j=0; j<8; j++) begin
            b<=b+1;
            #10;
        end
        a<=a+1;
        b<=8'b0;
        #10;
    end
    
end

initial begin
    $monitor("a=%d, b=%d, s=%d", a, b, s);
end

endmodule
