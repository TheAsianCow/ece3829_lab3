`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2020 02:30:42 PM
// Design Name: 
// Module Name: lab3_top
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


module lab3_top(
    input clk,
    input reset,
    input [7:0] sw,
    output dout,
    output sclk,
    output sync,
    output led,
    output [6:0] seg,
    output [3:0] an,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );
    
    clk_wiz_0 instance_name(
    // Clock out ports
    .clk_10M(sclk),     // output clk_10M
    // Status and control signals
    .reset(reset), // input reset
    .locked(led),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1
    
    wire clk_100k;
    slowclk_100k clk0(.clk_in(clk),.clk_out(clk_100k));
    
    shift_register_16b dac(.clk(sclk),.in({8'b00000000,sw}),.sync(sync),.dac(dout));
    
endmodule
