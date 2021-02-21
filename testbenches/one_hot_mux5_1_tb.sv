`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// testing out the multiplexer by changinf the select signal.

module one_hot_mux5_1_tb ();

reg [7:0] input_buffer0;
reg [7:0] input_buffer1;
reg [7:0] input_buffer2;
reg [7:0] input_buffer3;
reg [7:0] input_buffer4;

reg [4:0] select;

wire [7:0] op_flit;
wire wr_en;

initial begin
	input_buffer0 = 0;
	input_buffer1 = 1;
	input_buffer2 = 2;
	input_buffer3 = 3;
	input_buffer4 = 4;
	select = 0;
	#5 select = 1;
	#5 select = 2;
	#5 select = 4;
	#8 select = 8;
	#5 select = 16;
end

one_hot_mux5_1 m1(input_buffer0, 
			input_buffer1, 
			input_buffer2, 
			input_buffer3, 
			input_buffer4, 
			select, 
			op_flit,
			wr_en);

always #100 $finish;

endmodule