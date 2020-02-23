//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project2-Cecs361													//
//																						//				
//  File name: <pixel_gen.v>                                      // 
//  Abstract:  Designates what pin will output a certain color and //
//          creates fixed objects that will be allocated that     // 
//          certain color. In addition, it sets the ranges of the //
//          fixed objects that will be displayed when the video   //
//          is on.(i.e. wall, ball, bar).                         //
//																	               //
//  Created by       <Alina Suon> on <10-29-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB                // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
`timescale 1ns / 1ps
module pixel_gen(video_on, pixel_x, pixel_y, rgb);
   // Input
   input  wire      video_on;
   input      [9:0]  pixel_x, pixel_y;
   
   // Outputs
   output reg [11:0] rgb;
   
   // Wires
   wire       [9:0]  h_count, v_count;    
   wire       [11:0] wall_rgb, ball_rgb, bar_rgb;

      
         
   // Assign the objects to occupy the given regions
   // in the horizontal scan count and vertical scan count
   assign wall_rgb = 12'hF00; // red
   assign ball_rgb = 12'h0F0; // green
   assign bar_rgb  = 12'h00F; // blue
   
   
   assign h_count = pixel_x;
   assign v_count = pixel_y;
   
   assign wall = ( (h_count >= 32) && (h_count <= 35  )  );
   
   assign bar  = ( (h_count >= 600)&& (h_count <= 603 ) &&
                   (v_count >= 204)&& (v_count <= 276 )  );
                              
   assign ball = ( (h_count >= 580)&& (h_count <= 588 ) &&
                   (v_count >= 238)&& (v_count <= 246 )  );
   
   // Set the display 
   always @ (*)
      if(~video_on)
         rgb = 12'h000; else
         if(wall)rgb = wall_rgb; else
         if(bar )rgb = bar_rgb; else
         if(ball)rgb = ball_rgb;  else
         rgb = 12'hFFF;
           
         
endmodule
