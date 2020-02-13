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
    input reset,
    output[7:0] sawtooth_wave
    );

    localparam [1:0]rst = 2'b00, step = 2'b01, waiting = 2'b10;
    reg [1:0]state, next_state;
    reg[7:0] temp_wave = 8'b0; // Value for the waveform
    reg [4:0] counter = 5'b0; // Counter to get to 25 steps
    wire step_en,step_res;
    
    always@(posedge clk, posedge reset)begin
        if(reset)begin
            state <= rst;
            counter <= 5'b0;
        end
        else begin
            state <= next_state;
            if(counter==5'd24)counter <= 5'b0;
            else counter <= counter + 1'b1;
        end
    end
    
    assign step_en = (counter==5'd24)?1'b1:1'b0;
    
    always @ (state, clk, step_en) // Sensitivity List
        case (state) // Will change based on state
        reset: begin
            if(clk) next_state = step;
            else begin
                next_state = rst;
                temp_wave = 8'b0;
            end
        end
        step: // State to generate wave steps
            begin
            if (step_en) // if counter reaches 25 steps, the state goes to default and the counter resets
                begin
                next_state = rst;
                temp_wave = 8'b0;
                end
            else // increment by 10 everytime
                begin
                temp_wave = temp_wave + 8'd10;
                next_state = waiting;
                end
            end
        waiting: begin
            if(step_en) next_state = step;
            else next_state = waiting;
        end
        default: // zero state
            begin      
            temp_wave = 8'b0;
            next_state = rst;
            end
        endcase
    
    assign sawtooth_wave = temp_wave;


endmodule
