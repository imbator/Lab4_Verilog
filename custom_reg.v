module custom_reg(
input [0:0] SW,
input [1:0] KEY,
input CLOCK_50,
output reg sw_event,
output reg [2:0] event_sync_reg,
output reg [9:0] custom_register,
output wire is_even,
output reg [7:0] counter,
output reg [9:0] LEDR,
output reg [6:0] HEX0,
output reg [6:0] HEX1
);

initial event_sync_reg = 3'b0;
initial custom_register = 10'b0;
initial LEDR = 10'b0;
initial counter = 8'b0;
assign is_even = ~^custom_register;


always @(posedge CLOCK_50 or posedge KEY[1]) begin
	if (KEY[1]) begin
		custom_register = 10'b0;
		counter <= 8'b0;
	end else begin
		if (KEY[0]) begin
			custom_register ={custom_register[8:0], SW[0]};
			if (~is_even) begin
				counter <= counter + 1;
			end
			LEDR = custom_register;
		end
	end
LEDR = custom_register;
case (counter[7:4])
	0: HEX1 = 7'b1000000;
	1: HEX1 = 7'b1111001;
	2: HEX1 = 7'b0100100;
	3:	HEX1 = 7'b0110000;
	4:	HEX1 = 7'b0011001;
	5:	HEX1 = 7'b0010010;
	6:	HEX1 = 7'b0000010;
	7:	HEX1 = 7'b1111000;
	8:	HEX1 = 7'b0000000;
	9:	HEX1 = 7'b0010000;		
endcase
case (counter[3:0])
	0: HEX0 = 7'b1000000;
	1: HEX0 = 7'b1111001;
	2: HEX0 = 7'b0100100;
	3:	HEX0 = 7'b0110000;
	4:	HEX0 = 7'b0011001;
	5:	HEX0 = 7'b0010010;
	6:	HEX0 = 7'b0000010;
	7:	HEX0 = 7'b1111000;
	8:	HEX0 = 7'b0000000;
	9:	HEX0 = 7'b0010000;
endcase
end
endmodule
