`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2020 06:13:24 PM
// Design Name: 
// Module Name: slowclk_1M
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


module slowclk_1M(
    input clk_in,
    output reg clk_out);
    
    reg [20:0] period_count = 0;
    always @ (posedge clk_in)
        if (period_count!= 100 - 1)
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
