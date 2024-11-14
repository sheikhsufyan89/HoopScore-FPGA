module top_endscreen(
    input clk_100MHz,
    input enable,
    input result,
    input home,
    input away, 
    input tie,
    output [11:0] rgb, 
    output hsync,
    output vsync
);



wire [9:0] w_x, w_y;
wire video_on, p_tick;


vga_controller vga(
    .clk_100MHz(clk_100MHz),
    .reset(reset),
    .video_on(video_on),
    .hsync(hsync),
    .vsync(vsync),
    .p_tick(p_tick),
    .x(w_x),
    .y(w_y)
    );



pixel_endscreen pixel_gen_inst(clk_100MHz, w_x, w_y, video_on, result, home, away, tie, rgb);


endmodule
