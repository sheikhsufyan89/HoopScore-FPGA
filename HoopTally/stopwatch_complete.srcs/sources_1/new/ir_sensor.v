`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2023 02:49:32 PM
// Design Name: 
// Module Name: ir_sensor
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


module ir_sensor(
  input wire ir_sensor,   // Input from the IR sensor
  input wire clk_100MHz,       // Clock signal
  input wire reset,       // Reset signal
  output reg detection    // Output to indicate detection
);

// Define a state machine to process IR sensor data
reg [1:0] state;

parameter IDLE = 2'b00;
parameter DETECTING = 2'b01;

always @(posedge clk_100MHz or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    detection <= 1'b0;
  end else begin
    case (state)
      IDLE: begin
        // Check if the IR sensor signal indicates detection
        if (ir_sensor == 1'b1) begin
          state <= DETECTING;
          // Set the detection output to indicate detection
          detection <= 1'b1;
        end else begin
          // Add a condition to keep detection low if reset is not pressed
          detection <= 1'b0;
        end
      end

      DETECTING: begin
        // Continue detecting until the signal goes low
        if (ir_sensor == 1'b1) begin
          detection <= 1'b1; // Set the detection output
        end else begin
          state <= IDLE;
          detection <= 1'b0;
        end
      end
    endcase
  end
end     

endmodule