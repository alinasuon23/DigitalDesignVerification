//****************************************************************// 
//  Class: CECS 361 						                          		//
//																						//				
//  File name: <AISO.v>  		                                    // 
//  Abstract:  AISO will manage the violations of clock like it's //
//					timing constraints. When reset it will reset all	//
//			design logic. When reset is one the clock is asynchronous//
//			due to not being in line with the clock.						//
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
module AISO(clk,rst, Rg_Sync);
   // Input
	input       clk, rst;
   
   // Output 
	output      Rg_Sync;
   
   // Wire and Reg
   wire        Rg_Sync;
	reg         f1, f2;

	always @ (posedge clk, posedge rst) begin
		if (rst)
			{f1,f2} <= 2'B00;
         
		else
			{f1,f2} <= {1'b1,f1};
         
		end

		assign Rg_Sync = !f2;


endmodule
