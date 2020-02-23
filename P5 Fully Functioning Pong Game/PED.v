`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <PED.v>                                            // 
//  Abstract: This module will detect the positive edge of the 	//
//					clock specifically as an output. The output			//
//					can only change on the positive edge dectect.   	// 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module PED(clk, rst, d, PED);
	input 	clk, rst, d;
	output	PED;
	wire 		PED;
	reg 		f1;
	
	always @ (posedge clk, posedge rst) 
	begin
		if (rst) 
			f1 <= 1'b00; 
		else
			f1 <= d;			
	end
	assign PED = {~f1 & d};		
endmodule

