// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is RAM module used in the construction of each input buffer of the router.

module ram #(
	parameter DATA_WIDTH = 8,
	parameter RAM_DEPTH = 4
)(
	clk,
	rd_en,
	wr_en,
	address_in,
	address_out,
	data_in,
	data_out
);

input clk, rd_en, wr_en;
input [$clog2(RAM_DEPTH)-1:0] address_in, address_out;
input [DATA_WIDTH-1:0] data_in;

output [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] RAM [0:RAM_DEPTH-1];
// data is constantly read out of the RAM
assign data_out = RAM[address_out];
// data is written into the RAM at the positive edge of the clock is write enbale flag is set high
always @ (posedge clk)
begin
	if (wr_en)
	begin
		RAM[address_in] <= data_in;
	end
end
endmodule