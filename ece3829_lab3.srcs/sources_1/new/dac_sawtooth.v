`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/13/2020 02:33:48 PM
// Design Name: 
// Module Name: dac_sawtooth
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


module dac_sawtooth(
    input clk,
    input sync, 
    output[7:0] sawtooth_wave
    );

    localparam step = 1'b0;
    reg state = 1'b0;
    reg[7:0] temp_wave = 8'b0; // Value for the waveform
    reg [4:0] counter = 5'b0; // Counter to get to 25 steps
    
    always @ (state, clk) // Sensitivity List

    case (state) // Will change based on state
    step: // State to generate wave steps
        begin
        if  (!sync) // sync has to be active low
            begin
            if (counter == 8'd24) // if counter reaches 25 steps, the state goes to default and the counter resets
                begin
                state <= 1'b1;
                counter <= 0'b0;
                end
            else // increment by 10 everytime
                begin
                counter <= counter + 1'b1;
                temp_wave <= temp_wave + 8'd10;
                end
            end
        else // remains the same (latch prevention)
            temp_wave <= temp_wave;
        end
    default: // zero state
        begin      
        temp_wave <= 8'b0;
        state <= 1'b0;
        end
    endcase
    
    assign sawtooth = temp_wave;

endmodule
