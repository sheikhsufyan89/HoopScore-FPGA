module pixel_endscreen(
    input clk_d, // pixel clock
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input video_on,
    input result, 
    input home,
    input away, 
    input tie,
//    input btn, // New input for selecting pattern
    output reg [11:0] rgb = 12'hF00  // Default color is white
);
reg btn = 1'b1;
always @(posedge clk_d) begin
    // Default color (black)
    rgb <= 12'hF00; // Default color is white

    // Pixel coordinates for each letter of "PLAYER1" when btn is 0
    if (home == 1'b1) begin
        // Conditions for displaying "PLAYER1" pattern
        // Modify these conditions as needed
        if (
            // H conditions
            (pixel_x >= 130 && pixel_x <= 150 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 150 && pixel_x <= 190 && pixel_y >= 155 && pixel_y <= 175)||
            (pixel_x >= 190 && pixel_x <= 210 && pixel_y >= 80 && pixel_y <= 250)||
        //O
            (pixel_x >= 230 && pixel_x <= 250 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 290 && pixel_x <= 310 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 250 && pixel_x <= 290 && pixel_y >= 80 && pixel_y <= 100)||
            (pixel_x >= 250 && pixel_x <= 290 && pixel_y >= 230 && pixel_y <= 250)||
        //M
            (pixel_x >= 330 && pixel_x <= 350 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 390 && pixel_x <= 410 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 350 && pixel_x <= 390 && pixel_y >= 80 && pixel_y <= 100)||
            (pixel_x >= 360 && pixel_x <= 380 && pixel_y >= 100 && pixel_y <= 250)||
        //E
            (pixel_x >= 430 && pixel_x <= 450 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 450 && pixel_x <= 520 && pixel_y >= 80 && pixel_y <= 100)||
            (pixel_x >= 450 && pixel_x <= 510 && pixel_y >= 155 && pixel_y <= 175)||
            (pixel_x >= 450 && pixel_x <= 520 && pixel_y >= 230 && pixel_y <= 250)||
//            begin
//            red<=4'h0;
//            green<=4'h0;
//            blue<=4'h0;
//            end
        
//            else
             //W
                (pixel_x >= 140 && pixel_x <= 150 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 170 && pixel_x <= 180 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 200 && pixel_x <= 210 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 140 && pixel_x <= 210 && pixel_y >= 390 && pixel_y <= 400)||
            //I
                (pixel_x >= 230 && pixel_x <= 290 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 230 && pixel_x <= 290 && pixel_y >= 390 && pixel_y <= 400)||
                (pixel_x >= 260 && pixel_x <= 270 && pixel_y >= 280 && pixel_y <= 390)||
            //N
                (pixel_x >= 300 && pixel_x <= 390 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 300 && pixel_x <= 310 && pixel_y >= 280 && pixel_y <= 400)||
                (pixel_x >= 380 && pixel_x <= 390 && pixel_y >= 280 && pixel_y <= 400)||
            //S
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 410 && pixel_x <= 420 && pixel_y >= 280 && pixel_y <= 330)||
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 330 && pixel_y <= 340)||
                (pixel_x >= 470 && pixel_x <= 480 && pixel_y >= 340 && pixel_y <= 390)||
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 390 && pixel_y <= 400)||
 //           //!
 //               (pixel_x >= 405 && pixel_x <= 415 && pixel_y >= 260 && pixel_y <= 310)||
 //               (pixel_x >= 405 && pixel_x <= 415 && pixel_y >= 320 && pixel_y <= 330)||
            //!
                (pixel_x >= 500 && pixel_x <= 510 && pixel_y >= 270 && pixel_y <= 380)||
                (pixel_x >= 500 && pixel_x <= 510 && pixel_y >= 390 && pixel_y <= 400)
                ) begin
            // Text color (light pink)
            rgb <= {4'hF,4'hF,4'hF}; // High red, green, and blue (light pink)
        end
    end
    // Pixel coordinates for displaying "1" pattern when btn is 1
    else if (away == 1'b1)  begin
        // Conditions for displaying "1" pattern
        // Modify these conditions as needed
        if (    (pixel_x >= 140 && pixel_x <= 150 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 170 && pixel_x <= 180 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 200 && pixel_x <= 210 && pixel_y >= 270 && pixel_y <= 400)||
                (pixel_x >= 140 && pixel_x <= 210 && pixel_y >= 390 && pixel_y <= 400)||
            //I
                (pixel_x >= 230 && pixel_x <= 290 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 230 && pixel_x <= 290 && pixel_y >= 390 && pixel_y <= 400)||
                (pixel_x >= 260 && pixel_x <= 270 && pixel_y >= 280 && pixel_y <= 390)||
            //N
                (pixel_x >= 300 && pixel_x <= 390 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 300 && pixel_x <= 310 && pixel_y >= 280 && pixel_y <= 400)||
                (pixel_x >= 380 && pixel_x <= 390 && pixel_y >= 280 && pixel_y <= 400)||
            //S
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 270 && pixel_y <= 280)||
                (pixel_x >= 410 && pixel_x <= 420 && pixel_y >= 280 && pixel_y <= 330)||
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 330 && pixel_y <= 340)||
                (pixel_x >= 470 && pixel_x <= 480 && pixel_y >= 340 && pixel_y <= 390)||
                (pixel_x >= 410 && pixel_x <= 480 && pixel_y >= 390 && pixel_y <= 400)||
 //           //!
 //               (pixel_x >= 405 && pixel_x <= 415 && pixel_y >= 260 && pixel_y <= 310)||
 //               (pixel_x >= 405 && pixel_x <= 415 && pixel_y >= 320 && pixel_y <= 330)||
            //!
                (pixel_x >= 500 && pixel_x <= 510 && pixel_y >= 270 && pixel_y <= 380)||
                (pixel_x >= 500 && pixel_x <= 510 && pixel_y >= 390 && pixel_y <= 400)
                ) begin
                rgb<={4'hF,4'hF,4'hF};
                end
//        A
            if ((pixel_x >= 130 && pixel_x <= 150 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 190 && pixel_x <= 210 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 150 && pixel_x <= 190 && pixel_y >= 155 && pixel_y <= 175)||
            (pixel_x >= 150 && pixel_x <= 190 && pixel_y >= 80 && pixel_y <= 100)||
//        W
            (pixel_x >= 230 && pixel_x <= 310 && pixel_y >= 230 && pixel_y <= 250)||
            (pixel_x >= 230 && pixel_x <= 250 && pixel_y >= 80 && pixel_y <= 230)||
            (pixel_x >= 260 && pixel_x <= 280 && pixel_y >= 80 && pixel_y <= 230)||
            (pixel_x >= 290 && pixel_x <= 310 && pixel_y >= 80 && pixel_y <= 230)||
//        A
            (pixel_x >= 330 && pixel_x <= 350 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 390 && pixel_x <= 410 && pixel_y >= 80 && pixel_y <= 250)||
            (pixel_x >= 350 && pixel_x <= 390 && pixel_y >= 80 && pixel_y <= 100)||
            (pixel_x >= 350 && pixel_x <= 390 && pixel_y >= 155 && pixel_y <= 175)||
//        Y
            (pixel_x >= 420 && pixel_x <= 440 && pixel_y >= 80 && pixel_y <= 155)||
            (pixel_x >= 500 && pixel_x <= 520 && pixel_y >= 80 && pixel_y <= 155)||
            (pixel_x >= 420 && pixel_x <= 520 && pixel_y >= 155 && pixel_y <= 175)||
            (pixel_x >= 460 && pixel_x <= 480 && pixel_y >= 175 && pixel_y <= 250)
            ) begin
            rgb<={4'hF,4'hF,4'hF};
            end
    end
    else if (tie == 1'b1) begin 
        if (
            (pixel_x >= 80 && pixel_x <= 230 && pixel_y >= 90 && pixel_y <= 110)||
            (pixel_x >= 150 && pixel_x <= 170 && pixel_y >= 110 && pixel_y <= 390)||
        //I
            (pixel_x >= 250 && pixel_x <= 390 && pixel_y >= 90 && pixel_y <= 110)||
            (pixel_x >= 250 && pixel_x <= 390 && pixel_y >= 370 && pixel_y <= 390)||
            (pixel_x >= 310 && pixel_x <= 330 && pixel_y >= 110 && pixel_y <= 370)||
        //E
            (pixel_x >= 410 && pixel_x <= 430 && pixel_y >= 90 && pixel_y <= 390)||
            (pixel_x >= 430 && pixel_x <= 520 && pixel_y >= 90 && pixel_y <= 110)||
            (pixel_x >= 430 && pixel_x <= 520 && pixel_y >= 230 && pixel_y <= 250)||
            (pixel_x >= 430 && pixel_x <= 520 && pixel_y >= 370 && pixel_y <= 390)||
        //!
            (pixel_x >= 540 && pixel_x <= 560 && pixel_y >= 90 && pixel_y <= 350)||
            (pixel_x >= 540 && pixel_x <= 560 && pixel_y >= 370 && pixel_y <= 390)
            )begin
            // Text color (light pink)
           rgb <= {4'hF,4'hF, 4'hF};// High red, green, and blue (light pink)
        end
    
    end                       
end

endmodule
