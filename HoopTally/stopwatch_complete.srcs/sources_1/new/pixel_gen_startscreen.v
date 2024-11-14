module pixel_gen_startscreen(
    input clk_d, // pixel clock
    input [9:0] pixel_x,
    input [9:0] pixel_y,
    input video_on,
    output reg [11:0] rgb = 12'hF00  // Default color is white
);

always @(posedge clk_d) begin
    // Default color (black)
    rgb <= 12'h000; // Default color is white

    // Pixel coordinates for each letter of "PLAYER1" when btn is 0
  
        // Conditions for displaying "PLAYER1" pattern
        // Modify these conditions as needed
        if(
                //H
                (pixel_x>=120 && pixel_x<=140 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=190 && pixel_x<=210 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=140 && pixel_x<=190 && pixel_y>=75 && pixel_y<=95)||
                //O
                (pixel_x>=220 && pixel_x<=240 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=290 && pixel_x<=310 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=240 && pixel_x<=290 && pixel_y>=20 && pixel_y<=40)||
                (pixel_x>=240 && pixel_x<=290 && pixel_y>=170 && pixel_y<=190)||
                //O
                (pixel_x>=320 && pixel_x<=340 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=390 && pixel_x<=410 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=340 && pixel_x<=390 && pixel_y>=20 && pixel_y<=40)||
                (pixel_x>=340 && pixel_x<=390 && pixel_y>=170 && pixel_y<=190)||
                //P 
                (pixel_x>=420 && pixel_x<=440 && pixel_y>=20 && pixel_y<=190)||
                (pixel_x>=490 && pixel_x<=510 && pixel_y>=20 && pixel_y<=95)||
                (pixel_x>=440 && pixel_x<=490 && pixel_y>=20 && pixel_y<=40)||
                (pixel_x>=440 && pixel_x<=490 && pixel_y>=85 && pixel_y<=95)||
                
                //TALLY
                //T
                (pixel_x>=130 && pixel_x<=190 && pixel_y>=200 && pixel_y<=220)||
                (pixel_x>=150 && pixel_x<=170 && pixel_y>=220 && pixel_y<=390)||
                
                //A
                (pixel_x>=210 && pixel_x<=230 && pixel_y>=200 && pixel_y<=390)||
                (pixel_x>=250 && pixel_x<=270 &&  pixel_y>=200 && pixel_y<=390)||
                (pixel_x>=220 && pixel_x<=260 && pixel_y>=200 && pixel_y<=220)||
                (pixel_x>=220 && pixel_x<=260 && pixel_y>=280 && pixel_y<=300)||
                //L
                (pixel_x>=290 && pixel_x<=310 && pixel_y>=200 && pixel_y<=370)||
                (pixel_x>=290 && pixel_x<=350 && pixel_y>=370 && pixel_y<=390)||
                //L
                (pixel_x>=370  && pixel_x<=390 && pixel_y>=200 && pixel_y<=370)||
                (pixel_x>=370 && pixel_x<=430 && pixel_y>=370 && pixel_y<=390)||
                //Y
                (pixel_x>=450 && pixel_x<=470 && pixel_y>=200 && pixel_y<=280)||
                (pixel_x>=490 && pixel_x<=510 && pixel_y>=200 && pixel_y<=280)||
                (pixel_x>=450 && pixel_x<=510 && pixel_y>=280 && pixel_y<=300)||
                (pixel_x>=470 && pixel_x<=490 && pixel_y>=300 && pixel_y<=390)||
               
               
               //S
                (pixel_x>=20 && pixel_x<=80&&pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=20 && pixel_x<=30 && pixel_y>=410 && pixel_y<=425)||
                (pixel_x>=20 && pixel_x<=80 && pixel_y>=425 && pixel_y<=435)||
                (pixel_x>=70 && pixel_x<=80 && pixel_y>=435 && pixel_y<=450)||
                (pixel_x>=20 && pixel_x<=80 && pixel_y>=450 && pixel_y<=460)||
                //T
                (pixel_x>=90 && pixel_x<=130 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=105 && pixel_x<=115 && pixel_y>=410 && pixel_y<=460)||
                //A
                (pixel_x>=140 && pixel_x<=150 && pixel_y>=400 && pixel_y<=460)||
                (pixel_x>=150 && pixel_x<=180 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=150 && pixel_x<=180 && pixel_y>=425 && pixel_y<=435)||
                (pixel_x>=180 && pixel_x<=190 && pixel_y>=400 && pixel_y<=460)||
                //R 
                (pixel_x>=200 && pixel_x<=210 && pixel_y>=400 && pixel_y<=460)||
                (pixel_x>=210 && pixel_x<=250 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=210 && pixel_x<=250 && pixel_y>=425 && pixel_y<=435)||
                (pixel_x>=250 && pixel_x<=260 && pixel_y>=410 && pixel_y<=425)||
                (pixel_x>=250 && pixel_x<=260 && pixel_y>=435 && pixel_y<=460)||
                //T
                (pixel_x>=270 && pixel_x<=310 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=285 && pixel_x<=295 && pixel_y>=410 && pixel_y<=460)||
                
                //G
                (pixel_x>=380 && pixel_x<=430 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=380 && pixel_x<=430 &&  pixel_y>=450 && pixel_y<=460)||
                (pixel_x>=380 && pixel_x<=390 && pixel_y>=410 && pixel_y<=450)||
                (pixel_x>=420 && pixel_x<=430 && pixel_y>=435 && pixel_y<=450)||
                (pixel_x>=400 && pixel_x<=430 && pixel_y>=425 && pixel_y<=435)||
                
                //A
                (pixel_x>=450 && pixel_x<=460 && pixel_y>=400 && pixel_y<=460)||
                (pixel_x>=460 && pixel_x<=480 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=460 && pixel_x<=480 && pixel_y>=425 && pixel_y<=435)||
                (pixel_x>=480 && pixel_x<=490 && pixel_y>=400 && pixel_y<=460)||
                //M
                (pixel_x>=500  && pixel_x<=560 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=500 && pixel_x<=510 && pixel_y>=410 && pixel_y<=460)||
                (pixel_x>=525 && pixel_x<=535 && pixel_y>=410 && pixel_y<=460)||
                (pixel_x>=550 && pixel_x<=560 && pixel_y>=410 && pixel_y<=460)||
                //E
                (pixel_x>=570 && pixel_x<=580 && pixel_y>=400 && pixel_y<=460)||
                (pixel_x>=580 && pixel_x<=620 && pixel_y>=400 && pixel_y<=410)||
                (pixel_x>=580 && pixel_x<=620 && pixel_y>=425 && pixel_y<=435)||
                (pixel_x>=580 && pixel_x<= 620 && pixel_y>=450 && pixel_y<=460)
                )begin
            // Text color (light pink)
            rgb <= {4'hF,4'hF, 4'hF}; // High red, green, and blue (light pink)
        end
    
    // Pixel coordinates for displaying "1" pattern when btn is 1
   
    
end

endmodule
