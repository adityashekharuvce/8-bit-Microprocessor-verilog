module instr_mem(
    input [7:0] addr,
    output reg [15:0] instruction
);

reg [15:0] memory [0:255];

initial
begin

    // MOVI R1,input1
    memory[0] = 16'b0011_001_00000000;

    // MOVI R2,input2
    memory[1] = 16'b0011_010_00000000;

    // ADD R1,R2
    memory[2] = 16'b0001_001_010_00000;

    // SUB R1,R2
    memory[3] = 16'b0010_001_010_00000;

end

always @(*)
begin
    instruction = memory[addr];
end

endmodule