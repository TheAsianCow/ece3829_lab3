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
    input clk_100k,
    input [15:0] in,
    output reg dac
    );
    
    reg [15:0]tmp_reg;
    reg [4:0] counter;
    
    initial tmp_reg = in;
    
always @ (posedge clk) begin // shift left    
//    counter <= counter + 1'b1;
//    if(counter==0) tmp_reg = in;
//    if(counter == 15)
//        sync <= 1'b1;
//    else begin
//        dac <= tmp_reg[15];
//        tmp_reg <= {tmp_reg[14:0],tmp_reg[15]};
//        sync <= 1'b0; 
//        end
        
    if(clk_100k==0)begin
        dac <= tmp_reg[15];
        tmp_reg <= {tmp_reg[14:0],1'b0};
    end
    else tmp_reg <= in;
end    
endmodule
