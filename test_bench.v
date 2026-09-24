module testbench;

reg clk;
reg reset;

reg [7:0] sw1;
reg [7:0] sw2;

wire [7:0] led;

top DUT(

    .clk(clk),
    .reset(reset),

    .sw1(sw1),
    .sw2(sw2),

    .led(led)
);

/////////////////////////////////////////////////
// CLOCK
/////////////////////////////////////////////////

initial
begin

    clk = 0;

    forever #5 clk = ~clk;

end

/////////////////////////////////////////////////
// TEST
/////////////////////////////////////////////////

initial
begin

    reset = 1;

    sw1 = 8'd8;
    sw2 = 8'd2;

    #10;

    reset = 0;

    #100;

    $finish;

end

endmodule