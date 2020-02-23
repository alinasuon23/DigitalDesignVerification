`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <displayController.v>                              // 
//  Abstract: This module instantiates the modules required for	//
//					the 7 segment display.										//
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module displayController(clk, rst, anode, seg, a, b, c, d, e, f, g);
   input clk, rst;
   input [31:0] seg;
   output [7:0] anode;
   output a, b, c, d, e, f, g; 
   wire ledCout;
   wire [2:0] sel;
   wire [3:0] y;
 //Instantiate modules for 7 seg display  
   ledClk  			a1 (clk, rst, ledCout);            
   ledController  a2	(ledCout, rst, anode, sel);                    
   adMux 			a3 (sel, seg[31:28], seg[27:24], seg[23:20],  
							  seg[19:16], seg[15:12], seg[11:8], 
							  seg[7:4], seg[3:0], y);   
   hex7seg 			a4 (y, a, b, c, d, e, f, g);
endmodule
 
