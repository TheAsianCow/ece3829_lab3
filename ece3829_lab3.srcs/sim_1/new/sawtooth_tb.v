`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2020 12:41:01 PM
// Design Name: 
// Module Name: sawtooth_tb
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


module sawtooth_tb;

    // Inputs
    reg clk;
    reg clk_100k;
    reg reset;
    
    // Outputs 
    wire [7:0] sawtooth;
    
    dac_sawtooth uut (
        .clk(clk),
        .clk_100k(clk_100k),
        .reset(reset),
        .sawtooth_wave(sawtooth)
    );
    
    always
    begin
    clk_100k = 0;
    #1;
    clk_100k = 1;
    #1;
    end
    
    initial begin
    reset = 1;
    #1;
    reset = 0;
    #20;
    reset = 1;
    #1;
    reset = 0;
    #20;
    end
    
    
endmodule
