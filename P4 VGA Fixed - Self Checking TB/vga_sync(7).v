//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project2-Cecs361													//
//																						//				
//  File name: <vga_sync.v>                                       // 
//  Abstract:  Sets all the x and y parameters inside the monitor, //
//          and variables that will ensure the designated areas   //
//          within the x and y parameters are displayable         //
//          (i.e. video_on, horizontal_video_on, h_count, v_count,//
//          vertical_video_on,  pixel_x, pixel_y, hysnc,          //
//          and vsync).Sends pixel indication signals to the pixel//
//          generation module to identity which colors should be  //
//          displayed on the monitor. The hysnc and vsync         //
//          variables are the only variables in this module that  //
//          are sent directly to the monitor.       					//
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
module vga_sync(clk, rst, hsync, vsync, pixel_x, pixel_y, video_on);
   // Inputs
   input        clk, rst;
   
   // Outputs
   output       hsync, vsync, video_on;
   output [9:0] pixel_x, pixel_y;
   
   // Regs
   reg    [9:0] h_count, v_count;
   reg    [1:0] count;


   // Generate 25MHz tick
   // (1/25MHz) = 40ns/10ns = 4 counts
   // Only high when count = 3 (25MHz)

   assign tick = (count == 3); 
   always @ (posedge clk, posedge rst)
      if(rst) count <= 0; else
      if(tick)count <= 0; else
      count <= count + 2'b1;
      
   // Set Horizontal scan count
   // Range from 0-799 (800)
   // h_end is when the horizontal count should end
   // h_count tells where the x value is at
   assign h_end = (h_count == 10'd799); 
   always @ (posedge clk, posedge rst)  
      if(rst) h_count <= 0; else        
      if(tick)
         if (h_end)h_count <= 0; else
         h_count <= h_count + 10'b1;
         
         
   // Low Active (Negative logic)
   // Set Horizontal Sync Signal
   // Range from 656-751
   assign hsync = ~((h_count >= 656) & (h_count <= 751));
 
      
   // Set Vertical scan count
   // Range from 0-524 (525)
   // v_end is when the horizontal count should end
   assign v_end = (v_count == 10'd524);
      always @ (posedge clk, posedge rst)
         if(rst) v_count <= 0; else
         if(tick)
            if (h_end)
               if (v_end)v_count <= 0; else
               v_count <= v_count + 10'b1;
  
  // Low Active (Negative logic)
  // Set Vertical Sync Signal 
  // Range from 490-491
  assign vsync = ~((v_count >= 490) & (v_count <= 491));  
  
  // Assign
  assign pixel_x = h_count;
  assign pixel_y = v_count;
  
  // Vertical_video_on is high active
  // Active from Vertical scan count (0-479)
  assign vertical_video_on = ((v_count >= 0) & (v_count <= 479));
  
  // Horizontal_video_on is high active
  // Active from Horizontal scan count (0-639)
  assign horizontal_video_on = ((h_count  >=0) & (h_count <= 639));
  
  // Video_on is high active
  // Active when horizontal and vertical videos are on
  assign video_on = horizontal_video_on  & vertical_video_on;

      

endmodule
