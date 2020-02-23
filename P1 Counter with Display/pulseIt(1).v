`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <makePulse.v>                                      // 
//  Abstract: Make a pulse every 10ms.       	                  // 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//

module makePulse(clk, rst, pulse);
	input			 clk, rst;
	output 		 pulse;
	reg 	[19:0] count;		//20 bit count
		
	assign pulse = (count == 999999);
	
	always @ (posedge clk, posedge rst)
		if(rst) 	count <= 20'b0;	
	else
		if(pulse) count <= 20'b0; 
	else
		count<= count + 20'b1;
endmodule
