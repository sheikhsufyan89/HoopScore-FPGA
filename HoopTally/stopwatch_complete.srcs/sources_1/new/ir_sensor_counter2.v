module ir_sensor_counter2(
    input ir_sensor2,                   // Input representing the IR sensor signal
    input clk_100MHz,                  // 100 MHz clock input
    input reset,                       // Reset signal
    input enable,                      // Enable signal
    output reg [3:0] counter2_1s,       // Output representing the units place of the counter
    output reg [3:0] counter2_10s,       // Output representing the tens place of the counter 
    output  reg [3:0] score_binary2   
);

    clk_div (
        .clk_100MHz(clk_100MHz),
        .clk_div(clk_div)
    );

//    reg [3:0] score_binary;
    // Declare internal signals
    reg [3:0] counter_up;  // Counter for debouncing
    reg ir_detected;       // Flag to indicate IR detection

    // Synchronize IR sensor signal with clock and detect rising edge
    reg ir_sensor_sync;
    reg ir_sensor_sync_prev;

    always @(posedge clk_div or posedge reset) begin
        if (reset) begin
            ir_sensor_sync <= 1'b0;
            ir_sensor_sync_prev <= 1'b0;
        end else begin
            ir_sensor_sync <= ir_sensor2;
            ir_sensor_sync_prev <= ir_sensor_sync;
        end
    end

    // Sensor detection and counter update with debouncing
    always @(posedge clk_div or posedge reset) begin
        if (reset) begin
            counter_up <= 4'b0;
            ir_detected <= 1'b0;
        end else if (enable) begin
            if (ir_sensor_sync && !ir_sensor_sync_prev && !ir_detected) begin
                // Increment only on rising edge of synchronized ir_sensor and if not previously detected
                if (counter_up < 100) begin
                    counter_up <= counter_up + 1;
                end else begin
                    counter_up <= 0; // Reset counter to 0 when it reaches 9
                end
                ir_detected <= 1'b1;
            end else if (!ir_sensor_sync) begin
                // Reset ir_detected when synchronized IR sensor signal is low
                ir_detected <= 1'b0;
            end
        end
    end

    // Output the units place of the counter
    always @(posedge clk_div) begin
        if (reset) begin
            score_binary2 <= 4'b0;
        end else begin
            score_binary2 <= counter_up[3:0];
        end
    end
    always @* begin
        counter2_10s = score_binary2 % 10; // Extract the tens place digit
        counter2_1s = score_binary2 / 10;  // Extract the units place digit
    end
endmodule
