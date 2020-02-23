//****************************************************************// 
//  Class: CECS 361 						                          		//
//																						//				
//  File name: <pixel_gen2.v>                                    // 
//  Abstract:  Pixel generator specify parameters and colors of 	//
//					elements on monitor and it's functions					//
//																	               //
//  Created by       <Alina Suon> on <11-29-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
`timescale 1ns / 1ps
module pixel_gen2(clk, reset, video_on, btn, pix_x, pix_y, graph_rgb);
   
   // Inputs
   input wire clk, reset, video_on;
   input wire [1:0] btn;
   input wire [9:0] pix_x, pix_y;
   
   // Output
   output reg [11:0] graph_rgb;
   
   // Wires
   wire refr_tick;
   wire [9:0] bar_y_t, bar_y_b;
   wire [9:0] ball_x_l, ball_x_r;
   wire [9:0] ball_y_t, ball_y_b;
   wire [9:0] ball_x_next, ball_y_next;
   wire [2:0] rom_addr, rom_col;
   wire       rom_bit;
   wire       wall_on,  bar_on , sq_ball_on, rd_ball_on;
   wire [11:0] wall_rgb, bar_rgb,  ball_rgb;
   
   // Regs
   reg [9:0] ball_x_reg, ball_y_reg, bar_y_reg, bar_y_next;
   reg [9:0] x_delta_reg, x_delta_next;
   reg [9:0] y_delta_reg, y_delta_next;
   reg [7:0] rom_data;
   
   // Localparams
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
   localparam WALL_X_L = 32;
   localparam WALL_X_R = 35;
   localparam BAR_X_L = 600;
   localparam BAR_X_R = 603;
   localparam BAR_Y_SIZE = 200;
   localparam BAR_V = 7;
   localparam BALL_SIZE = 8;
   localparam BALL_V_P = 3.5;
   localparam BALL_V_N = -3.5;
   
   // 
  
   
   // Round Ball Image
   always @ (*)
      case(rom_addr)
         3'h0: rom_data = 8'b00111100; // ****
         3'h1: rom_data = 8'b01111110; // *****
         3'h2: rom_data = 8'b11111111; // 
         3'h3: rom_data = 8'b11111111; // 
         3'h4: rom_data = 8'b11111111; //
         3'h5: rom_data = 8'b11111111; //
         3'h6: rom_data = 8'b01111110; //
         3'h7: rom_data = 8'b00111100; //
      endcase
   
    // Registers
    always @ (posedge clk, posedge reset)
      if(reset)
         begin
            bar_y_reg <= 0;
            ball_x_reg <= 0;
            ball_y_reg <= 0;
            x_delta_reg <= 10'h004;
            y_delta_reg <= 10'h004;
            
         end
      else
         begin
           bar_y_reg <= bar_y_next;
            ball_x_reg <= ball_x_next;
            ball_y_reg <= ball_y_next;
            x_delta_reg <= x_delta_next ;
            y_delta_reg <= y_delta_next ;
         end   
   
   
   assign refr_tick = (pix_y == 481) && (pix_x == 0);
   assign wall_on = (WALL_X_L <= pix_x) && (pix_x <= WALL_X_R);
   assign wall_rgb = 12'h800; 
   assign bar_y_t = bar_y_reg;
   assign bar_y_b = bar_y_t + BAR_Y_SIZE - 1;
   assign bar_on = (BAR_X_L <= pix_x) && (pix_x <= BAR_X_R) &&
                   (bar_y_t <= pix_y) && (pix_y <= bar_y_b);  
  
   assign bar_rgb = 12'h080;  
   
   // New Bar y-position
   always @ (*)
      begin
         bar_y_next = bar_y_reg;
            if (refr_tick)
               if(btn[1] & (bar_y_b < (MAX_Y - 1 -BAR_V)))
                  bar_y_next = bar_y_reg + BAR_V;
                  
            else if (btn[0] & (bar_y_t > BAR_V))
                  bar_y_next = bar_y_reg - BAR_V;
      end
   
   
   
   assign ball_x_l = ball_x_reg;
   assign ball_y_t = ball_y_reg;
   assign ball_x_r = ball_x_l + BALL_SIZE - 1;
   assign ball_y_b = ball_y_t + BALL_SIZE - 1;
   
   assign sq_ball_on = (ball_x_l <= pix_x) && (pix_x <= ball_x_r) &&
                       (ball_y_t <= pix_y) && (pix_y <= ball_y_b);
   
   assign rom_addr = pix_y[2:0] - ball_y_t[2:0];
   assign rom_col = pix_x[2:0] - ball_x_l[2:0];
   assign rom_bit = rom_data[rom_col];
   
   assign rd_ball_on =  sq_ball_on & rom_bit;
   assign ball_rgb = 12'h008; 
   assign ball_x_next = (refr_tick) ? ball_x_reg + x_delta_reg:
                                      ball_x_reg;
   assign ball_y_next = (refr_tick) ? ball_y_reg + y_delta_reg:
                                      ball_y_reg;
                                      
   // New Ball Velocity 
   always @ (*)
      begin
         x_delta_next = x_delta_reg;
         y_delta_next = y_delta_reg;
         if (ball_y_t < 1)
            y_delta_next = BALL_V_P;
            
         else if (ball_y_b > (MAX_Y-1))
            y_delta_next = BALL_V_N;
            
         else if (ball_x_l <= WALL_X_R)
            x_delta_next = BALL_V_P;
            
         else if ((BAR_X_L <= ball_x_r) && (ball_x_r <= BAR_X_R) &&
                  (bar_y_t <= ball_y_b) && (ball_y_t <= bar_y_b))
            x_delta_next = BALL_V_N;
      end
      
      
    always @ (*)
      if (~video_on)
         graph_rgb = 12'h000; 
      else
         if(wall_on)
            graph_rgb = wall_rgb;
         else if (bar_on)
            graph_rgb = bar_rgb;
         else if (rd_ball_on)
            graph_rgb = ball_rgb;
         else
            graph_rgb = 12'hFFF; 
     
endmodule
