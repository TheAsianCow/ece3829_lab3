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
    output Hsync,
    output Vsync,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
    );
    
    wire vga_clk;
    wire clk_1k;
    
    localparam start = 0, dir_right = 1, dir_left = 2, dir_up = 3, dir_down = 4, other = 5;
    localparam box_size = 5'b11111;
    
    vga_clk clk2(.clk_in(clk), .clk_out(vga_clk));
    slowclk_1M clk3(.clk_in(clk), .clk_out(clk_1k));
    
    wire [10:0] x,y;
    wire blank;
    
    wire up, down, right, left;
    reg pressed = 0;
    
   debounce du(.clk(clk_1k), .in(up_i),      .out(up),       .reset(reset));
   debounce dd(.clk(clk_1k), .in(down_i),    .out(down),     .reset(reset));
   debounce dr(.clk(clk_1k), .in(right_i),   .out(right),    .reset(reset));
   debounce dl(.clk(clk_1k), .in(left_i),    .out(left),     .reset(reset));

    //vga stuff
    vga_controller_640_60 display(
        .rst(reset), 
        .pixel_clk(vga_clk),
        .HS(Hsync),
        .VS(Vsync),
        .hcount(y),
        .vcount(x),
        .blank(blank)
    );
    
    // bounds for the box
    reg [9:0] x_pos = 10'b0;
    reg [9:0] y_pos = 10'b0;
    
    always @ (posedge clk_1k, posedge reset)
    if (reset) 
        begin
        x_pos <= 10'b0000000000;
        y_pos <= 10'b0000000000;
        pressed <= 0;
        end
    else if (up_i && x_pos > 0 && !pressed)begin
        x_pos <= x_pos - 10'd32;
        pressed <= 1;
    end
    else if (down_i && (x_pos < 479-32) && !pressed)begin
        x_pos <= x_pos + 10'd32;
        pressed <= 1;
    end
    else if (right_i && (y_pos < 639-32) && !pressed)begin
        y_pos <= y_pos + 10'd32;
        pressed <= 1;
    end
    else if (left_i && y_pos > 0 && !pressed)begin
        y_pos <= y_pos - 10'd32;
        pressed <= 1;
    end
    else if(!left_i && !right_i && !up_i && !down_i) pressed <= 0;
    else
        begin
        x_pos <= x_pos;
        y_pos <= y_pos;
        pressed <= pressed;
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
           if ((x >= x_pos) && ((x_pos + 10'd32) >= x) && (y >= y_pos) && ((y_pos + 10'd32) >= y))
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