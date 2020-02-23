//****************************************************************// 
//  Class: CECS 361 						                          		//
//																						//				
//  File name: <top_mod3_tf.v>  		                              // 
//  Abstract:  Test fixture checks the functionality of the top	//
//					level module. It will predict the future output and//
//					if any disrepancies, report it to the user.			//
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

module top_mod3_tf;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire hsync;
	wire vsync;
	wire [11:0] rgb;
   wire [9:0]pixel_x; //h_count
   wire [9:0]pixel_y; //v_count

	// Instantiate the Unit Under Test (UUT)
	top_module uut 
   (
		.clk(clk), 
		.rst(rst), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);
   
   assign pixel_x = uut.u1.pixel_x; 
   assign pixel_y = uut.u1.pixel_y; 
   assign video_on = uut.u1.video_on;

   always #5 clk = ~clk;
   
   always @ (posedge clk, posedge rst)
      //$display("pixelx = %d         pixely = %d", uut.u1.pixel_x, uut.u1.pixel_y, rgb);
      begin 
      
         // Checking the bar
         if( (video_on)       && (pixel_x >= 600)  && (pixel_x <= 603 ) &&
             (pixel_y >= 204) && (pixel_y <= 276 ) && (rgb !=12'h00F) )
             $display("pixelx = %d  pixely = %d  rgb = %h", pixel_x, pixel_y, rgb );
             else
          
         // Checking the ball
         if( (video_on)       && (pixel_x >= 580)  && (pixel_x <= 588 ) &&
             (pixel_y >= 238) && (pixel_y <= 246 ) && (rgb !=12'h0F0) )
             $display("pixelx = %d  pixely = %d  rgb = %h", pixel_x, pixel_y, rgb );
             else    

         // Checking the wall
         if( (video_on) && (pixel_x >= 32)  && (pixel_x <= 35  ) && (rgb !=12'hF00) )
              $display("pixelx = %d  pixely = %d rgb = %h", pixel_x, pixel_y, rgb  );    
               
      
      
      end 
      
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
        
		// Add stimulus here

	end
      
endmodule

