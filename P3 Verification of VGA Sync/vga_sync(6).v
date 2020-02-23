`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project3-Cecs361													//
//																						//				
//  File name: <vga_sync.v>                                        // 
//  Abstract: The VGA screen will have a 25Mhz pizel rate. This   //	
//				  module will have hsync and vsync to scan eac row    //
//				  and the whole screen											// 
//  Created by       <Alina Suon> on <10-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//
module vga_sync (input clk, input rst, output wire hSync,
					  output wire vSync, output v_ON,
					  output wire [9:0] p_x, p_y); 
					  
	reg [1:0] clk_count;
	wire utick;
					  
	//Sourced from PongChu: VGA constants and 640x480 parameters
	localparam  HD = 640, HF = 48,  HB = 16,
					HR = 96,  VD = 480, VF = 10,
					VB = 33,	 VR = 2;
	
	//The VGA Sync is updated to 25Mhz rate	 
	assign utick = clk_count == 2'b11;
	
	always @(posedge clk, posedge rst)
		if (rst) clk_count <= 2'b0; 
		else if 
			(utick) clk_count <= 2'b0;
		else
			clk_count <= clk_count + 2'b1;

	//sync counters
	reg [9:0] hCount_reg, hCount_next;
	reg [9:0] vCount_reg, vCount_next;
	
	//output
	reg vSync_reg, hSync_reg;
	wire vSync_next, hSync_next;
	
	//status signal
	wire hEnd, vEnd;
	
	//registers
	always @(posedge clk, posedge rst)
		if (rst) 
			begin
			vCount_reg <= 0;
			hCount_reg <= 0;
			vSync_reg <= 1'b0;
			hSync_reg <= 1'b0;
			end
		else 
			begin
			vCount_reg <= vCount_next;
			hCount_reg <= hCount_next;
			vSync_reg <= ~ vSync_next;
			hSync_reg <= ~ hSync_next;
			end
	
	//Mod800 Counter (HD + HF + HB + HR = 800)
	assign hEnd = (hCount_reg == (HD + HF + HB + HR - 1));

	//Hsync update rate - 25Hz
	always @(*)
		if (utick)  
			if (hEnd)  
				hCount_next = 0;
			else
				hCount_next = hCount_reg + 10'b1;
		else
			hCount_next = hCount_reg;
		
	//Mod525 Counter (VD + VF + VB + VR = 525)
	assign vEnd = (vCount_reg == (VD + VF + VB + VR - 1));	

	//The vCount updates after horizontal scan
	always @(*)
		if (utick)
			if (hEnd)
				if (vEnd) 
					vCount_next = 10'b0; 
				else
					vCount_next = vCount_reg + 10'b1;
			else
				vCount_next = vCount_reg;
		else
			vCount_next = vCount_reg;

	//Hsync = low active and horizontal scan (HD + HB = 656 & HD + HB + HR = 752)
	assign hSync_next = (hCount_reg >= (HD + HB) &&
								 hCount_reg <= (HD + HB + HR - 1));

	//Vsync low active (VD + VF = 490 &	VD + VF + VR = 492)
	assign vSync_next = (vCount_reg >= (VD + VF) &&
								vCount_reg <= (VD + VF + VR - 1));
	
	//video on/off
	assign v_ON = (hCount_reg < HD) && (vCount_reg < VD);
	
	//Output the signal
	assign hSync = hSync_reg;
	assign vSync = vSync_reg;
	assign p_x = hCount_reg;
	assign p_y = vCount_reg;
	
endmodule
