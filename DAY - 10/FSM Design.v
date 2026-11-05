// 101 Overlapping Sequence Detector – Mealy FSM
module sequence_detector_101 (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output reg  detected
);

localparam S0 = 2'b00,
           S1 = 2'b01,
           S2 = 2'b10;

reg [1:0] state, next_state;

// BLOCK 1: State register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

// BLOCK 2: Next-state logic
// BLOCK 3: Mealy output logic
always @(*) begin

    next_state = state;
    detected   = 1'b0;

    case (state)

        S0: begin
            if (din)
                next_state = S1;
            else
                next_state = S0;
        end

        S1: begin
            if (din)
                next_state = S1;
            else
                next_state = S2;
        end

        S2: begin
            if (din) begin
                next_state = S1;
                detected   = 1'b1;
            end
            else begin
                next_state = S0;
            end
        end

        default: begin
            next_state = S0;
            detected   = 1'b0;
        end

    endcase

end

endmodule

//2. 1011 Non-overlapping Sequence Detector – Moore FSM

module sequence_detector_1011 (
    input  wire clk,
    input  wire rst,
    input  wire din,
    output reg  detected
);

localparam S0 = 3'b000,
           S1 = 3'b001,
           S2 = 3'b010,
           S3 = 3'b011,
           S4 = 3'b100;

reg [2:0] state, next_state;

// BLOCK 1: State register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

// BLOCK 2: Next-state logic
always @(*) begin

    next_state = state;

    case (state)

        S0:
            if (din)
                next_state = S1;
            else
                next_state = S0;

        S1:
            if (din)
                next_state = S1;
            else
                next_state = S2;

        S2:
            if (din)
                next_state = S3;
            else
                next_state = S0;

        S3:
            if (din)
                next_state = S4;
            else
                next_state = S2;

        S4:
            next_state = S0;

        default:
            next_state = S0;

    endcase

end

// BLOCK 3: Moore output logic
always @(*) begin

    detected = 1'b0;

    case (state)

        S4: detected = 1'b1;

        default: detected = 1'b0;

    endcase

end

endmodule
