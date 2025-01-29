`include "SRAM.v"

module SRAM_tb();

reg clk;
reg WE;
reg CS;
reg [3:0] addr;
reg [7:0] data_in;
wire [7:0] data_out;

always #1 clk = ~clk; 

SRAM #(
    .ADDR(4),
    .WIDTH(8),
    .LENGTH(16)
)u_sram(
    .clk(clk),
    .CS(CS),
    .WE(WE),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

integer i;

task my_task;
    begin
    CS=1;
    clk = 0;
    #5; 
    // for (i = 0; i < 256; i = i + 1) begin
    //     addr = i;       
    //     #5;
    //     WE = 0;
    //     data_in=32'b0;         
    //     data_in[i%32] = 1;  
    //     data_in[31 - i%32] = 1; 
    //     $display("Addr: %d | Data Out: %b", addr, data_out); 
    //     #5;
    //     WE = 1;       
    // end
    for(i=0; i<32; i=i+1)begin
        addr=i;
        $display("Addr: %d | Data Out: %b", addr, data_out); 
    end
    
    $finish; 
    end 
endtask

initial begin
    $dumpfile("SRAM.vcd");
    $dumpvars(0, SRAM_tb);
    my_task();
end

endmodule
