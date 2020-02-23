`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <ledClk.v>                                         // 
//  Abstract: Int count determines frequency of clkOut. So count  //
//					=(Incoming Freq/(Outgoing Freq))/2. ClkIn (100Mhz) //
//					alternates 'count' in which clkOut will also    	//
//					alternates. We want an output of 480hz frequency	//
//					to have a rate of 60Hz refresh. Determined by 		//
//					Outgoing Freq = (Refresh Rate * Number of Pixels). //
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module ledClk(clk, rst, ledClk);
   input  clk, rst;
   output ledClk;
   reg    ledClk;
   integer clkTick;
   
   always @(posedge clk, posedge rst) 
		begin
			if(rst == 1'b1) 
				begin
					clkTick = 0;
					ledClk   = 0;
				end
//see clock, incr counter, check if half period past
			else 
				begin
					clkTick = clkTick + 1;
//Produce 480Hz output clock by using 104166	
					if (clkTick >= 104166) 
						begin 
							ledClk = ~ledClk;
							clkTick = 0;
						end
				end
		end
endmodule
