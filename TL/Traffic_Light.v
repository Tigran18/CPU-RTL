module TL(
    input clk,
    input res,
    output out
);

    reg [8:0] inp1, inp2, inp3; 
    reg GTY, YTR, RTG;

    assign out = RTG; 

    initial begin
        GTY = 1;   
        YTR = 0;
        RTG = 0;
        inp1 = 0;
        inp2 = 0;
        inp3 = 0;
    end

    always @(posedge clk) begin
        if (res) begin
            GTY <= 1;
            YTR <= 0;
            RTG <= 0;
            inp1 <= 0;
            inp2 <= 0;
            inp3 <= 0;
        end 
        else begin
            if (GTY) begin
                if (inp1 == 8'b11111111) begin
                    GTY <= 0;
                    YTR <= 1;
                    RTG <= 0;
                    inp1 <= 0;
                end else begin
                    inp1 <= inp1 + 1;
                end
            end
            if (YTR) begin
                if (inp2 == 8'b11111111) begin
                    GTY <= 0;
                    YTR <= 0;
                    RTG <= 1;
                    inp2 <= 0;
                end else begin
                    inp2 <= inp2 + 1;
                end
            end
            if (RTG) begin
                if (inp3 == 8'b11111111) begin
                    GTY <= 1;
                    YTR <= 0;
                    RTG <= 0;
                    inp3 <= 0;
                end else begin
                    inp3 <= inp3 + 1;
                end
            end
        end
    end

endmodule
