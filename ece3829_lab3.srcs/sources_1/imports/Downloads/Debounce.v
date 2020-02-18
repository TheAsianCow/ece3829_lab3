module debounce(
    input clk,
    input reset,
    input clk_en,
    input in,
    output reg out
    );

    parameter zero = 3'b000, zero_to_one = 3'b001, one_wait = 3'b010, one = 3'b011, one_to_zero = 3'b100, zero_wait = 3'b101;
    
    reg [2:0] state, next_state;
    reg [4:0] cnt = 5'b0;
    
    reg cnt_en; 
    wire timeout;
    
    
    always@(posedge clk_en, posedge reset)begin
        if(reset)begin 
            state <= zero; 
            cnt <= 6'b0;
        end
        else begin
            state <= next_state;
            if(cnt_en)begin
                if(cnt==29) cnt <= 5'b0;
                else cnt <= cnt + 1;
            end
            else cnt <= 5'b0;
        end
    end
    
    assign timeout = (cnt==29)?1:0;
    
    always@(state)begin
        cnt_en = 0;
        out = 0;
        case(state)
            zero:
                if(reset||in==0) next_state = zero;
                else if(in==1) next_state = zero_to_one;
                else next_state = zero;
            zero_to_one:
                if(in==1) next_state = one_wait;
                else if(in==0) next_state = zero;
                else next_state = zero;
            one_wait:begin
                if(timeout) next_state = one;
                else next_state = one_wait;
                out = 1;
                cnt_en = 1;
            end
            one:begin
                if(in==0) next_state = one_to_zero;
                else next_state = one;
                out = 1;
            end
            one_to_zero:begin
                out = 1;
                if(in==1)next_state = one;
                else if(in==0) next_state = zero_wait;
                else next_state = one_to_zero;
            end
            zero_wait:begin
                if(timeout==1)next_state = zero;
                else next_state = zero_wait;
                cnt_en = 1;
            end
        endcase
    end
    
    
//    always @ (clk_en) begin
//        if (cnt_en) begin
//            cnt <= cnt + 1'b1;
//            if (cnt == 32) 
//                begin
//                cnt <= 0;
//                timeout <= 1;
//                cnt_en <= 0;
//                end
//            else
//                timeout <= 0;
//            end
//        else
//            cnt <= 0;
//    end
    
//    always @ (state, in) //add cnt_en
//    case(state)
//    zero:
//        if (in == 0 || reset)
//            next_state <= zero;
//        else
//            next_state <= zero_to_one;
//    zero_to_one:
//        if (in == 1)
//            next_state <= one_wait;
//        else
//            next_state <= zero;
//    one_wait:
//        begin
//        out <= 1'b1;
//        cnt_en <= 1'b1;
//        if (timeout) next_state <= one;
//        else next_state <= one_wait;
//        end
//    one:
//        begin
//        out <= 1'b1;
//        if (in)
//            next_state <= one;
//        else
//            next_state <= one_to_zero;
//        end
//    one_to_zero:
//        begin
//        out <= 1'b1;
//        if (in == 1)
//            next_state <= one;
//        else
//            next_state <= zero_wait;
//        end
//    zero_wait:
//        begin
//        cnt_en <= 1'b1;
//        if (timeout)
//            next_state <= zero;
//        else
//            next_state <= zero_wait;
//        end
//    default: 
//        next_state <= zero;
//    endcase
    

endmodule
