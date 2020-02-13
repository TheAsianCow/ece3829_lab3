`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2020 05:09:43 PM
// Design Name: 
// Module Name: slowclk_4k
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


module slowclk_4k(
    input clk_in,
    output reg clk_out
    );
    reg [4:0] period_count = 0;
    always @ (posedge clk_in)
        if (period_count!= 25 - 1)
            begin
            period_count<= period_count + 1;
            clk_out <= 0; //clk_out gets 0.
            end
        else
            begin
            period_count <= 0;
            clk_out <= 1;
            end
    
endmodule
