`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is the Switch Allocator module consisting of the Request Generator, 
// Round Robin Arbiter and Crossbar Switch.

module switch_allocator 
	#(parameter OP_SIZE=3,
	  parameter NUM_PORTS = 5,
	  parameter FLIT_SIZE = 8) (clk,
				    rst,
				    empty_north,
				    empty_east,
				    empty_south,
				    empty_west,
				    empty_local,
				    ON_OFF_signal_north,
				    ON_OFF_signal_east,
				    ON_OFF_signal_south,
				    ON_OFF_signal_west,
				    ON_OFF_signal_local,
				    op_port0,
				    op_port1,
				    op_port2,
				    op_port3,
				    op_port4,
				    wr_en_north,
				    wr_en_east,
				    wr_en_south,
				    wr_en_west,
				    wr_en_local,
				    in_buf_north,
				    in_buf_east,
				    in_buf_south,
				    in_buf_west,
				    in_buf_local,
				    op_flit_north,
				    op_flit_east,
				    op_flit_south,
				    op_flit_west,
				    op_flit_local,
				    rd_en_north,
				    rd_en_east,
				    rd_en_south,
				    rd_en_west,
				    rd_en_local);

input clk;
input rst;

input empty_north;
input empty_east;
input empty_south;
input empty_west;
input empty_local;

input ON_OFF_signal_north;
input ON_OFF_signal_east;
input ON_OFF_signal_south;
input ON_OFF_signal_west;
input ON_OFF_signal_local;

input [OP_SIZE-1:0] op_port0;
input [OP_SIZE-1:0] op_port1;
input [OP_SIZE-1:0] op_port2;
input [OP_SIZE-1:0] op_port3;
input [OP_SIZE-1:0] op_port4;

wire [NUM_PORTS-1:0] north_demux_op;
wire [NUM_PORTS-1:0] east_demux_op;
wire [NUM_PORTS-1:0] south_demux_op;
wire [NUM_PORTS-1:0] west_demux_op;
wire [NUM_PORTS-1:0] local_demux_op;

wire [NUM_PORTS-1:0] north_arbiter_grant;
wire [NUM_PORTS-1:0] east_arbiter_grant;
wire [NUM_PORTS-1:0] south_arbiter_grant;
wire [NUM_PORTS-1:0] west_arbiter_grant;
wire [NUM_PORTS-1:0] local_arbiter_grant;

output wr_en_north;
output wr_en_east;
output wr_en_south;
output wr_en_west;
output wr_en_local;

input [FLIT_SIZE-1:0] in_buf_north;
input [FLIT_SIZE-1:0] in_buf_east;
input [FLIT_SIZE-1:0] in_buf_south;
input [FLIT_SIZE-1:0] in_buf_west;
input [FLIT_SIZE-1:0] in_buf_local;

output [FLIT_SIZE-1:0] op_flit_north;
output [FLIT_SIZE-1:0] op_flit_east;
output [FLIT_SIZE-1:0] op_flit_south;
output [FLIT_SIZE-1:0] op_flit_west;
output [FLIT_SIZE-1:0] op_flit_local;

output rd_en_north;
output rd_en_east;
output rd_en_south;
output rd_en_west;
output rd_en_local;

demux_1to5 north_demux (.select(op_port0), .op(north_demux_op), .rst(rst), .empty(empty_north));
demux_1to5 east_demux (.select(op_port1), .op(east_demux_op), .rst(rst), .empty(empty_east));
demux_1to5 south_demux (.select(op_port2), .op(south_demux_op), .rst(rst), .empty(empty_south));
demux_1to5 west_demux (.select(op_port3), .op(west_demux_op), .rst(rst), .empty(empty_west));
demux_1to5 local_demux (.select(op_port4), .op(local_demux_op), .rst(rst), .empty(empty_local));

round_robin_arbiter north_arbiter(.clk(clk),
				  .rst(rst),
				  .req({local_demux_op[0],
					west_demux_op[0],
					south_demux_op[0],
					east_demux_op[0],
					north_demux_op[0]}),
				  .ON_OFF_signal(ON_OFF_signal_north),
				  .grant(north_arbiter_grant));

round_robin_arbiter east_arbiter(.clk(clk),
				  .rst(rst),
				  .req({local_demux_op[1],
					west_demux_op[1],
					south_demux_op[1],
					east_demux_op[1],
					north_demux_op[1]}),
				  .ON_OFF_signal(ON_OFF_signal_east),
				  .grant(east_arbiter_grant));

round_robin_arbiter south_arbiter(.clk(clk),
				  .rst(rst),
				  .req({local_demux_op[2],
					west_demux_op[2],
					south_demux_op[2],
					east_demux_op[2],
					north_demux_op[2]}),
				  .ON_OFF_signal(ON_OFF_signal_south),
				  .grant(south_arbiter_grant));

round_robin_arbiter west_arbiter(.clk(clk),
				  .rst(rst),
				  .req({local_demux_op[3],
					west_demux_op[3],
					south_demux_op[3],
					east_demux_op[3],
					north_demux_op[3]}),
				  .ON_OFF_signal(ON_OFF_signal_west),
				  .grant(west_arbiter_grant));

round_robin_arbiter local_arbiter(.clk(clk),
				  .rst(rst),
				  .req({local_demux_op[4],
					west_demux_op[4],
					south_demux_op[4],
					east_demux_op[4],
					north_demux_op[4]}),
				  .ON_OFF_signal(ON_OFF_signal_local),
				  .grant(local_arbiter_grant));

assign wr_en_north = |north_arbiter_grant;
assign wr_en_east = |east_arbiter_grant;
assign wr_en_south = |south_arbiter_grant;
assign wr_en_west = |west_arbiter_grant;
assign wr_en_local = |local_arbiter_grant;

one_hot_mux5_1 north_mux (.input_buffer0 (in_buf_north), 
			  .input_buffer1 (in_buf_east), 
			  .input_buffer2 (in_buf_south), 
			  .input_buffer3 (in_buf_west), 
			  .input_buffer4 (in_buf_local), 
			  .select(north_arbiter_grant), 
			  .op_flit(op_flit_north));

one_hot_mux5_1 east_mux (.input_buffer0 (in_buf_north), 
			  .input_buffer1 (in_buf_east), 
			  .input_buffer2 (in_buf_south), 
			  .input_buffer3 (in_buf_west), 
			  .input_buffer4 (in_buf_local), 
			  .select(east_arbiter_grant), 
			  .op_flit(op_flit_east));

one_hot_mux5_1 south_mux (.input_buffer0 (in_buf_north), 
			  .input_buffer1 (in_buf_east), 
			  .input_buffer2 (in_buf_south), 
			  .input_buffer3 (in_buf_west), 
			  .input_buffer4 (in_buf_local), 
			  .select(south_arbiter_grant), 
			  .op_flit(op_flit_south));

one_hot_mux5_1 west_mux (.input_buffer0 (in_buf_north), 
			  .input_buffer1 (in_buf_east), 
			  .input_buffer2 (in_buf_south), 
			  .input_buffer3 (in_buf_west), 
			  .input_buffer4 (in_buf_local), 
			  .select(west_arbiter_grant), 
			  .op_flit(op_flit_west));

one_hot_mux5_1 local_mux (.input_buffer0 (in_buf_north), 
			  .input_buffer1 (in_buf_east), 
			  .input_buffer2 (in_buf_south), 
			  .input_buffer3 (in_buf_west), 
			  .input_buffer4 (in_buf_local), 
			  .select(local_arbiter_grant), 
			  .op_flit(op_flit_local));

assign rd_en_north = north_arbiter_grant[0]
			|east_arbiter_grant[0]
			|south_arbiter_grant[0]
			|west_arbiter_grant[0]
			|local_arbiter_grant[0];

assign rd_en_east = north_arbiter_grant[1]
			|east_arbiter_grant[1]
			|south_arbiter_grant[1]
			|west_arbiter_grant[1]
			|local_arbiter_grant[1];

assign rd_en_south = north_arbiter_grant[2]
			|east_arbiter_grant[2]
			|south_arbiter_grant[2]
			|west_arbiter_grant[2]
			|local_arbiter_grant[2];

assign rd_en_west = north_arbiter_grant[3]
			|east_arbiter_grant[3]
			|south_arbiter_grant[3]
			|west_arbiter_grant[3]
			|local_arbiter_grant[3];

assign rd_en_local = north_arbiter_grant[4]
			|east_arbiter_grant[4]
			|south_arbiter_grant[4]
			|west_arbiter_grant[4]
			|local_arbiter_grant[4];

endmodule