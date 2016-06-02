module Teclado(	input wire Clkps2,
		input wire dataps2,
		output wire [6:0] ascii );


		wire [7:0] s;
		wire en_scancode;

serie_paralelo Lectura(.Clkps2(Clkps2),.dataps2(dataps2),.s(s), .en_scancode(en_scancode));

conversor Conversion(.s(s), .ascii_code(ascii), .en_scancode(en_scancode));



endmodule
