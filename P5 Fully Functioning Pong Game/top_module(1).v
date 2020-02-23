//****************************************************************// 
//  Class: CECS 361 						                          		//
//																						//				
//  File name: <top_module.v>                                     // 
//  Abstract: Instantiation of modules to create pong game		   //
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
module top_module(clk, rst, btnup, btndn, hsync, vsync, rgb);
   // Inputs
   input         clk,rst;
   input         btnup, btndn;
   
   // Outputs
   output        hsync, vsync;
   output [11:0] rgb;
   
   // Wires
   wire          Rg_Sync, video_on;
   
   wire          btnup, btndn;
   wire   [9:0]  pxlx;
   wire   [9:0]  pxly;
 
   
  
  
   
   
   // Instantiations
   vga_sync   u0(.clk(clk),
                 .rst(Rg_Sync),
                 .hsync(hsync),
                 .vsync(vsync),
                 .pixel_x(pxlx),
                 .pixel_y(pxly),
                 .video_on(video_on)
                 );
                 
    
 
    pixel_gen2 u1(.clk(clk),
                  .reset(Rg_Sync),
                  .video_on(video_on),
                  .btn({btnup,btndn}),
                  .pix_x(pxlx),
                  .pix_y(pxly),
                  .graph_rgb(rgb) 
                 );
                 
     //clk,rst, Rg_Sync
     
     AISO      u2(.clk(clk),
                  .rst(rst),
                  .Rg_Sync(Rg_Sync)
                  );
                  
    
            
  

endmodule
