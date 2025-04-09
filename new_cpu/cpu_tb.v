`include "cpu.v"

module cpu_tb;

reg clk;
reg cs;
reg [3:0] addr=4'b0000;
wire [7:0] data_out;

always begin
    #1 clk=~clk;
    addr<=addr+1;
end

sram #(
    .addr(4),
    .width(8),
    .length(16)
)u_sram(
    .clk(clk),
    .cs(cs),
    .address(addr),
    .data_out(data_out)
);

initial begin
    $dumpfile("sram.vcd");
    $dumpvars(0, cpu_tb);
    cs=1;
    for(integer i=0; i<16; i=i+1)begin
        $display("data=%b", u_sram.data[i]);
    #16;
    $finish;
end

initial begin
    $monitor("address=%b, data_out=%b", addr, data_out);
end

endmodule
    