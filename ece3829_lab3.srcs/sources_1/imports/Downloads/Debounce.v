module debounce(
    input clk,
    input reset,
    input in,
    output out
    );

    parameter in_low = 2'b00, in_waiting = 2'b01, in_high = 2'b10;
    reg [1:0]state, next_state;
    reg [4:0]count = 0;
    reg cnt_en;
    wire timeout;
    
    always@(posedge clk, posedge reset)begin
        if(reset)begin 
            state <= in_low;
            count <= 0;
        end
        else begin
            state <= next_state;
            if(cnt_en)
                if(count==29) count <= 0;
                else count <= count + 1;
            else count <= 0;
        end
    end
    
    assign timeout = count==29;
    
    always@(state, in, count)begin
        case(state)
            in_low: begin
                if(in)begin
                    cnt_en = 1;
                    next_state = in_waiting;
                end
                else begin
                    next_state = in_low;
                    cnt_en = 0;
                end
            end
            in_waiting: begin
                if(timeout)begin
                    next_state = in_high;
                    cnt_en = 0;
                end
                else begin
                    next_state = in_waiting;
                    cnt_en = 1;
                end
            end
            in_high:begin
                if(in)begin
                    next_state = in_waiting;
                    cnt_en = 1;
                end
                else begin
                    next_state = in_low;
                    cnt_en = 0;
                end
            end
        endcase
    end
    
    assign out = state==in_waiting;

// parameter zero = 3'b000, zero_to_one = 3'b001, one_wait = 3'b010, one = 3'b011, one_to_zero = 3'b100, zero_wait = 3'b101;
    
//    reg [2:0] state, next_state;
//    reg [4:0] cnt = 5'b0;
    
//    reg cnt_en; 
//    wire timeout;
    
    
//    always@(posedge clk, posedge reset)begin
//        if(reset)begin 
//            state <= zero; 
//            cnt <= 6'b0;
//        end
//        else begin
//            state <= next_state;
//            if(cnt_en)begin
//                if(cnt==29) cnt <= 5'b0;
//                else cnt <= cnt + 1;
//            end
//            else cnt <= 5'b0;
//        end
//    end
    
//    assign timeout = (cnt==29)?1:0;
    
//    always@(state)begin
//        cnt_en = 0;
//        out = 0;
//        case(state)
//            zero:
//                if(reset||in==0) next_state = zero;
//                else if(in==1) next_state = zero_to_one;
//                else next_state = zero;
//            zero_to_one:
//                if(in==1) next_state = one_wait;
//                else if(in==0) next_state = zero;
//                else next_state = zero;
//            one_wait:begin
//                if(timeout) next_state = one;
//                else next_state = one_wait;
//                out = 1;
//                cnt_en = 1;
//            end
//            one:begin
//                if(in==0) next_state = one_to_zero;
//                else next_state = one;
//                out = 1;
//            end
//            one_to_zero:begin
//                out = 1;
//                if(in==1)next_state = one;
//                else if(in==0) next_state = zero_wait;
//                else next_state = one_to_zero;
//            end
//            zero_wait:begin
//                if(timeout==1)next_state = zero;
//                else next_state = zero_wait;
//                cnt_en = 1;
//            end
//        endcase
//    end
//    wire cnt_en;
//    reg [1:0] state, next_state;
//    reg [31:0] cnt;
//    parameter [31:0] delay = 30;
//    parameter [1:0] zero = 2'b00, one_pressed = 2'b01, one = 2'b10, transition = 2'b11;
//    always @ (posedge clk, posedge reset)
//        if(reset)
//            state <= zero;
//        else
//            state <= next_state;
            
//    always @ (posedge clk, posedge reset)
//        if(reset)
//            cnt <= 0;
//        else
//            if(cnt_en)
//                if(cnt == delay)
//                    cnt <= 0;
//                else cnt <= cnt + 1;
//            else cnt <= 0;
//    assign cnt_en = (state == one_pressed || state == transition);
//    always@ (state, in)
//        case(state)
//            zero:
//                if(in)
//                    next_state <= one_pressed;
//                else
//                    next_state <= zero;
//            one_pressed:
//                if(cnt == delay)
//                    next_state <= one;
//                else next_state <= one_pressed;
//            one:
//                next_state <= transition;
//            transition:
//                if(cnt == delay)
//                    next_state <= zero;
//                else next_state <= transition;
//            default:
//                next_state <= zero;
//        endcase
//    assign out = (state == one); 

endmodule
