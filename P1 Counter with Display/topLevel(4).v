`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <topLevel.v>                                       // 
//  Abstract: The top level module purpose is to instantiate all  //
//       	  the modules.	    		                              // 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module topLevel(clk, rst, inc, uphdnl, anode, a, b, c, d, e, f, g);
	 input  		   clk, rst, inc, uphdnl;
	 output [7:0]  anode; 					//8 bit anode
	 output 		   a, b, c, d, e, f, g;
	 wire   [31:0] q; 						//32 bit q
	 wire   			PED;
	 wire   			rst_o;
	 wire   			deb; 

//Instantiate modules
	 debounce
		debounce	(clk, rst_o, inc, deb);
	 aiso
		aiso		(clk, rst, rst_o);		
	 PED 
		ped		(clk, rst_o, deb, PED);
	 counter
		counter	(clk, rst_o, PED, uphdnl, q);
	 displayController 
		dc			(clk, rst_o, anode, q, a, b ,c ,d ,e, f,g);
endmodule
