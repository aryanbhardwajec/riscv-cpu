module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result
);

    always @(*) begin
        case(alu_control)
            4'b0000: result = a + b; // ADD
            4'b1000: result = a - b; // SUB
            default: result = 32'b0;
        endcase
    end

endmodule