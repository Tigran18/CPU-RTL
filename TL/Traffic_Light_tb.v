`include "Traffic_Light.v"

module TL_tb();

    reg clk = 0;  
    reg res=1;
    wire out;     

    TL u_tl (
        .clk(clk),
        .res(res),
        .out(out)
    );

    always #1 clk = ~clk;

    initial 
        $display("Time=%0t | GTY=%b, YTR=%b, RTG=%b, Out=%b, res=%b", $time, u_tl.GTY, u_tl.YTR, u_tl.RTG, out, res);

    initial begin
        $dumpfile("Traffic_Light.vcd"); 
        $dumpvars(0, u_tl);
        res=0;
        $monitor("Time=%0t | GTY=%b, YTR=%b, RTG=%b, Out=%b, res=%b", $time, u_tl.GTY, u_tl.YTR, u_tl.RTG, out, res);
    end

    always@(posedge u_tl.RTG) begin
        $finish;
    end
endmodule
