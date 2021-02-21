`timescale 1ns/100ps
// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is the buffer module used as the input buffer at each port of the router

module buffer #(
	parameter DATA_WIDTH = 8,
	parameter RAM_DEPTH = 4
)(
	rst,
	clk,
	wr_en,
	rd_en,
	data_in,
	data_out,
	full,
	empty
);

localparam BUFFER_DEPTH = RAM_DEPTH-1;
//port declarations

input clk, rst, wr_en, rd_en;
input [DATA_WIDTH-1 : 0] data_in;
output [DATA_WIDTH-1 : 0] data_out;
output full, empty;

//internal variables
reg [$clog2(RAM_DEPTH)-1 : 0] write_ptr;
reg [$clog2(RAM_DEPTH)-1 : 0] read_ptr;
wire [$clog2(RAM_DEPTH) : 0] status;
wire [DATA_WIDTH-1 : 0] data_out;
wire [DATA_WIDTH-1 : 0] ram_data;
reg full;
reg empty;

//write addressing
always @(posedge clk)
begin
	if (rst)
	begin
		write_ptr <= 0;
	end
	else if (wr_en && (write_ptr != BUFFER_DEPTH))
	begin
		write_ptr <= write_ptr + 1;
	end
	else if (wr_en && (write_ptr == BUFFER_DEPTH) && (read_ptr == 0))
	begin
		write_ptr <= write_ptr;
	end
	else if ((write_ptr == BUFFER_DEPTH) && (read_ptr != 0))
	begin
		write_ptr <= 0;
	end
	else
	begin
		write_ptr <= write_ptr;
	end
end

//read addressing
always @(posedge clk)
begin
	if (rst)
	begin
		read_ptr <= 0;
	end
	else if (rd_en && (read_ptr == write_ptr))
	begin
		read_ptr <= read_ptr;
	end
	else if (rd_en && (read_ptr == BUFFER_DEPTH))
	begin
		read_ptr <= 0;
	end
	else if (rd_en)
	begin
		read_ptr <= read_ptr + 1;
	end
	else begin
		read_ptr <= read_ptr;
	end
end

assign data_out = ram_data;

//empty and full flag status
assign status = write_ptr - read_ptr;

always @*
begin
	if (rst)
	begin
		empty = 1;
		full = 0;
	end
	else if (status == BUFFER_DEPTH)
	begin
		full = 1;
	end
	else if (status == 0)
	begin
		empty = 1;
	end
	else
	begin
		empty = 0;
		full = 0;
	end
end

ram #(
	.DATA_WIDTH(DATA_WIDTH),
	.RAM_DEPTH(RAM_DEPTH)
	) dut (
	.clk(clk),
	.rd_en(rd_en),
	.wr_en(wr_en),
	.address_in(write_ptr),
	.address_out(read_ptr),
	.data_in(data_in),
	.data_out(ram_data)
	);

endmodule // buffer