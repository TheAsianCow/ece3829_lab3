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
    input clk_100k,
    input reset,
    output [7:0]sawtooth_wave
    );

    localparam res = 0, step = 1;
    reg state, next_state;
    reg [7:0] count, next_count;
    
    always@(negedge clk_100k, posedge reset)begin
        if(reset)begin
            state <= res;
            count <= 0;
        end
        else begin
            state <= next_state;
            count <= next_count;
        end
    end
    
    always@(state, count)begin
        case(state)
            res: begin
                next_count = 0;
                next_state = step;
            end
            step: begin
                next_count = count+2;
                if((count+2)>=128) next_state = res;
                else next_state = step;
            end
        endcase
    end 
    
    assign sawtooth_wave = count;

//    initial state = zero;
//    initial temp_wave = 0;
    
//    always@(posedge clk_100k)begin
//        case(state)
//            zero: if(clk_100k)state <= step;
//            step: if(clk_100k)state <= waiting;
//                    else state <= zero;
//            waiting: if(~clk_100k) state <= zero;
//            default:;
//        endcase
//    end
//    always@(state, clk_100k)begin
//        case(state)
//            zero: sawtooth_wave = temp_wave;
//            step: begin
//                if(temp_wave==128)temp_wave = 0;
//                else temp_wave = temp_wave+2;
//                sawtooth_wave = temp_wave;
//            end
//            waiting: sawtooth_wave = temp_wave;
//        endcase
//    end

//    reg[7:0] tmp_wave = 8'b0;
//    always@(posedge clk_100k, posedge reset)begin
//        if(reset) tmp_wave = 8'b0;
//        else if(tmp_wave==128) tmp_wave = 8'b0;
//        else tmp_wave = tmp_wave + 2;
//    end
    
//    assign sawtooth_wave = tmp_wave;
    
endmodule
