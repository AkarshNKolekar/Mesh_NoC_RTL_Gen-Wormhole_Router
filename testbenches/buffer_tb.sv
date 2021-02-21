`timescale 1ns/100ps
// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

module buffer_tb ();

localparam DATA_WIDTH = 8;
localparam RAM_DEPTH = 8;

reg clk, rst, wr_en, rd_en;
reg [DATA_WIDTH-1 : 0] data_in;
wire [DATA_WIDTH-1 : 0] data_out;
wire full, empty;
integer i = 0;
//testing the input buffer by writing and reading data from it
initial
begin
	clk = 0;
	rst = 0;
	wr_en = 0;
	rd_en = 0;
	data_in = 0;
	#1 rst = 1;
	#1 rst = 0;
	@ (posedge clk);
	wr_en = 1;
	for (i=4; i<13; i=i+1)
	begin
		data_in = i;
		@ (posedge clk);
	end
	wr_en = 0;
	@ (posedge clk);
	rd_en = 1;
	for (i=4; i<13; i=i+1)
	begin
		@ (posedge clk);
	end
	rd_en = 0;
	#100 $finish;
end

always #1 clk = ~clk;

buffer #(
	.DATA_WIDTH(DATA_WIDTH),
	.RAM_DEPTH(RAM_DEPTH)
	) dut (
	.rst(rst),
	.clk(clk),
	.wr_en(wr_en),
	.rd_en(rd_en),
	.data_in(data_in),
	.data_out(data_out),
	.full(full),
	.empty(empty)
	);

endmodule // tb_buffer
