`timescale 1ns/1ps

module riscv_tb;

    // ---------- Clock and reset ----------
    reg clk;
    reg reset;

    // ---------- Instantiate CPU ----------
    riscv_core uut (
        .clk(clk),
        .reset(reset)
    );

    // ---------- Clock generation ----------
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    

    // ---------- Testbench ----------
    initial begin
        // Dump waveform
        $dumpfile("dump.vcd");
        $dumpvars(0, riscv_tb);

        // Reset CPU
        reset = 1;
        #10;
        reset = 0;

        $display("Simulation started");

        // Run for 50 clock cycles
        repeat (50) @(posedge clk);

        $display("Simulation finished");
        $finish;
    end

endmodule