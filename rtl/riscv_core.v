module riscv_core(
    input clk,
    input reset
);

    // ---------------- Signals ----------------
    wire [31:0] pc_out, next_pc;
    wire [31:0] instruction;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode;
    wire [2:0] funct3;
    wire funct7;
    wire reg_write, alu_src, mem_write;
    wire [1:0] alu_op;
    wire [3:0] alu_control;
    wire [31:0] read_data1, read_data2;
    wire [31:0] imm_out;
    wire [31:0] alu_input2;
    wire [31:0] alu_result;
    wire [31:0] write_data;

    // ---------------- Field Extraction ----------------
    assign opcode = instruction[6:0];
    assign rd     = instruction[11:7];
    assign funct3 = instruction[14:12];
    assign rs1    = instruction[19:15];
    assign rs2    = instruction[24:20];
    assign funct7 = instruction[30];

    // ---------------- PC ----------------
    pc pc_inst(
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc_out(pc_out)
    );

    assign next_pc = pc_out + 4;

    // ---------------- Instruction Memory ----------------
    instruction_memory imem(
        .address(pc_out),
        .instruction(instruction)
    );

    // ---------------- Register File ----------------
    register_file rf(
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ---------------- ALU ----------------
    assign alu_input2 = read_data2; // only register-register for now
    alu alu_inst(
        .a(read_data1),
        .b(alu_input2),
        .alu_control(4'b0000), // ADD
        .result(alu_result)
    );

    // ---------------- Write-back ----------------
    assign write_data = alu_result;
    assign reg_write = 1;  // always write for now (simplified)

endmodule