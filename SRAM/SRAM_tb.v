`include "SRAM.v"

module SRAM_tb();

reg clk;
reg res;
reg WE;
reg [7:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

always #1 clk = ~clk; 

SRAM u_sram(
    .clk(clk),
    .res(res),
    .WE(WE),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    $dumpfile("SRAM.vcd");
    $dumpvars(0, SRAM_tb);
    clk = 0;
    res = 1;  
    #5; 
    res = 0;
    for (addr = 0; addr < 33; addr = addr + 1) begin
        #5;
        WE = 0;  
        if (addr <= 15) begin
            data_in = 32'b0;
            data_in[15 - addr] = 1;  
            data_in[15 + addr] = 1;  
        end 
        else begin
            data_in = 32'b0;
            data_in[addr - 15] = 1;  
            data_in[32 - (addr - 15)] = 1;  
        end
        #5;
        WE = 1;  
    end

    $finish;  
end

initial begin
    $monitor("Data Out: %b", data_out);
end

endmodule
