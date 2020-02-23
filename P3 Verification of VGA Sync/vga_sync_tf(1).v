`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project3-Cecs361													//
//																						//				
//  File name: <vga_sync_tf.v>                                    // 
//  Created by       <Alina Suon> on <10-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module vga_sync_tf;
	// Inputs
	reg clk;
	reg rst;
	reg [11:0] rgb_in;
	// Outputs
	wire hSync;
	wire vSync;
	wire v_ON;
	wire utick;
	wire [9:0] p_x;
	wire [9:0] p_y;
	wire [11:0] rgb_out;

	// Instantiate the Unit Under Test (UUT)
	vga_sync uut (.clk(clk), .rst(rst), .hSync(hSync), 
					  .vSync(vSync), .v_ON(v_ON), .utick(utick), 
					  .p_x(p_x), .p_y(p_y), .rgb_in(rgb_in), 
					  .rgb_out(rgb_out));
					  
always #5 clk =~clk;
	initial begin
		clk = 0;
		rgb_in = 12'b1;
		rst = 1;
	
		#100;		
		rst = 0;
	end
     
endmodule

