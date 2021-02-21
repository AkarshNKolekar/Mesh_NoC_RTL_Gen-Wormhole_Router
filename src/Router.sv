`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// The top level Router module containing input buffers, route compute and switch allocator.

module Router #(
	parameter LINK_WIDTH = 8,
	parameter PORTS = 5,
	parameter BUFFER_DEPTH = 4,
	parameter MESH_DIM = 4,
	parameter ROUTER_ID = 0
)(
	clk,
	rst,
	router_out_wr_en_0,
	router_out_wr_en_1,
	router_out_wr_en_2,
	router_out_wr_en_3,
	router_out_wr_en_4,
	router_in_flit_0,
	router_in_flit_1,
	router_in_flit_2,
	router_in_flit_3,
	router_in_flit_4,
	router_out_flit_0,
	router_out_flit_1,
	router_out_flit_2,
	router_out_flit_3,
	router_out_flit_4,
	router_in_wr_en_0,
	router_in_wr_en_1,
	router_in_wr_en_2,
	router_in_wr_en_3,
	router_in_wr_en_4,
	router_out_full_0,
	router_out_full_1,
	router_out_full_2,
	router_out_full_3,
	router_out_full_4,
	router_in_ON_OFF_0,
	router_in_ON_OFF_1,
	router_in_ON_OFF_2,
	router_in_ON_OFF_3,
	router_in_ON_OFF_4,	
);

localparam OP_SIZE = 3; 

////////////////////////////////PORT INTERFACE/////////////////////////////////////
input clk, rst;
input router_in_wr_en_0, router_in_wr_en_1, router_in_wr_en_2, router_in_wr_en_3, router_in_wr_en_4;
input router_in_ON_OFF_0, router_in_ON_OFF_1, router_in_ON_OFF_2, router_in_ON_OFF_3, router_in_ON_OFF_4;
input [LINK_WIDTH-1:0] router_in_flit_0, router_in_flit_1, router_in_flit_2, router_in_flit_3, router_in_flit_4;

output [LINK_WIDTH-1:0] router_out_flit_0, router_out_flit_1, router_out_flit_2, router_out_flit_3, router_out_flit_4;
output reg router_out_full_0, router_out_full_1, router_out_full_2, router_out_full_3, router_out_full_4;
wire router_out_full_0_temp, router_out_full_1_temp, router_out_full_2_temp, router_out_full_3_temp, router_out_full_4_temp;
output router_out_wr_en_0, router_out_wr_en_1, router_out_wr_en_2, router_out_wr_en_3, router_out_wr_en_4;
////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////FULL SIGNAL DELAYS////////////////////////////////////
always @ (posedge clk) begin
	router_out_full_0 <= router_out_full_0_temp;
	router_out_full_1 <= router_out_full_1_temp;
	router_out_full_2 <= router_out_full_2_temp;
	router_out_full_3 <= router_out_full_3_temp;
	router_out_full_4 <= router_out_full_4_temp;	
end
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////BUFFER INTERFACE////////////////////////////////////
wire [LINK_WIDTH-1:0] out_flit_0, out_flit_1, out_flit_2, out_flit_3, out_flit_4;
wire empty_north;
wire empty_east;
wire empty_south;
wire empty_west;
wire empty_local;
wire nn_empty;
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////SWITCH ARBITER INTERFACE/////////////////////////////
wire rd_en_north, rd_en_east, rd_en_south, rd_en_west, rd_en_local;
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////ROUTE COMPUTE INTERFACE/////////////////////////////
wire [OP_SIZE-1:0] op_port0, op_port1, op_port2, op_port3, op_port4;
////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////BUFFER INSTANTIATION////////////////////////////////
buffer #(
	.DATA_WIDTH(LINK_WIDTH),
	.RAM_DEPTH(BUFFER_DEPTH)
) north_buffer (
	.rst(rst),
	.clk(clk),
	.wr_en(router_in_wr_en_0),	//for the downstream router
	.rd_en(rd_en_north),	//from the switch arbiter
	.data_in(router_in_flit_0),
	.data_out(out_flit_0),
	.full(router_out_full_0_temp),
	.empty(empty_north)
);

buffer #(
	.DATA_WIDTH(LINK_WIDTH),
	.RAM_DEPTH(BUFFER_DEPTH)
) east_buffer (
	.rst(rst),
	.clk(clk),
	.wr_en(router_in_wr_en_1),	//for the downstream router
	.rd_en(rd_en_east),	//from the switch arbiter
	.data_in(router_in_flit_1),
	.data_out(out_flit_1),
	.full(router_out_full_1_temp),
	.empty(empty_east)
);

buffer #(
	.DATA_WIDTH(LINK_WIDTH),
	.RAM_DEPTH(BUFFER_DEPTH)
) south_buffer (
	.rst(rst),
	.clk(clk),
	.wr_en(router_in_wr_en_2),	//for the downstream router
	.rd_en(rd_en_south),	//from the switch arbiter
	.data_in(router_in_flit_2),
	.data_out(out_flit_2),
	.full(router_out_full_2_temp),
	.empty(empty_south)
);

buffer #(
	.DATA_WIDTH(LINK_WIDTH),
	.RAM_DEPTH(BUFFER_DEPTH)
) west_buffer (
	.rst(rst),
	.clk(clk),
	.wr_en(router_in_wr_en_3),	//for the downstream router
	.rd_en(rd_en_west),	//from the switch arbiter
	.data_in(router_in_flit_3),
	.data_out(out_flit_3),
	.full(router_out_full_3_temp),
	.empty(empty_west)
);

buffer #(
	.DATA_WIDTH(LINK_WIDTH),
	.RAM_DEPTH(BUFFER_DEPTH)
) local_buffer (
	.rst(rst),
	.clk(clk),
	.wr_en(router_in_wr_en_4),	//for the downstream router
	.rd_en(rd_en_local),	//from the switch arbiter
	.data_in(router_in_flit_4),
	.data_out(out_flit_4),
	.full(router_out_full_4_temp),
	.empty(empty_local)
);
/////////////////////////////BUFFER DONE/////////////////////////////////////////

////////////////////////////ROUTE COMPUTE////////////////////////////////////////
route_compute #(
	.IP_SIZE(LINK_WIDTH),
	.OP_SIZE($clog2(PORTS)),
	.MESH_DIM(MESH_DIM),
	.ROUTER_ID(ROUTER_ID)
) route_compute (
	.clk(clk),
	.rst(rst),
	.flit0(out_flit_0),
	.flit1(out_flit_1),
	.flit2(out_flit_2),
	.flit3(out_flit_3),
	.flit4(out_flit_4),
	.op_port0(op_port0),
	.op_port1(op_port1),
	.op_port2(op_port2),
	.op_port3(op_port3),
	.op_port4(op_port4)
);
////////////////////////////ROUTE COMPUTE DONE///////////////////////////////////

///////////////////////////SWITCH ALLOCATOR////////////////////////////////////////
switch_allocator #(
	.OP_SIZE(OP_SIZE),
	.NUM_PORTS(PORTS),
	.FLIT_SIZE(LINK_WIDTH)
) switch_allocator (
	.clk(clk),
	.rst(rst),
	.empty_north(empty_north),
	.empty_east(empty_east),
	.empty_south(empty_south),
	.empty_west(empty_west),
	.empty_local(empty_local),
	.ON_OFF_signal_north(router_in_ON_OFF_0),
	.ON_OFF_signal_east(router_in_ON_OFF_1),
	.ON_OFF_signal_south(router_in_ON_OFF_2),
	.ON_OFF_signal_west(router_in_ON_OFF_3),
	.ON_OFF_signal_local(router_in_ON_OFF_4),
	.op_port0(op_port0),
	.op_port1(op_port1),
	.op_port2(op_port2),
	.op_port3(op_port3),
	.op_port4(op_port4),
	.wr_en_north(router_out_wr_en_0),
	.wr_en_east(router_out_wr_en_1),
	.wr_en_south(router_out_wr_en_2),
	.wr_en_west(router_out_wr_en_3),
	.wr_en_local(router_out_wr_en_4),
	.in_buf_north(out_flit_0),
	.in_buf_east(out_flit_1),
	.in_buf_south(out_flit_2),
	.in_buf_west(out_flit_3),
	.in_buf_local(out_flit_4),
	.op_flit_north(router_out_flit_0),
	.op_flit_east(router_out_flit_1),
	.op_flit_south(router_out_flit_2),
	.op_flit_west(router_out_flit_3),
	.op_flit_local(router_out_flit_4),
	.rd_en_north(rd_en_north),
	.rd_en_east(rd_en_east),
	.rd_en_south(rd_en_south),
	.rd_en_west(rd_en_west),
	.rd_en_local(rd_en_local)
);

//////////////////////////SWITCH ALLOCATOR DONE////////////////////////////////////

endmodule