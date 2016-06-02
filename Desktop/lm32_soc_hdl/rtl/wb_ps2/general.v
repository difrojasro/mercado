module general(	input wire Clkps2,
			input wire dataps2,
			output wire [6:0] ascii );


Teclado T1(.Clkps2(Clkps2),.dataps2(dataps2),.ascii(ascii));

endmodule
