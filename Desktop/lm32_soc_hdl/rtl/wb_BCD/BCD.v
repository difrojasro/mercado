`timescale 1ns / 1ps

module BCD(
		input clk,		
		input [3:0] dato1,
		input [3:0] dato2,
		input [3:0] dato3,
		input [3:0] dato4,
		output [6:0] seg,
		output [3:0] an
);

wire [3:0] dato_wire;
wire [3:0] dato_in1;
wire [3:0] dato_in2;
wire [3:0] dato_in3;
wire [3:0] dato_in4;

decoder_segments decoder_segments
	(
	.sseg(seg),
	.dec(dato_wire)
	);

selector_anodes selector_anodes
	(
	.clk(clk),
	.valor1(dato_in1),
	.valor2(dato_in2),
	.valor3(dato_in3),
	.valor4(dato_in4),
	.valanode(an),
	.outvalsseg(dato_wire)
	);

assign dato_in1 = dato1;
assign dato_in2 = dato2;
assign dato_in3 = dato3;
assign dato_in4 = dato4;

endmodule
