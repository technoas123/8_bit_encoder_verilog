`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench Name: tb_constituent_encoder
// Design Name: constituent_encoder
// Description: Simulation test sequence for testing the constituent encoder states
//////////////////////////////////////////////////////////////////////////////////

module tb_constituent_encoder ();

    // 2. Declaring Signals (Regs for inputs, Wires for outputs)
    reg clk;
    reg rst;
    reg ce;
    reg a_in;
    reg b_in;
    
    wire y_out;
    wire w_out;

    // 3. Module Instantiation (Plugging in the chip under test)
    constituent_encoder uut (
        .clk(clk),
        .rst(rst),
        .ce(ce),
        .a_in(a_in),
        .b_in(b_in),
        .y_out(y_out),
        .w_out(w_out)
    );

    // 4. The Clock Generator (10 ns period / 100 MHz clock rate)
    always #5 clk = ~clk;

    // 5. The Test Sequence
    initial begin
        // Step 1: Initialize all inputs to 0
        clk  = 0;
        rst  = 0;
        ce   = 0;
        a_in = 0;
        b_in = 0;

        // Step 2: Set rst = 1 and wait 20 ns
        rst = 1;
        #20;
        
        // Step 3: Lower reset and enable the module
        rst = 0;
        ce  = 1;

        // Step 4: Send 4 test couples one by one, waiting #10; after each
        // Couple 1
        a_in = 1; b_in = 0;
        #10;

        // Couple 2
        a_in = 0; b_in = 1;
        #10;

        // Couple 3
        a_in = 1; b_in = 1;
        #10;

        // Couple 4
        a_in = 0; b_in = 0;
        #10;

        // Step 5: Disable the module, zero inputs, wait #30;
        ce   = 0;
        a_in = 0;
        b_in = 0;
        #30;

        // Step 6: End simulation
        $finish;
    end

endmodule
