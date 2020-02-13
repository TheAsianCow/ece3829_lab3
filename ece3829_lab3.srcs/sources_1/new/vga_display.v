`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2020 03:34:38 PM
// Design Name: 
// Module Name: vga_display
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


module vga_display(
    input [15:0] sw,
    input clk,
    input reset,
    output Hsync,
    output Vsync,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
    );
    
    wire [10:0] x;
    wire [10:0] y;
    wire blank;
    
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
    
    reg [2:0] state = 0; // Current/Blank State
    
    
    //vga stuff
    vga_controller_640_60 display(
        .rst(reset), 
        .pixel_clk(clk),
        .HS(Hsync),
        .VS(Vsync),
        .hcount(y),
        .vcount(x),
        .blank(blank)
    );
endmodule    
