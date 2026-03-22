`timescale 1ns/1ps

module instruction_memory(
    input  [31:0] address,
    output reg [31:0] instruction
);

    reg [31:0] mem [0:255];  // 256 words

    // Combinational read
    always @(*) begin
        instruction = mem[address[9:2]]; // word-aligned
    end

    // Load instructions from hex file
    initial begin
        $readmemh("instr.mem", mem);
    end

endmodule