`include "Test.v"
module tb_edge_detector;

reg clk;          // Тестовый сигнал clock
reg reset;        // Тестовый сигнал сброса
wire rise;        // Выходной сигнал для обнаружения фронта

// Инстанцируем модуль edge_detector
edge_detector uut (
    .clk(clk),
    .reset(reset),
    .rise(rise)
);

initial begin
    $dumpfile("Test.vcd");
    $dumpvars(0, uut);
    // Инициализация сигналов
    clk = 0;
    reset = 1;
    #10 reset = 0;

    // Генерация тестовых импульсов clock
    #20 clk = 1;
    #20 clk = 0;
    #20 clk = 1;
    #20 clk = 0;
    #20 clk = 1;
    #20 clk = 0;

    // Устанавливаем reset
    #30 reset = 1;
    #10 reset = 0;
    
    // Повторная генерация тестовых импульсов clock
    #20 clk = 1;
    #20 clk = 0;
    #20 clk = 1;
    #20 clk = 0;
    #20 clk = 1;
    #20 clk = 0;

    // Завершаем тест
    #50 $finish;
end

always #10 clk = ~clk;  // Генерация тактового сигнала

endmodule
