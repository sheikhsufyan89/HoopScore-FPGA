`timescale 1ns / 1ps

module pixel_clk_gen(
    input clk,
    input video_on,
    input [9:0] x, y,
    input [3:0] sec_1s, sec_10s,
    input [3:0] min_1s, min_10s,
    input [3:0] counter_1s, counter_10s,
    input [3:0] counter2_1s, counter2_10s,
    output reg [11:0] time_rgb
    );
  
    // *** Constant Declarations ***

    // Colon section = 32 x 64
    localparam COLON_X_L = 320;
    localparam COLON_X_R = 351;
    localparam COLON_Y_T = 192;
    localparam COLON_Y_B = 256;
    
    // Minute 10s Digit section = 32 x 64
    localparam M10_X_L = 256;
    localparam M10_X_R = 287;
    localparam M10_Y_T = 192;
    localparam M10_Y_B = 256;
    
    // Minute 1s Digit section = 32 x 64
    localparam M1_X_L = 288;
    localparam M1_X_R = 319;
    localparam M1_Y_T = 192;
    localparam M1_Y_B = 256;
    
    // Second 10s Digit section = 32 x 64
    localparam S10_X_L = 352;
    localparam S10_X_R = 383;
    localparam S10_Y_T = 192;
    localparam S10_Y_B = 256;
    
    // Second 1s Digit section = 32 x 64
    localparam S1_X_L = 384;
    localparam S1_X_R = 415;
    localparam S1_Y_T = 192;
    localparam S1_Y_B = 256;
    
        // Counter 1s 1s Digit section = 32 x 64
    localparam C1_X_L = 448;
    localparam C1_X_R = 479;
    localparam C1_Y_T = 192;
    localparam C1_Y_B = 256;
    // Counter 10s Digit section = 32 x 64
    localparam C10_X_L = 480;
    localparam C10_X_R = 511;
    localparam C10_Y_T = 192;
    localparam C10_Y_B = 256;
    
    localparam Z1_X_L = 160; // Adjust the left boundary
    localparam Z1_X_R = 191; // Adjust the right boundary
    localparam Z1_Y_T = 192;
    localparam Z1_Y_B = 256;
    
    // Counter 10s Digit section = 32 x 64 (positioned to the left)
    localparam Z10_X_L = 192; // Adjust the left boundary
    localparam Z10_X_R = 223; // Adjust the right boundary
    localparam Z10_Y_T = 192;
    localparam Z10_Y_B = 256;

//    localparam Z1_X_L = 158; // Adjust the left boundary slightly to the left
//localparam Z1_X_R = 189; // Adjust the right boundary slightly to the left
//localparam Z1_Y_T = 192;
//localparam Z1_Y_B = 256;

//// Counter 10s Digit section = 32 x 64 (positioned to the left)
//localparam Z10_X_L = 190; // Adjust the left boundary slightly to the left
//localparam Z10_X_R = 221; // Adjust the right boundary slightly to the left
//localparam Z10_Y_T = 192;
//localparam Z10_Y_B = 256;

    
    
    
    // Object Status Signals
    wire COLON_on, M10_on, M1_on, S10_on, S1_on, C10_on, C1_on, Z10_on, Z1_on;
    
    // ROM Interface Signals
    wire [10:0] rom_addr;
    reg [6:0] char_addr;   // 3'b011 + BCD value of time component
    wire [6:0] char_addr_m10, char_addr_m1, char_addr_s10, char_addr_s1, char_addr_c10, char_addr_c1, char_addr_z10, char_addr_z1, char_addr_colon;
    reg [3:0] row_addr;    // row address of digit
    wire [3:0] row_addr_m10, row_addr_m1, row_addr_s10, row_addr_s1, row_addr_c10, row_addr_c1, row_addr_z10, row_addr_z1, row_addr_colon;
    reg [2:0] bit_addr;    // column address of rom data
    wire [2:0] bit_addr_m10, bit_addr_m1, bit_addr_s10, bit_addr_s1, bit_addr_c10, bit_addr_c1, bit_addr_z10, bit_addr_z1, bit_addr_colon;
    wire [7:0] digit_word;  // data from rom
    wire digit_bit;
    
    assign char_addr_m10 = {3'b011, min_10s};
    assign row_addr_m10 = y[5:2];   // scaling to 32x64
    assign bit_addr_m10 = x[4:2];   // scaling to 32x64
    
    assign char_addr_m1 = {3'b011, min_1s};
    assign row_addr_m1 = y[5:2];   // scaling to 32x64
    assign bit_addr_m1 = x[4:2];   // scaling to 32x64
    
    assign char_addr_colon = 7'h3a; // Colon character address
    assign row_addr_colon = y[5:2]; // scaling to 32x64
    assign bit_addr_colon = x[4:2]; // scaling to 32x64
    
    assign char_addr_s10 = {3'b011, sec_10s};
    assign row_addr_s10 = y[5:2];   // scaling to 32x64
    assign bit_addr_s10 = x[4:2];   // scaling to 32x64
    
    assign char_addr_s1 = {3'b011, sec_1s};
    assign row_addr_s1 = y[5:2];   // scaling to 32x64
    assign bit_addr_s1 = x[4:2];   // scaling to 32x64
    
    assign char_addr_c10 = {3'b011, counter_10s};
    assign row_addr_c10 = y[5:2];   // scaling to 32x64
    assign bit_addr_c10 = x[4:2];   // scaling to 32x64
    
    assign char_addr_c1 = {3'b011, counter_1s};
    assign row_addr_c1 = y[5:2];   // scaling to 32x64
    assign bit_addr_c1 = x[4:2];   // scaling to 32x64
    
    assign char_addr_z10 = {3'b011, counter2_10s};
    assign row_addr_z10 = y[5:2];   // scaling to 32x64
    assign bit_addr_z10 = x[4:2];   // scaling to 32x64
    
    assign char_addr_z1 = {3'b011, counter2_1s};
    assign row_addr_z1 = y[5:2];   // scaling to 32x64
    assign bit_addr_z1 = x[4:2];   // scaling to 32x64
    
        

    
    // Instantiate digit rom
    clock_digit_rom cdr(.clk(clk), .addr(rom_addr), .data(digit_word));
    
    // Colon ROM assert signals
    assign COLON_on = (COLON_X_L <= x) && (x <= COLON_X_R) &&
                      (COLON_Y_T <= y) && (y <= COLON_Y_B);
                               
    // Minute sections assert signals
    assign M10_on = (M10_X_L <= x) && (x <= M10_X_R) &&
                    (M10_Y_T <= y) && (y <= M10_Y_B);
    assign M1_on =  (M1_X_L <= x) && (x <= M1_X_R) &&
                    (M1_Y_T <= y) && (y <= M1_Y_B);                             
    
    // Second sections assert signals
    assign S10_on = (S10_X_L <= x) && (x <= S10_X_R) &&
                    (S10_Y_T <= y) && (y <= S10_Y_B);
    assign S1_on =  (S1_X_L <= x) && (x <= S1_X_R) &&
                    (S1_Y_T <= y) && (y <= S1_Y_B);
                

    // Counter sections assert signals
    assign C10_on = (C10_X_L <= x) && (x <= C10_X_R) &&
                    (C10_Y_T <= y) && (y <= C10_Y_B);
    assign C1_on =  (C1_X_L <= x) && (x <= C1_X_R) &&
                    (C1_Y_T <= y) && (y <= C1_Y_B);              
                    
                    
                            
      // Counter sections assert signals
    assign Z10_on = (Z10_X_L <= x) && (x <= Z10_X_R) &&
                    (Z10_Y_T <= y) && (y <= Z10_Y_B);
    assign Z1_on =  (Z1_X_L <= x) && (x <= Z1_X_R) &&
                    (Z1_Y_T <= y) && (y <= Z1_Y_B);    
                    
                            
    // Mux for ROM Addresses and RGB    
    always @* begin
        time_rgb = 12'h222;     //222        // black background
        if(M10_on) begin
            char_addr = char_addr_m10;
            row_addr = row_addr_m10;
            bit_addr = bit_addr_m10;
            if(digit_bit)
                time_rgb = 12'hF80;    //F80 // red
        end
        else if(M1_on) begin
            char_addr = char_addr_m1;
            row_addr = row_addr_m1;
            bit_addr = bit_addr_m1;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if(COLON_on) begin
            char_addr = char_addr_colon;
            row_addr = row_addr_colon;
            bit_addr = bit_addr_colon;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if(S10_on) begin
            char_addr = char_addr_s10;
            row_addr = row_addr_s10;
            bit_addr = bit_addr_s10;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if(S1_on) begin
            char_addr = char_addr_s1;
            row_addr = row_addr_s1;
            bit_addr = bit_addr_s1;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end 
        else if(C10_on) begin
            char_addr = char_addr_c10;
            row_addr = row_addr_c10;
            bit_addr = bit_addr_c10;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if(C1_on) begin
            char_addr = char_addr_c1;
            row_addr = row_addr_c1;
            bit_addr = bit_addr_c1;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end 
        else if(Z10_on) begin
            char_addr = char_addr_z10;
            row_addr = row_addr_z10;
            bit_addr = bit_addr_z10;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if(Z1_on) begin
            char_addr = char_addr_z1;
            row_addr = row_addr_z1;
            bit_addr = bit_addr_z1;
            if(digit_bit)
                time_rgb = 12'hF80;     // red
        end
        else if (video_on) begin 
             time_rgb <= 12'h000;//000


            //H        
            if ((x >= 100 && x <= 105 && y >= 120 && y <= 160)||
            (x >= 105 && x <= 115 && y >= 135 && y <= 145)||
            (x >= 115 && x <= 120 && y >= 120 && y <= 160)||
        //O
            (x >= 130 && x <= 135 && y >= 120 && y <= 160)||
            (x >= 135 && x <= 145 && y >= 120 && y <= 130)||
            (x >= 145 && x <= 150 && y >= 120 && y <= 160)||
            (x >= 135 && x <= 145 && y >= 150 && y <= 160)||
        //M
            (x >= 160 && x <= 185 && y >= 120 && y <= 130)||
            (x >= 160 && x <= 165 && y >= 130 && y <= 160)||
            (x >= 170 && x <= 175 && y >= 130 && y <= 145)||
            (x >= 180 && x <= 185 && y >= 130 && y <= 160)||
        //E
            (x >= 195 && x <= 200 && y >= 120 && y <= 160)||
            (x >= 200 && x <= 210 && y >= 120 && y <= 130)||
            (x >= 200 && x <= 205 && y >= 135 && y <= 145)||
            (x >= 200 && x <= 210 && y >= 150 && y <= 160)||
             //A
            (x >= 440 && x <= 445 && y >= 120 && y <= 160)||
            (x >= 445 && x <= 450 && y >= 120 && y <= 130)||
            (x >= 445 && x <= 450 && y >= 140 && y <= 150)||
            (x >= 450 && x <= 455 && y >= 120 && y <= 160)||
        //W
            (x >= 465 && x <= 470 && y >= 120 && y <= 160)||
            (x >= 475 && x <= 480 && y >= 145 && y <= 160)||
            (x >= 485 && x <= 490 && y >= 120 && y <= 160)||
            (x >= 465 && x <= 490 && y >= 150 && y <= 160)||
        //A
            (x >= 500 && x <= 505 && y >= 120 && y <= 160)||
            (x >= 505 && x <= 510 && y >= 120 && y <= 130)||
            (x >= 505 && x <= 510 && y >= 140 && y <= 150)||
            (x >= 510 && x <= 515 && y >= 120 && y <= 160)||
        //Y
            (x >= 520 && x <= 525 && y >= 120 && y <= 140)||
            (x >= 535 && x <= 540 && y >= 120 && y <= 140)||
            (x >= 520 && x <= 540 && y >= 140 && y <= 145)||
            (x >= 527 && x <= 534 && y >= 145 && y <= 160)||
            
            //borders
            (x >= 0 && x <= 20 && y >= 0 && y <=500)||
            (x >= 620 && x <= 639 && y >= 0 && y <= 500)||
            (x >= 20 && x <= 620 && y >= 0 && y <= 20)||
            (x >= 20 && x <= 620 && y >= 480 && y <= 500)
            )
        
            begin
            time_rgb <= {4'hF, 4'hF, 4'hF};//FFF
            
        
        
        
            end
        end
    end    
    
    // ROM Interface    
    assign rom_addr = {char_addr, row_addr};
    assign digit_bit = digit_word[~bit_addr];    
                          
endmodule