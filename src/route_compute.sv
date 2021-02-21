`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is the route compute unit of the router.
// The output port of the packet coming in through each input port is calculated.
// The route compute unit is completely combinational.

module route_compute #(
	parameter IP_SIZE = 8,
	parameter OP_SIZE = 3,
	parameter MESH_DIM = 4,
	parameter ROUTER_ID = 0
)(
	clk,
	rst,
	flit0,
	flit1,
	flit2,
	flit3,
	flit4,
	op_port0,
	op_port1,
	op_port2,
	op_port3,
	op_port4
);
//--------------------------------------------------------------
input clk;
input rst;
//--------------------------------------------------------------
input [IP_SIZE-1:0] flit0;
input [IP_SIZE-1:0] flit1;
input [IP_SIZE-1:0] flit2;
input [IP_SIZE-1:0] flit3;
input [IP_SIZE-1:0] flit4;
//--------------------------------------------------------------
output [OP_SIZE-1:0] op_port0;
output [OP_SIZE-1:0] op_port1;
output [OP_SIZE-1:0] op_port2;
output [OP_SIZE-1:0] op_port3;
output [OP_SIZE-1:0] op_port4;
reg [OP_SIZE-1:0] op_port0_reg;
reg [OP_SIZE-1:0] op_port1_reg;
reg [OP_SIZE-1:0] op_port2_reg;
reg [OP_SIZE-1:0] op_port3_reg;
reg [OP_SIZE-1:0] op_port4_reg;
//--------------------------------------------------------------
localparam NORTH = 0, EAST = 1, SOUTH = 2, WEST = 3, LOCAL = 4;
//--------------------------------------------------------------
localparam HEAD = 2'b00, BODY = 2'b01, TAIL = 2'b10;
//--------------------------------------------------------------
wire [$clog2(MESH_DIM)-1:0] my_x = ROUTER_ID % MESH_DIM;
wire [$clog2(MESH_DIM)-1:0] my_y = ROUTER_ID / MESH_DIM; 
reg [$clog2(MESH_DIM):0] dest_x0;
reg [$clog2(MESH_DIM):0] dest_y0;
reg [$clog2(MESH_DIM):0] dest_x1;
reg [$clog2(MESH_DIM):0] dest_y1;
reg [$clog2(MESH_DIM):0] dest_x2;
reg [$clog2(MESH_DIM):0] dest_y2;
reg [$clog2(MESH_DIM):0] dest_x3;
reg [$clog2(MESH_DIM):0] dest_y3;
reg [$clog2(MESH_DIM):0] dest_x4;
reg [$clog2(MESH_DIM):0] dest_y4;
//--------------------------------------------------------------
// Flit format: [Y][X][H/B/T]
//	Bits:	 3  3    2
//--------------------------------------------------------------
// If a head flit comes in, extract the destination coordinates from the flit.
// Calculate the output port for that packet.
// Keep that output port constant until a new head flit comes in.

always @ * begin
	if (flit0[1:0] == HEAD) begin
		dest_x0 = flit0[4:2];
		dest_y0 = flit0[7:5];
		if (dest_x0 != my_x) begin
			if (dest_x0 >= my_x) begin
				op_port0_reg <= EAST;
			end
			else begin
				op_port0_reg <= WEST;
			end
		end
		else if (dest_y0 != my_y) begin
			if (dest_y0 >= my_y) begin
				op_port0_reg <= NORTH;
			end
			else begin
				op_port0_reg <= SOUTH;
			end
		end
		else begin
			op_port0_reg <= LOCAL;
		end
	end
	else if (flit0[1:0] == BODY || flit0[1:0] == TAIL) begin
		op_port0_reg <= op_port0;
	end
	else begin
		op_port0_reg <= 8'bx;
	end
end

always @ * begin
	if (flit1[1:0] == HEAD) begin
		dest_x1 = flit1[4:2];
		dest_y1 = flit1[7:5];
		if (dest_x1 != my_x) begin
			if (dest_x1 >= my_x) begin
				op_port1_reg <= EAST;
			end
			else begin
				op_port1_reg <= WEST;
			end
		end
		else if (dest_y1 != my_y) begin
			if (dest_y1 >= my_y) begin
				op_port1_reg <= NORTH;
			end
			else begin
				op_port1_reg <= SOUTH;
			end
		end
		else begin
			op_port1_reg <= LOCAL;
		end
	end
	else if (flit1[1:0] == BODY || flit1[1:0] == TAIL) begin
		op_port1_reg <= op_port1;
	end
	else begin
		op_port1_reg <= 8'bx;
	end
end

always @ * begin
	if (flit2[1:0] == HEAD) begin
		dest_x2 = flit2[4:2];
		dest_y2 = flit2[7:5];
		if (dest_x2 != my_x) begin
			if (dest_x2 >= my_x) begin
				op_port2_reg <= EAST;
			end
			else begin
				op_port2_reg <= WEST;
			end
		end
		else if (dest_y2 != my_y) begin
			if (dest_y2 >= my_y) begin
				op_port2_reg <= NORTH;
			end
			else begin
				op_port2_reg <= SOUTH;
			end
		end
		else begin
			op_port2_reg <= LOCAL;
		end
	end
	else if (flit2[1:0] == BODY || flit2[1:0] == TAIL) begin
		op_port2_reg <= op_port2;
	end
	else begin
		op_port2_reg <= 8'bx;
	end
end

always @ * begin
	if (flit3[1:0] == HEAD) begin
		dest_x3 = flit3[4:2];
		dest_y3 = flit3[7:5];
		if (dest_x3 != my_x) begin
			if (dest_x3 >= my_x) begin
				op_port3_reg <= EAST;
			end
			else begin
				op_port3_reg <= WEST;
			end
		end
		else if (dest_y3 != my_y) begin
			if (dest_y3 >= my_y) begin
				op_port3_reg <= NORTH;
			end
			else begin
				op_port3_reg <= SOUTH;
			end
		end
		else begin
			op_port3_reg <= LOCAL;
		end
	end
	else if (flit3[1:0] == BODY || flit3[1:0] == TAIL) begin
		op_port3_reg <= op_port3;
	end
	else begin
		op_port3_reg <= 8'bx;
	end
end

always @ * begin
	if (flit4[1:0] == HEAD) begin
		dest_x4 = flit4[4:2];
		dest_y4 = flit4[7:5];
		if (dest_x4 != my_x) begin
			if (dest_x4 >= my_x) begin
				op_port4_reg <= EAST;
			end
			else begin
				op_port4_reg <= WEST;
			end
		end
		else if (dest_y4 != my_y) begin
			if (dest_y4 >= my_y) begin
				op_port4_reg <= NORTH;
			end
			else begin
				op_port4_reg <= SOUTH;
			end
		end
		else begin
			op_port4_reg <= LOCAL;
		end
	end
	else if (flit4[1:0] == BODY || flit4[1:0] == TAIL) begin
		op_port4_reg <= op_port4;
	end
	else begin
		op_port4_reg <= 8'bx;
	end
end



assign op_port0 = op_port0_reg;
assign op_port1 = op_port1_reg;
assign op_port2 = op_port2_reg;
assign op_port3 = op_port3_reg;
assign op_port4 = op_port4_reg;

endmodule
