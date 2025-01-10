`include "SRAM.v"

module SRAM_tb();

reg clk;
reg WE;
reg [7:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

always #1 clk = ~clk; 

SRAM #(
    .WIDTH(32),
    .LENGTH(256)
)u_sram(
    .clk(clk),
    .WE(WE),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

integer i;

task my_task;
    begin
    clk = 0;
    #5; 
    for (i = 0; i < 256; i = i + 1) begin
        addr = i;       
        #5;
        WE = 0;
        data_in=32'b0;         
        data_in[i%32] = 1;  
        data_in[31 - i%32] = 1; 
        $display("Addr: %d | Data Out: %b", addr, data_out); 
        #5;
        WE = 1;       
    end
    // for(i=0; i<32; i=i+1)begin
    //     addr=i;
    //     $display("Addr: %d | Data Out: %b", addr, data_out); 
    // end
    
    $finish; 
    end 
endtask

initial begin
    $dumpfile("SRAM.vcd");
    $dumpvars(0, SRAM_tb);
    my_task();
end

endmodule
