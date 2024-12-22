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

integer i;

task my_task;

    begin
    clk = 0;
    res = 1;  
    #5; 
    res = 0;
    for (i = 0; i < 256; i = i + 1) begin
        addr=i;
        #5;
        WE = 0;  
        if (addr%32 <= 15) begin
            data_in = 32'b0;
            data_in[15 - addr%32] = 1;  
            data_in[15 + addr%32] = 1;  
        end 
        else begin
            data_in = 32'b0;
            data_in[addr%32 - 15] = 1;  
            data_in[32 - (addr%32 - 15)] = 1;  
        end
        #5;
        WE = 1;  
    end
    $finish; 
    end 
endtask

initial begin
    $dumpfile("SRAM.vcd");
    $dumpvars(0, SRAM_tb);
    my_task();
end

initial begin
    $monitor("Addr: %d | Data In: %b | Data Out: %b", addr, data_in, data_out);
end

endmodule
