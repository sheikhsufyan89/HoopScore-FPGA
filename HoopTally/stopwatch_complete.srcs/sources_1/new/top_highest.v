`timescale 1ns / 1ps

module top_highest(
    input clk_100MHz,       // 100MHz on Basys 3
    input reset,            // btnC
    input ir_sensor,
    input ir_sensor2,
    input start_btn,
    output hsync,           // to VGA Connector
    output vsync,           // to VGA Connector
    output [11:0] rgb
);

// Define states
parameter START_SCREEN_STATE = 2'b00;
parameter TOP_STATE = 2'b01;
parameter END_SCREEN_STATE = 2'b10; // Define end screen state
reg [1:0] state, next_state;

// Internal signals for VGA controller
wire [9:0] w_x, w_y;
wire video_on, p_tick;
wire [11:0] start_rgb, top_rgb, end_rgb, start_hsync, start_vsync, mid_hsync, mid_vsync, end_hsync, end_vsync; // Separate RGB signals for each module
reg enable_startscreen, enable_top, enable_endscreen; // Internal enables for each state
wire [3:0] result;
wire stopped;
//wire home, away, tie;
// Instantiate top_startscreen module
top_startscreen startscreen(
    .clk_100MHz(clk_100MHz),
    .enable(enable_startscreen),           // Pass enable signal
    .hsync(start_hsync),
    .vsync(start_vsync),
    .rgb(start_rgb) // Connect start_rgb to top_startscreen
); 

// Instantiate top module
top top_inst (
    .clk_100MHz(clk_100MHz),
    .reset(reset),
    .ir_sensor(ir_sensor),
    .ir_sensor2(ir_sensor2),
    .enable(enable_top),           // Pass enable signal
    .hsync(mid_hsync),
    .vsync(mid_vsync),
    .rgb(top_rgb),
    .stopped(stopped),
    .result(result),
    .home(home),
    .away(away),
    .tie(tie) // Connect top_rgb to top module
//    .clock_stopped(clock_stopped)
);

// Instantiate top_endscreen module
top_endscreen endscreen(    
    .clk_100MHz(clk_100MHz),
    .enable(enable_endscreen),
    .result(result),
    .home(home),
    .away(away),
    .tie(tie),           // Pass enable signal
    .hsync(end_hsync),
    .vsync(end_vsync),
    .rgb(end_rgb) // Connect end_rgb to top_endscreen
);

// State machine
always @(posedge clk_100MHz or posedge reset) begin
    if (reset) begin
        state <= START_SCREEN_STATE;
    end else begin
        state <= next_state;
    end
end

// State transitions
// State transitions
always @(*) begin
    case (state)
        START_SCREEN_STATE: begin
            if (start_btn == 1'b0) begin
                next_state = START_SCREEN_STATE;
                enable_startscreen = 1'b1; // Enable the start screen
                enable_top = 1'b0; // Disable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end else begin
                next_state = TOP_STATE;
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b1; // Enable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end
        end
        TOP_STATE: begin
            if (stopped) begin // Check if the clock is stopped
                next_state = END_SCREEN_STATE; // Transition to end screen state
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b0; // Disable the top module
                enable_endscreen = 1'b1; // Enable the end screen
            end else if (start_btn == 1'b1) begin
                next_state = TOP_STATE;
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b1; // Enable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end else begin
                next_state = TOP_STATE;
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b1; // Enable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end
        end
        END_SCREEN_STATE: begin
            if (start_btn == 1'b0) begin
                next_state = START_SCREEN_STATE; // Transition back to start screen state
                enable_startscreen = 1'b1; // Enable the start screen
                enable_top = 1'b0; // Disable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end else if (reset == 1'b1) begin
                next_state = TOP_STATE; // Transition to top state
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b1; // Enable the top module
                enable_endscreen = 1'b0; // Disable the end screen
            end else begin
                next_state = END_SCREEN_STATE; // Remain in end screen state
                enable_startscreen = 1'b0; // Disable the start screen
                enable_top = 1'b0; // Disable the top module
                enable_endscreen = 1'b1; // Enable the end screen
            end
        end
        default: begin
            next_state = START_SCREEN_STATE;
            enable_startscreen = 1'b1; // Enable the start screen by default
            enable_top = 1'b0; // Disable the top module by default
            enable_endscreen = 1'b0; // Disable the end screen by default
        end
    endcase
end


// Output assignment based on state
assign rgb = (state == START_SCREEN_STATE) ? start_rgb : ((state == TOP_STATE) ? top_rgb : end_rgb);
assign hsync = (state == START_SCREEN_STATE) ? start_hsync : ((state == TOP_STATE) ? mid_hsync : end_hsync);
assign vsync = (state == START_SCREEN_STATE) ? start_vsync : ((state == TOP_STATE) ? mid_vsync : end_vsync);


endmodule
