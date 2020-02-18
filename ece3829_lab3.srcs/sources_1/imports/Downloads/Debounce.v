module debounce(

    input clk,
    input reset,
    input in,
    output out
    );

    wire cnt_en;
    reg [1:0] state, next_state;
    reg [31:0] cnt;
    parameter [31:0] delay = 30;
    parameter [1:0] zero = 2'b00, one_pressed = 2'b01, one = 2'b10, transition = 2'b11;

    always @ (posedge clk, posedge reset)
        if(reset)
            state <= zero;
        else
            state <= next_state;
            
    always @ (posedge clk, posedge reset)
        if(reset)
            cnt <= 0;
        else
            if(cnt_en)
                if(cnt == delay)
                    cnt <= 0;
                else cnt <= cnt + 1;
            else cnt <= 0;

    assign cnt_en = (state == one_pressed || state == transition);

    always@ (state, in)
        case(state)
            zero:
                if(in)
                    next_state <= one_pressed;
                else
                    next_state <= zero;
            one_pressed:
                if(cnt == delay)
                    next_state <= one;
                else next_state <= one_pressed;
            one:
                next_state <= transition;
            transition:
                if(cnt == delay)
                    next_state <= zero;
                else next_state <= transition;
            default:
                next_state <= zero;

        endcase

    assign out = (state == one);   

endmodule
