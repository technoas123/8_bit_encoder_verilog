`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2026 09:42:07 AM
// Design Name: 
// Module Name: constituent_encoder
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


module constituent_encoder(
    input wire clk, 
    input wire rst,
    input wire ce,
    input wire a_in,
    input wire b_in,
    output wire y_out,
    output wire w_out
    );
    
    reg s0, s1, s2;
    wire f;
    
    assign f = a_in ^ s2;
    assign y_out = a_in ^ s1 ^ s2;
    assign w_out = b_in ^ s0 ^ s2;
    
    always @(posedge clk) begin
        if (rst) begin
            s0 <= 0;
            s1 <= 0;
            s2 <= 0;
        end
        else if (ce) begin
                s0 <= b_in ^ f;
                s1 <= s0;
                s2 <= s1;
        end
    end    
endmodule
