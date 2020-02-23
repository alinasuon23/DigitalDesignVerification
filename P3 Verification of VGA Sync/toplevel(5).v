`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project3-Cecs361													//
//																						//				
//  File name: <topLevel.v>                                       // 
//  Abstract: The top level will instatntiate vga_sync. 				// 
//  Created by       <Alina Suon> on <10-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module topLevel(input wire clk, input wire rst, input wire [11:0] rgb_in,
					 output wire hSync, output wire vSync,
					 output wire [11:0] rgb_out);
		
		wire v_ON;
	   reg [11:0] rgb_reg;
	
		// ( clk, rst, hSync, vSync, v_ON);	  
		vga_sync v1(.clk(clk), .rst(rst),
						.hSync(hSync), .vSync(vSync), 
						.v_ON(v_ON), .p_x(), .p_y());

// For the switches and Display
always @(posedge clk, posedge rst)
	if(rst)
		rgb_reg <= 12'b0; 
	else		
      rgb_reg <= rgb_in;
		  
assign rgb_out = (v_ON) ? rgb_reg : 12'b0;

endmodule
