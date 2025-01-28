`include "CPU.v"

module CPU_tb;

reg clk;
reg cs;
reg reset;
wire [7:0] reg1;
wire [7:0] reg2;
wire [7:0] reg3;
wire [7:0] reg4;

always #1 clk = ~clk;

CPU u_CPU(
    .clk(clk),
    .cs(cs),
    .reset(reset),
    .reg1(reg1),
    .reg2(reg2),
    .reg3(reg3),
    .reg4(reg4)
);

initial begin
    clk=0;
    reset=1;
    #10;
    reset=0;
    cs=1;
    #4;
    cs=0;
    #2;
    cs=1;
    #4;
    cs=0;
    #4;
    cs=1;
    #2;
    cs=0;
    
    $dumpfile("CPU.vcd");
    $dumpvars(0, u_CPU);
    #32;
    $finish;
end

initial begin
    $monitor("Time=%0t | Reg1=%b | Reg2=%b | Reg3=%b | Reg4=%b", $time, reg1, reg2, reg3, reg4);
end

endmodule