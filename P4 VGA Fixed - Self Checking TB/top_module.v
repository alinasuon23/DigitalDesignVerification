//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project2-Cecs361													//
//																						//				
//  File name: <top_module.v>                                     // 
//  Abstract:   This module instantiates all the modules and assign //
//			     the required rgb signal.										// 
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
module top_module(clk, rst, hsync, vsync, rgb);
   // Inputs
   input         clk, rst;
   
   // Outputs
   output        hsync, vsync;
   output [11:0] rgb;
   
   // Wires
   wire          video_on;
   wire   [9:0]  pxlx;
   wire   [9:0]  pxly;
   wire   [11:0] rgb_next;
   
   // Instantiations
   vga_sync   u0(.clk(clk),
                 .rst(rst),
                 .hsync(hsync),
                 .vsync(vsync),
                 .pixel_x(pxlx),
                 .pixel_y(pxly),
                 .video_on(video_on)
                 );
                 
    
    pixel_gen u1(.pixel_x(pxlx),
                 .pixel_y(pxly),
                 .video_on(video_on),
                 .rgb(rgb)
                 );

endmodule
