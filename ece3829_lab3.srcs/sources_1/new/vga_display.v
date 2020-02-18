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
    
    wire sclk;
    wire clk_1k;
    
    localparam start = 0, dir_right = 1, dir_left = 2, dir_up = 3, dir_down = 4, other = 5;
    localparam box_size = 32;
    
    vga_clk clk2(.clk_in(clk), .clk_out(sclk));
    slowclk_1M clk3(.clk_in(clk), .clk_out(clk_1k));
    
    wire [10:0] x,y;
    wire blank;
    
    wire up, down, right, left;
    
   debounce du(.clk(sclk), .in(up_i),      .out(up),       .reset(reset), .clk_en(clk_1k));
   debounce dd(.clk(sclk), .in(down_i),    .out(down),     .reset(reset), .clk_en(clk_1k));
   debounce dr(.clk(sclk), .in(right_i),   .out(right),    .reset(reset), .clk_en(clk_1k));
   debounce dl(.clk(sclk), .in(left_i),    .out(left),     .reset(reset), .clk_en(clk_1k));

    //vga stuff
    vga_controller_640_60 display(
        .rst(reset), 
        .pixel_clk(sclk),
        .HS(Hsync),
        .VS(Vsync),
        .hcount(y),
        .vcount(x),
        .blank(blank)
    );
    
    // bounds for the box
    reg [9:0] x_low = 10'b0;
    reg [9:0] y_low = 10'b0;
    
    reg [2:0] next_state;
    wire [2:0] state;
    
    // which state to go to next
    always @ (reset, sclk, left, right, up, down)
    begin
    if (reset)
        next_state <= start;
    else if (up && x_low > 0)
        next_state <= dir_up;
    else if (down && x_low + box_size < 480-1)
        next_state <= dir_down;
    else if (right && y_low + box_size < 640-1)
        next_state <= dir_right;  
    else if (left && y_low > 0)
        next_state <= dir_left;
    else
        next_state <= other; 
    end
     
     assign state = next_state;
    
    // direction logic
    always @ (state)
    begin
    case (state)
    start:
        begin
        x_low <= 10'b0;
        y_low <= 10'b0;
        end
    dir_down:
        x_low <= x_low + box_size;
    dir_up:
        x_low <= x_low - box_size;
    dir_left:
        y_low <= y_low + box_size;
    dir_right:
        y_low <= y_low - box_size;
    default:
        begin
        x_low <= x_low;
        y_low <= y_low;
        end      
    endcase
    end
    
    // logic for drawing out box
    always @ (clk, y_low, x_low)
    begin
    if (blank) 
        begin
        vgaRed <= 4'b0;
        vgaBlue <= 4'b0;
        vgaGreen <= 4'b0;
        end
    else
        begin
           if ((x >= x_low) && ((x_low + box_size) >= x) && (y >= y_low) && ((y_low + box_size) >= y))
	           begin
	           vgaRed <= 4'b1111;
	           vgaGreen <= 4'b1111;
	           vgaBlue <= 4'b1111;
	           end
	       else
	          begin
              vgaRed <= 4'b0;
              vgaBlue <= 4'b0;
              vgaGreen <= 4'b0;
              end     
	   end
	end
endmodule   