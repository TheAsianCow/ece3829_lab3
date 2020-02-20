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
    input up_i,
    input down_i,
    input left_i,
    input right_i,
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
    wire [7:0] sawtooth;
    slowclk_100k clk0(.clk_in(sclk),.clk_out(clk_100k));
    assign sync = clk_100k;
    
//    shift_register_16b dac(.clk(sclk),.clk_100k(clk_100k),.in({8'b00000000,sw}),.dac(dout));
    dac_sawtooth waveform(.clk(sclk),.clk_100k(clk_100k),.reset(reset),.sawtooth_wave(sawtooth));
    shift_register_16b dac(.clk(sclk),.clk_100k(clk_100k),.in({8'b00000000,sawtooth}),.dac(dout));
    
    wire [15:0] coords;
    
    vga_display disp(.up_i(up_i),.down_i(down_i),.left_i(left_i),.right_i(right_i),.clk(clk),.reset(reset),.Hsync(Hsync),.Vsync(Vsync),.vgaRed(vgaRed),.vgaGreen(vgaGreen),.vgaBlue(vgaBlue));
    
    wire slowclk;
    slowclock seven_seg_clk(clk, slowclk);
    
    seven_seg seven_seg_disp(coords,slowclk,seg,an);
    
endmodule
