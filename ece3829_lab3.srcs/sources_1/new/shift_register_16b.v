`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2020 06:08:48 PM
// Design Name: 
// Module Name: shift_register_16b
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


module shift_register_16b(
    input clk,
    input in,
    output reg sync,
    output reg [15:0] dac
    );
    
    reg [3:0] counter;
    
always @ (posedge clk) begin // shift left
    dac <= {dac[14:0], in};
    counter <= counter + 1'b1;
              
    if (counter == 16-1) 
        sync <= 1'b1;
    else
        sync <= 1'b0; 
    end    
endmodule
