`timescale 1ns / 1ps

`define SIMULATION


module wb_BCD_tb;

  
   reg clk;
   reg  reset;
	// Wishbone interface
	reg              bcd0_stb;
	reg              bcd0_cyc;
	wire             bcd0_ack;
	reg              bcd0_we;
	reg       [31:0] bcd0_adr;
	reg        [3:0] bcd0_sel;
	reg       [31:0] bcd0_dat;	
        wire  [31:0] wb_dat_o;
	wire [6:0] seg_out;
	wire [3:0] an_out;

  wb_BCD uut (
	.clk(      clk          ),
	.reset(    reset          ),
	//
	.wb_adr_i( bcd0_adr    ),
	.wb_dat_i( bcd0_dat  ),
	.wb_stb_i( bcd0_stb    ),
	.wb_cyc_i( bcd0_cyc    ),
	.wb_we_i(  bcd0_we     ),
	.wb_ack_o( bcd0_ack    ), 
	.wb_sel_i( bcd0_sel    ),
        .wb_dat_o(wb_dat_o),
	.seg_out(seg_out),
	.an_out(an_out)
	
);


   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;
   reg [20:0] i;
   event reset_trigger;




   initial begin  // Initialize Inputs
      clk = 0; reset = 1; 
   end

   initial  begin  // Process for clk
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end

   initial begin // Reset the system, Start the image capture process
      forever begin 
        @ (reset_trigger);
 
				// stimulus here

       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end

	bcd0_adr = 32'h04;	
	bcd0_dat = 32'd7;
	reset=0;
	bcd0_stb=1; bcd0_cyc=1; bcd0_we=1;
	

       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end

	
	bcd0_adr = 32'h00;	
	bcd0_dat = 32'd3;
	reset=0;
	bcd0_stb=1; bcd0_cyc=1; bcd0_we=1;
	
  
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end


      end
   end
	 

   initial begin: TEST_CASE
     $dumpfile("wb_BCD_tb.vcd");
     $dumpvars(-1, uut);
	
     #10 -> reset_trigger;
     #((PERIOD*DUTY_CYCLE)*2000000) $finish;
   end

endmodule

