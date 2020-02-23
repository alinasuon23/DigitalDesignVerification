`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <testbench.v>                                      // 
//  Abstract: Test fixture														//
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//

module testbench;
	// Inputs
	reg clk;
	reg reset;
	reg inc;
	reg uphdnl;
	// Outputs
	wire [7:0] anode;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
// Instantiate the Unit Under Test (UUT)
	Top_Level uut (.clk(clk), .reset(reset), .inc(inc), 
						.uphdnl(uphdnl), .anode(anode), .a(a), 
						.b(b), .c(c), .d(d), .e(e), .f(f), .g(g));
	always #5 clk= ~clk;
	initial
	begin
// Initialize Inputs
		clk = 0;
		reset = 1;
		inc = 0;
		uphdnl = 0;
// Wait 100 ns for global reset to finish
		#100 reset = 0;     
// Add stimulus here
		#100 inc = 1;
	end
endmodule

