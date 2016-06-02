module selector_anodes
	(
	 input clk,
	 input [3:0] valor1, valor2, valor3, valor4,	
	 output reg [3:0] valanode,
	 output reg [3:0] outvalsseg
	);
	
	reg [25:0] counter;
	reg [1:0] sel;
	reg clk1;
	initial begin counter=0; sel=0; clk1=0; end

	always @(posedge clk)
	if (counter==50000) begin
		counter=0; clk1=~clk1;
			end
	else begin
		counter=counter+1;
			end

	always @(posedge clk1)
	begin
	sel=sel+1;
	if (sel==4) begin
		sel=0;
	end		
		case(sel)
			3'd0: valanode = 4'b1110; 
			3'd1: valanode = 4'b1101;
			3'd2: valanode = 4'b1011;
			default: valanode = 4'b0111;
		endcase

		case(valanode)
			4'b1110: outvalsseg = valor1;
			4'b1101: outvalsseg = valor2;
			4'b1011: outvalsseg = valor3;
			default: outvalsseg = valor4;
		endcase
	end

endmodule