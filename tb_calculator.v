`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 07:07:05 PM
// Design Name: 
// Module Name: tb_calculator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_calculator;
    reg [2:0] a, b;
    reg subtract, calc_button, clk;
    
    // Outputs - calculator gives us these
    wire [2:0] result;
    wire overflow;
    wire [6:0] seg;
    wire [7:0] an;
    
    // Connect our testbench to the calculator
    calculator uut (
        .a(a), 
        .b(b), 
        .subtract(subtract), 
        .calc_button(calc_button), 
        .clk(clk), 
        .result(result), 
        .overflow(overflow), 
        .seg(seg), 
        .an(an)
    );
     always #5 clk = ~clk;
    
    // Run the test
    initial begin
        // Start with everything at 0
        clk = 0;
        a = 0;
        b = 0;
        subtract = 0;
        calc_button = 0;
        
        // Wait a little bit
        #20;
        
        // Set up: 3 + 2 (should overflow)
        a = 3'b011;      // a = 3
        b = 3'b010;      // b = 2
        subtract = 0;    // add mode
        #20;
        
        // Press the button
        calc_button = 1;
        #20;
        
        // Release the button
        calc_button = 0;
        #50;
        
        // End the simulation
        $finish;
    end

    
    
endmodule
