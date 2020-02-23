`timescale 1ns / 1ps
//****************************************************************// 
//  Class: CECS 361 						                          		//
//  Project: Project1-Cecs361													//
//																						//				
//  File name: <debounce.v>                                       // 
//  Abstract: Debounce will stabilize the output to show only the //
// 				necessary transitions. 										//
// 			 	Reference to Pong Chu's Debounce                   // 
//  Created by       <Alina Suon> on <09-18-18>.                  // 
//  Copyright © 2018 <Alina Suon>. All rights reserved.           // 
//                                                                //                                                                              // 
//  In submitting this file for class work at CSULB               // 
//  I am confirming that this is my work and the work             // 
//  of no one else. In submitting this code I acknowledge that    // 
//  plagiarism in student project work is subject to dismissal.   //  
//  from the class                                                // 
//****************************************************************//

module debounce(clk, rst, sw, db);
	input wire clk, rst;
	input wire sw;
	output reg db;
	
	makePulse makePulse(clk, rst, pulseIt);
	
//makePulse		P1 (clk, rst, pulse);
	localparam [2:0]
				zero0	  = 3'b000,
				s1_01 = 3'b001,
				s1_10 = 3'b010,
				s1_11 = 3'b011,
				one1 	  = 3'b100,
				s0_01 = 3'b101,
				s0_10 = 3'b110,
				s0_11 = 3'b111;

//Counter bit = 20 to get 10ms tick 
	localparam n = 20; 

//Declare signals
		reg [n-1:0] qReg;
		wire [n-1 : 0] q_ns ;
		wire pulse;
		reg [2:0] stateReg , stateNS ;

//10ms tick Counter
	always @ (posedge clk, posedge rst)
		if (rst)
			qReg <= 0;
		else
			qReg <= q_ns;

//q next state
	assign q_ns = qReg + 1;

//Output pulse / tick
	assign pulse = (qReg == 0) ? 1'b1 : 1'b0;

// Finite state machine //
// State register
	always @ ( posedge clk , posedge rst)
		if (rst)
			stateReg <= zero0;
		else
			stateReg <= stateNS ;
			
	// next-state logic and output logic
	always @ (*)
		begin
			stateNS = stateReg; 	// default state: same state
			db = 1'b0; 					// default output: 0
			
	//Case statement
	case (stateReg)
		zero0:
				if(sw)
					stateNS = s1_01;
					s1_01:
				if(~sw)
					stateNS = zero0;
				else
					if(pulse)
					stateNS = s1_10;
		s1_10:
				if(~sw)
					stateNS = zero0;
				else
					if (pulse)
					stateNS = s1_11;
		s1_11:
				if(~sw)
					stateNS = zero0; 
				else
					if (pulse)
					stateNS = one1;
		one1:
				begin
				db = 1'b1;
				if (~sw)
					stateNS = s0_01;
				end
		s0_01:
				begin
				db = 1'b1;
				if (sw)
					stateNS = one1;
				else
					if (pulse)
					stateNS = s0_10;
				end
		s0_10:
				begin
				db = 1'b1;
				if (sw)
					stateNS = one1;
				else
					if (pulse)
					stateNS = s0_11;
				end
		s0_11:
				begin
				db = 1'b1;
				if (sw)
					stateNS = one1;
				else
					if (pulse)
					stateNS = zero0;
				end				
		default: stateNS = zero0;
		endcase
		end
endmodule 