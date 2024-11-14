`timescale 1ns / 1ps

module new_binary_clock(
    input clk_100MHz,                   // sys clock
    input reset,                        // reset clock
    input enable,                       // enable signal to start/stop the clock
    output tick_1Hz,                    // 1Hz output signal
    output reg [3:0] sec_1s, sec_10s,   // BCD outputs for seconds
    output reg [3:0] min_1s, min_10s,   // BCD outputs for minutes
    output reg clock_stopped            // Output signal indicating clock has stopped
);

    // ********************************************************
    // Create the 1Hz signal
    reg [31:0] ctr_1Hz = 32'h0;
    reg r_1Hz = 1'b0;
    
    always @(posedge clk_100MHz or posedge reset) begin
        if(reset) begin
            ctr_1Hz <= 32'h0;
            r_1Hz <= 1'b0;
        end else if (enable) begin
            if(ctr_1Hz == 49_999_999) begin
                ctr_1Hz <= 32'h0;
                r_1Hz <= ~r_1Hz;
            end else
                ctr_1Hz <= ctr_1Hz + 1;
        end
    end

    // ********************************************************
    // Regs for each time value
    reg [5:0] seconds_ctr = 6'd59;   // 59
    reg [5:0] minutes_ctr = 6'd1;    // 01

    // Seconds counter reg control
    always @(posedge tick_1Hz or posedge reset) begin
        if(reset) begin
            seconds_ctr <= 6'd59;
            minutes_ctr <= 6'd1;
            clock_stopped <= 1'b0; // Reset clock_stopped signal
        end else if (enable) begin
            if (seconds_ctr == 6'd0) begin
                if (minutes_ctr == 6'd0) begin
                    clock_stopped <= 1'b1; // Clock is stopped when both seconds and minutes are zero
                end else begin
                    minutes_ctr <= minutes_ctr - 1;
                    seconds_ctr <= 6'd59;
                end
            end else begin
                seconds_ctr <= seconds_ctr - 1;
                clock_stopped <= 1'b0; // Clock is running
            end
        end
    end

    // Convert binary values to output BCD values
    always @* begin
        sec_10s = seconds_ctr / 10;
        sec_1s  = seconds_ctr % 10;
        min_10s = minutes_ctr / 10;
        min_1s  = minutes_ctr % 10;
    end

    // 1Hz output            
    assign tick_1Hz = r_1Hz; 
            
endmodule
