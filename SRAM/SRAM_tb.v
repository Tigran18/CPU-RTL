`include "SRAM.v"

module SRAM_tb();

reg clk;
reg res;
reg WE;
reg [7:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

always #2 clk = ~clk; 

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
    addr = 0; 
    data_in = 0; 
    WE = 0;
    
    #5; 
    res = 0;

    for (addr = 0; addr < 32; addr = addr + 1) begin
        #5;  
        if (addr <= 15) begin
            data_in = 32'b0;
            data_in[15 - addr] = 1;  
            data_in[15 + addr] = 1;  
        end else begin
            data_in = 32'b0;
            data_in[addr - 15] = 1;  
            data_in[31 - (addr - 15)] = 1;  
        end
        
        #5;
        WE = 1;
        #5;
        WE = 0;  
    end

    $finish;  
end

initial begin
    $monitor("Time: %0t | Addr: %0d | Data In: %b | Data Out: %b", $time, addr, data_in, data_out);
end

endmodule
