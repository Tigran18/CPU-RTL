`include "CPU.v"

module CPU_tb;

reg clk;
reg cs;
reg we;
reg reset;
wire [7:0] reg1;
wire [7:0] reg2;
wire [7:0] reg3;
wire [7:0] reg4;

always #1 clk = ~clk;

CPU u_CPU(
    .clk(clk),
    .cs(cs),
    .we(we),
    .reset(reset),
    .reg1(reg1),
    .reg2(reg2),
    .reg3(reg3),
    .reg4(reg4)
);

initial begin
    $dumpfile("CPU.vcd");
    $dumpvars(0, CPU_tb);
    clk=0;
    #10;
    reset=0;
    cs=1;
    we=0;
    //Load 0x02 into R1.
    //Load 0x04 into R2.
    #4;
    cs=0;
    //Add R1 and R2, store in R1.
    #2;
    cs=1;
    //Load 0x05 into R1.
    //Load 0x0E into R2.
    #4;
    cs=0;
    //Subtract R2 from R1, store in R1.
    #2;
    we=1;
    //Store R1 to memory address 0x06.
    cs=1;
    //Load 0x03 into R2.
    #4;
    cs=0;
    //Add R2 and R2, store in R1.
    #2;
    cs=1;
    //Store R1 to memory address 0x04.
    we=1;
    #4;
    we=0;
    //Load 0x0A into R3.
    //Load 0x0B into R4.
    #4;
    cs=0;
    //Subtract R3 from R4, store in R4.
    #2;
    cs=1;
    we=1;
    //Store R4 to memory address 0x0B.
    #2;
    we=0;
    //Load 0x0F into R3.
    #2;
    we=1;
    //Store R3 to memory address 0x0F.
    $finish;
end

initial begin
    $monitor("Time=%0t | Reg1=%b | Reg2=%b | Reg3=%b | Reg4=%b | PC=%b, WE=%b", $time, reg1, reg2, reg3, reg4, u_CPU.programm_counter, we);
end

endmodule