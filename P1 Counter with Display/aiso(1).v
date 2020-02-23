`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <aiso.v>                                           // 
//  Abstract: Support timing constraints that are violated.		   // 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//

module aiso(clk,rst, rst_sync);
	input clk, rst;
	output rst_sync;
	wire rst_sync;
	reg f1, f2;

	always @ (posedge clk, posedge rst)
		begin
		if (rst)
			{f1,f2} <= 2'B00;
		else
			{f1,f2} <= {1'b1,f1};
		end
	assign rst_sync = !f2;
endmodule 
