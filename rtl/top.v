module top(

    input clk,
    input reset,

    input [7:0] sw1,
    input [7:0] sw2,

    output [7:0] led
);

pipeline_cpu CPU(

    .clk(clk),
    .reset(reset),

    .input1(sw1),
    .input2(sw2),

    .led_output(led)
);

endmodule
