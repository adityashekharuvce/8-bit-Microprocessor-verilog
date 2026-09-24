module pipeline_cpu(

    input clk,
    input reset,

    input [7:0] input1,
    input [7:0] input2,

    output [7:0] led_output
);

/////////////////////////////////////////////////
// PROGRAM COUNTER
/////////////////////////////////////////////////

wire [7:0] pc_value;

pc PC(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_value)
);

/////////////////////////////////////////////////
// INSTRUCTION MEMORY
/////////////////////////////////////////////////

wire [15:0] instruction;

instr_mem IM(
    .addr(pc_value),
    .instruction(instruction)
);

/////////////////////////////////////////////////
// STAGE 1 → IF/ID PIPELINE REGISTER
/////////////////////////////////////////////////

reg [15:0] if_id_instr;

always @(posedge clk)
begin
    if_id_instr <= instruction;
end

/////////////////////////////////////////////////
// DECODE
/////////////////////////////////////////////////

wire [3:0] opcode;
wire [2:0] rd;
wire [2:0] rs;

assign opcode = if_id_instr[15:12];
assign rd = if_id_instr[11:9];
assign rs = if_id_instr[8:6];

/////////////////////////////////////////////////
// REGISTER FILE
/////////////////////////////////////////////////

wire [7:0] reg_data1;
wire [7:0] reg_data2;

reg write_enable;
reg [7:0] write_back_data;

regfile RF(
    .clk(clk),
    .we(write_enable),

    .rs1(rd),
    .rs2(rs),

    .rd(rd),

    .write_data(write_back_data),

    .read_data1(reg_data1),
    .read_data2(reg_data2)
);

/////////////////////////////////////////////////
// ALU
/////////////////////////////////////////////////

wire [7:0] alu_result;

alu ALU(
    .opcode(opcode),
    .a(reg_data1),
    .b(reg_data2),
    .result(alu_result)
);

/////////////////////////////////////////////////
// WRITE BACK STAGE
/////////////////////////////////////////////////

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        write_enable <= 0;
        write_back_data <= 0;
    end

    else
    begin

        case(opcode)

            //////////////////////////////////////////////////
            // MOVI
            //////////////////////////////////////////////////

            4'b0011:
            begin

                write_enable <= 1;

                if(rd == 3'b001)
                    write_back_data <= input1;

                else if(rd == 3'b010)
                    write_back_data <= input2;

            end

            //////////////////////////////////////////////////
            // ADD
            //////////////////////////////////////////////////

            4'b0001:
            begin
                write_enable <= 1;
                write_back_data <= alu_result;
            end

            //////////////////////////////////////////////////
            // SUB
            //////////////////////////////////////////////////

            4'b0010:
            begin
                write_enable <= 1;
                write_back_data <= alu_result;
            end

            default:
            begin
                write_enable <= 0;
            end

        endcase

    end

end

/////////////////////////////////////////////////
// OUTPUT TO LEDs
/////////////////////////////////////////////////

assign led_output = write_back_data;

endmodule
