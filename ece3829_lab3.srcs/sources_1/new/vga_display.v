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
    
    wire sclk;
    
    localparam start = 0, dir_right = 1, dir_left = 2, dir_up = 3, dir_down = 4, other = 5;
    localparam box_size = 32;
    
    vga_clk clk2(.clk_in(clk), .clk_out(sclk));
    
    wire [10:0] x;
    wire [10:0] y;
    wire blank;
    
    wire up, down, right, left;
    
    debounce du(.clk(sclk), .button_press(up_i), .pulse_out(up));
    debounce dd(.clk(sclk), .button_press(down_i), .pulse_out(down));
    debounce dr(.clk(sclk), .button_press(right_i), .pulse_out(right));
    debounce dl(.clk(sclk), .button_press(left_i), .pulse_out(left));
    
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
    reg [9:0] x_high = 10'd32;
    reg [9:0] y_low = 10'b0;
    reg [9:0] y_high = 10'd32;
    
    reg [2:0] next_state;
    wire [2:0] state;
    
    // which state to go to next
    always @ (reset, sclk, left, right, up, down)
    begin
    if (reset)
        next_state <= start;
    else if (up && y_low > 0)
        next_state <= dir_up;
    else if (down && y_high < 480)
        next_state <= dir_down;
    else if (right && x_high < 480)
        next_state <= dir_right;  
    else if (left && x_low > 0)
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
        x_low = 10'b0;
        x_high = 10'd32;
        y_low = 10'b0;
        y_high = 10'd32;
        end
    dir_up:
        begin
        y_low <= y_low - box_size;
        y_high <= y_high - box_size;
        end
    dir_down:
        begin
        y_low <= y_low + box_size;
        y_high <= y_high + box_size;
        end
    dir_right:
        begin
        x_low <= x_low + box_size;
        x_high <= x_high + box_size;
        end
    dir_left:
        begin
        x_low <= x_low - box_size;
        x_high <= x_high - box_size;
        end
    default:
        begin
        x_high <= x_high;
        x_low <= x_low;
        y_high <= y_high;
        y_low <= y_low;
        end      
    endcase
    end
    
    // logic for drawing out box
    always @ (clk, y_low, y_high, x_low, x_high)
    begin
    if (blank) 
        begin
        vgaRed <= 4'b0;
        vgaBlue <= 4'b0;
        vgaGreen <= 4'b0;
        end
    else
        begin
           if (x >= x_low && x_high > x && y >= y_low && y_high > y)
	       begin
	       vgaRed <= 4'b1111;
	       vgaGreen <= 4'b1111;
	       vgaBlue <= 4'b1111;
	       end
	   end
	end
endmodule    
