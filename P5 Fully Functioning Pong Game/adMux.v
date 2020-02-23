`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <adMux.v>                                          // 
//  Abstract: An 8 to 1 mux that has a select of 3 bits.				//
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module adMux(seqSel, d0, d1, d2, d3, d4, d5, d6, d7, y); 
	input [2:0]   seqSel;
   input [15:12] d0;  
   input [11:8]  d1;  
   input [7:4]   d2;  
   input [3:0]   d3;  
   input [15:12] d4;  
   input [11:8]  d5;  
   input [7:4]   d6;    
   input [3:0]   d7;       
	output[3:0]   y;     //y = output to the hex7seg  
	reg   [3:0]   y;
   
   always @(*) begin
      case(seqSel)
         3'b000: y = d0;
         3'b001: y = d1;
         3'b010: y = d2;
         3'b011: y = d3;
         3'b100: y = d4;    
         3'b101: y = d5;    
         3'b110: y = d6;
         3'b111: y = d7;
      endcase
   end 
endmodule
