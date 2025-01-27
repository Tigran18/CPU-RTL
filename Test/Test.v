module edge_detector(
    input wire clk,      // Входной сигнал clock
    input wire reset,    // Входной сигнал сброса
    output reg rise      // Выходной сигнал для обнаружения фронта
);

reg clk_prev;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        clk_prev <= 0;
        rise <= 0;
    end else begin
        rise <= ~clk_prev & clk; // Обнаружение фронта
        clk_prev <= clk;
    end
end

endmodule
