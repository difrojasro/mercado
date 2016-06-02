module serie_paralelo(	input wire Clkps2,
			input wire dataps2,
			output wire [7:0] s,
			output wire en_scancode );


			reg [7:0] data_curr;
			reg [7:0] data_pre;
			reg [7:0] s_aux;
			reg [3:0] b;
			reg finps2;
			reg en_scancode_aux;

initial
	begin
		b<=4'h1;
		finps2<=1'b0;
		data_curr<=8'hf0;
		data_pre<=8'hf0;
		s_aux<=8'hf0;
		en_scancode_aux=1'b0;
	end
always @(negedge Clkps2)

	begin
	case(b)
		1:;
		//bit de inicio
		2:data_curr[0]<=dataps2;
		3:data_curr[1]<=dataps2;
		4:data_curr[2]<=dataps2;
		5:data_curr[3]<=dataps2;
		6:data_curr[4]<=dataps2;
		7:data_curr[5]<=dataps2;
		8:data_curr[6]<=dataps2;
		9:data_curr[7]<=dataps2;
		10:finps2<=1'b1;
		//bit de paridad
		11:finps2<=1'b0;
		//bit final
	endcase
	if(b<=10)
	begin
		b<=b+1;
	end
	else if(b==11)
	begin
		b<=1;
	end
end

always@(posedge finps2)

begin
if(data_curr ==8'hf0)
	begin
	s_aux<=data_pre;
	en_scancode_aux<=1'b1;
	end
else
	begin
	data_pre<=data_curr;
	en_scancode_aux<=1'b0;
	end
end


assign s=s_aux;
assign en_scancode=en_scancode_aux;
endmodule
