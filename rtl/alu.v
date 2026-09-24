module alu(
    input [3:0] opcode,
    input [7:0] a,
    input [7:0] b,

    output reg [7:0] result
);

always @(*)
begin

    case(opcode)

        4'b0001:
            result = a + b;

        4'b0010:
            result = a - b;

        default:
            result = 0;

    endcase

end

endmodule
