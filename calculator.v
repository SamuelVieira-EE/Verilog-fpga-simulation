`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2025 07:06:45 PM
// Design Name: 
// Module Name: calculator
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


module calculator(
    input [2:0]a,
    input [2:0]b,
    input subtract,
    input calc_button,
    input clk,
    output reg [2:0]result,
    output reg overflow, //added for real hardware like LED that with turn on in case of overflow 
    output reg [6:0]seg, //7-segment display controls which parts to light up
    output reg [7:0]an //for all the 8 displays
    );
    


    reg [2:0] temp; //temporary value
    
     always @(posedge clk) begin
        if (calc_button) begin          
            if (subtract) begin          
                temp = a + (~b) + 3'b001;  // same as adding 1 instead of 3'b001
                result <= temp;         
                overflow <= (a[2] == ~b[2]) && (temp[2] != a[2]); //in 3-bit 2s complementray you can only represent -4 to +3 overflow makes sure you cant go pass -4
            end else begin
                temp = a + b;
                result <= temp;
                overflow <= (a[2] == b[2]) && (temp[2] != a[2]); //overflow makes sure you cant go pass +3
            end
        end
    end
    
    
    
    function [6:0] decode_7seg;
        input [3:0] digit;
        begin
            case(digit) //dont have fgpa board so im doing gfedcba example 
                4'd0: decode_7seg = 7'b1000000;  // 0
                4'd1: decode_7seg = 7'b1111001;  // 1
                4'd2: decode_7seg = 7'b0100100;  // 2
                4'd3: decode_7seg = 7'b0110000;  // 3
                4'd4: decode_7seg = 7'b0011001;  // 4
                4'd10: decode_7seg = 7'b0111111; // minus sign (-)
                default: decode_7seg = 7'b1111111; // blank (all off)
            endcase
        end
    endfunction
    
    
    
    // Multiplexing makes the timing and cycles to all 8 displays so that it works  
    reg [19:0] refresh_counter; //clcok refresh time helps to calculate the time between switching 
    reg [2:0] display_select; // to control which display is on cycles between 0-7 to choose which should be on
    
    always @(posedge clk) begin
        if (refresh_counter == 100000) begin  //change number to change speed of switching (100 MHz Clock right now)
            refresh_counter <= 0;              
            display_select <= display_select + 1;
        end else begin
            refresh_counter <= refresh_counter + 1;
        end
    end
    
    // controls which display is on anytime
    always @(*) begin
        an = 8'b11111111;  // all displays are off
        an[display_select] = 0;  //show selected display
    end
    
    
    
    
    
    // show correct digit on the given display
    always @(*) begin
    // Default: show blank
    seg = 7'b1111111;
    
    // display 0 the sign of A
    if (display_select == 0) begin
        if (a[2] == 1)
            seg = decode_7seg(10);  // negative so show -
        else
            seg = decode_7seg(15);  // positive show nothing
    end
    
    // display 1 the digit of A
    if (display_select == 1) begin
        if (a[2] == 1)
            seg = decode_7seg((~a) + 1);  // its negative so convert to positive
        else
            seg = decode_7seg(a);          
    end
    
    // display 2 sign of B
    if (display_select == 2) begin
        if (b[2] == 1)
            seg = decode_7seg(10);  
        else
            seg = decode_7seg(15);  
    end
    
    // display 3 digit of B
    if (display_select == 3) begin
        if (b[2] == 1)
            seg = decode_7seg((~b) + 1);
        else
            seg = decode_7seg(b);
    end
    
    // display 4 sign of result
    if (display_select == 4) begin
        if (result[2] == 1)
            seg = decode_7seg(10);  
        else
            seg = decode_7seg(15);  
    end
    
    // display 5 digit of result
    if (display_select == 5) begin
        if (result[2] == 1)
            seg = decode_7seg((~result) + 1);
        else
            seg = decode_7seg(result);
    end
end
  
    
endmodule
