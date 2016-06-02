module sepadaror(input [13:0] dato, output[3:0] valor1, valor2, valor3, valor4);

if (dato <= 15)
	begin
		assign valor1 = dato[3:0];

	end
endmodule
