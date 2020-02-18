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
    input up_i,
    input down_i,
    input left_i,
    input right_i,
    input clk,
    input reset,
    output led,
    output Hsync,
    output Vsync,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
    );
    
    wire sclk_1;
    wire clk_1M;
    
    localparam start = 0, dir_right = 1, dir_left = 2, dir_up = 3, dir_down = 4, other = 5;
    localparam box_size = 32;
    
    vga_clk clk2(.clk_in(clk), .clk_out(sclk_1));
    slowclk_1M clk3(.clk_in(clk), .clk_out(clk_1M));
    
    wire [10:0] x;
    wire [10:0] y;
    wire blank;
    
    wire up, down, right, left;
    
   debounce du(.clk(clk_1M), .in(up_i),      .out(up),       .reset(reset));
   debounce dd(.clk(clk_1M), .in(down_i),    .out(down),     .reset(reset));
   debounce dr(.clk(clk_1M), .in(right_i),   .out(right),    .reset(reset));
   debounce dl(.clk(clk_1M), .in(left_i),    .out(left),     .reset(reset));

    //vga stuff
    vga_controller_640_60 display(
        .rst(reset), 
        .pixel_clk(sclk_1),
        .HS(Hsync),
        .VS(Vsync),
        .hcount(y),
        .vcount(x),
        .blank(blank)
    );
    
    // bounds for the box
    reg [9:0] x_pos = 10'b0;
    reg [9:0] y_pos = 10'b0;
    
    always @ (reset, up, down, left, right)
    if (reset) 
        begin
        x_pos = 10'b0;
        y_pos = 10'b0;
        end
    else if (up && x_pos > 0)
        x_pos = x_pos - box_size;
    else if (down && x_pos + box_size < 480-1)
        x_pos = x_pos + box_size;
    else if (left && y_pos + box_size < 640-1)
        y_pos = y_pos + box_size;
    else if (right && y_pos > 0)
        y_pos = y_pos - box_size;
    else
        begin
        x_pos = x_pos;
        y_pos = y_pos;
        end
    
    // logic for drawing out box
    always @ (blank, y_pos, x_pos, x, y)
    begin
    if (blank) 
        begin
        vgaRed = 4'b0;
        vgaBlue = 4'b0;
        vgaGreen = 4'b0;
        end
    else
        begin
           if ((x >= x_pos) && ((x_pos + box_size) >= x) && (y >= y_pos) && ((y_pos + box_size) >= y))
	           begin
	           vgaRed = 4'b1111;
	           vgaGreen = 4'b1111;
	           vgaBlue = 4'b1111;
	           end
	       else
	          begin
              vgaRed = 4'b0;
              vgaBlue = 4'b0;
              vgaGreen = 4'b0;
              end     
	   end
	end   
endmodule