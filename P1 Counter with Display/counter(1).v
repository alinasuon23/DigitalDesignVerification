`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <counter.v>                                        // 
//  Abstract: Will increment / decrement based on the switch 		//
//					uphdnl. 															// 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module counter(clk, rst, incr, uphdnl, q);
	input 		  clk, rst;
	input 		  uphdnl, incr;
	output [15:0] q;
	reg 	 [15:0] q;
	
	always @(posedge clk, posedge rst)
		if (rst) q <= 8'b0;
		else if (incr) q <= (uphdnl)? q + 16'b1 : q - 16'b1;
endmodule
