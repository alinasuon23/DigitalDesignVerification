`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <ledController.v>                                  // 
//  Abstract: This module has an input clk because at the posedge //
//					of clk, our moore FSM increment to next state 		//
//					regardless of the value. The output will be in 		//
//					relation to the analog pins {a7-a0} and the 			//
//					present state {seqSel}. Pixels are on from right 	//
//					to left of the display.										//
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module ledController(clk, rst, a, seqSel);
   input                clk, rst;
   output  reg    [7:0] a;
   output  reg    [2:0] seqSel;
   
//State register and next state  
   reg            [2:0] q;     //present state
   reg            [2:0] d;     //next state
	
//Next state combinational logic
   always @(q) begin
      case(q)
         3'b000:     d = 3'b001;
         3'b001:     d = 3'b010;
         3'b010:     d = 3'b011;
         3'b011:     d = 3'b100;
         3'b100:     d = 3'b101;
         3'b101:     d = 3'b110;
         3'b110:     d = 3'b111;
         3'b111:     d = 3'b000;
         default     d = 3'b000;
      endcase
   end
	
//State register sequential logic  
   always @ (posedge clk, posedge rst)
		begin
			if(rst == 1'b1)
				q <= 3'b000;
			else 
				q <= d;
		end
		
//Output Combinational Logic
   always @(q) 
		begin
			case(q)
				3'b000:     {a, seqSel} = 11'b01111111_000;
				3'b001:     {a, seqSel} = 11'b10111111_001;
				3'b010:     {a, seqSel} = 11'b11011111_010;
				3'b011:     {a, seqSel} = 11'b11101111_011;
				3'b100:     {a, seqSel} = 11'b11110111_100;
				3'b101:     {a, seqSel} = 11'b11111011_101;
				3'b110:     {a, seqSel} = 11'b11111101_110;
				3'b111:     {a, seqSel} = 11'b11111110_111;
				default:    {a, seqSel} = 11'b11111111_000;
			endcase
   end
endmodule
