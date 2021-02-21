`timescale 1ns/100ps
// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu
module demux_1to5_tb ();

reg [2:0] select;
wire [4:0] op;
//testing out the demux by giving it all combinations of select signals
initial begin
	select = 3'b000;
	#5 select = 3'b001;
	#5 select = 3'b010;
	#5 select = 3'b011;
	#5 select = 3'b100;
	#5 select = 3'b101;
	#5 select = 3'b110;
	#5 select = 3'b111;
end

demux_1to5 m1 (select, op);

always #100 $finish;

endmodule