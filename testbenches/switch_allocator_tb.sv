`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// testing out the Switch Allocator module.
// the input buffer flits are varied to test if they are sent out onto the right output ports.

module switch_allocator_tb ();

parameter OP_SIZE = 3;
parameter FLIT_SIZE = 8;

reg [OP_SIZE-1:0] op_port0;
reg [OP_SIZE-1:0] op_port1;
reg [OP_SIZE-1:0] op_port2;
reg [OP_SIZE-1:0] op_port3;
reg [OP_SIZE-1:0] op_port4;

reg ON_OFF_signal_north;
reg ON_OFF_signal_east;
reg ON_OFF_signal_south;
reg ON_OFF_signal_west;
reg ON_OFF_signal_local;

reg [FLIT_SIZE-1:0] in_buf_north;
reg [FLIT_SIZE-1:0] in_buf_east;
reg [FLIT_SIZE-1:0] in_buf_south;
reg [FLIT_SIZE-1:0] in_buf_west;
reg [FLIT_SIZE-1:0] in_buf_local;

wire wr_en_north;
wire wr_en_east;
wire wr_en_south;
wire wr_en_west;
wire wr_en_local;

wire [FLIT_SIZE-1:0] op_flit_north;
wire [FLIT_SIZE-1:0] op_flit_east;
wire [FLIT_SIZE-1:0] op_flit_south;
wire [FLIT_SIZE-1:0] op_flit_west;
wire [FLIT_SIZE-1:0] op_flit_local;

wire rd_en_north;
wire rd_en_east;
wire rd_en_south;
wire rd_en_west;
wire rd_en_local;

reg clk;

initial begin
	clk = 1'b0;
	ON_OFF_signal_north = 1'b1;
	ON_OFF_signal_east = 1'b1;
	ON_OFF_signal_south = 1'b1;
	ON_OFF_signal_west = 1'b1;
	ON_OFF_signal_local = 1'b1;
	#5;
	op_port0 = 3'b010;
	op_port1 = 3'b010;
	op_port2 = 3'b000;
	op_port3 = 3'b000;
	op_port4 = 3'b001;
	in_buf_north = 8'd1;
	in_buf_east = 8'd2;
	in_buf_south = 8'd3;
	in_buf_west = 8'd4;
	in_buf_local = 8'd5;
	#10;
	in_buf_north = 8'd6;
	in_buf_east = 8'd7;
	in_buf_south = 8'd8;
	in_buf_west = 8'd9;
	in_buf_local = 8'd10;
	#10;
	in_buf_north = 8'd11;
	in_buf_east = 8'd12;
	in_buf_south = 8'd13;
	in_buf_west = 8'd14;
	in_buf_local = 8'd15;
	#10;
	in_buf_north = 8'd15;
	in_buf_east = 8'd16;
	in_buf_south = 8'd17;
	in_buf_west = 8'd18;
	in_buf_local = 8'd19;
end

always #5 clk = ~clk;

switch_allocator SA (.op_port0(op_port0),
		     .op_port1(op_port1),
		     .op_port2(op_port2),
		     .op_port3(op_port3),
		     .op_port4(op_port4),
		     .clk(clk),
		     .ON_OFF_signal_north(ON_OFF_signal_north),
		     .ON_OFF_signal_east(ON_OFF_signal_east),
		     .ON_OFF_signal_south(ON_OFF_signal_south),
		     .ON_OFF_signal_west(ON_OFF_signal_west),
		     .ON_OFF_signal_local(ON_OFF_signal_local),
		     .wr_en_north(wr_en_north),
		     .wr_en_east(wr_en_east),
		     .wr_en_south(wr_en_south),
		     .wr_en_west(wr_en_west),
		     .wr_en_local(wr_en_local),
		     .in_buf_north(in_buf_north),
		     .in_buf_east(in_buf_east),
		     .in_buf_south(in_buf_south),
		     .in_buf_west(in_buf_west),
		     .in_buf_local(in_buf_local),
		     .op_flit_north(op_flit_north),
		     .op_flit_east(op_flit_east),
		     .op_flit_south(op_flit_south),
		     .op_flit_west(op_flit_west),
		     .op_flit_local(op_flit_local),
		     .rd_en_north(rd_en_north),
		     .rd_en_east(rd_en_east),
		     .rd_en_south(rd_en_south),
		     .rd_en_west(rd_en_west),
		     .rd_en_local(rd_en_local));

always #100 $finish;

endmodule