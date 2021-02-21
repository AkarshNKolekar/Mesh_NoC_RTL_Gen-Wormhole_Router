`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is the rtl to generate a generic mesh topology.
// The default parameters can be overidden in the testbench.

module mesh_general #(
	parameter MESH_COLUMNS = 4,
	parameter MESH_ROWS = 4,
	parameter LINK_WIDTHS = 8,
	parameter BUFFER_DEPTH = 4,
	parameter PORTS = 5
)(
	input clk,
	input rst,
	input [LINK_WIDTHS-1:0] local_in_flit [0:MESH_ROWS*MESH_COLUMNS-1],
	input local_wr_en [0:MESH_ROWS*MESH_COLUMNS-1],
	input local_ON_OFF [0:MESH_ROWS*MESH_COLUMNS-1],
	output [LINK_WIDTHS-1:0] local_out_flit [0:MESH_ROWS*MESH_COLUMNS-1],
	output router_out_full [0:MESH_ROWS*MESH_COLUMNS-1]
);

localparam NUM_ROUTERS = MESH_ROWS*MESH_COLUMNS;
localparam VERTICAL = MESH_ROWS*(MESH_COLUMNS+1);
// l - left
// r - right
// b - bottom
// t - top
// following are the links connecting routers
wire [LINK_WIDTHS-1:0] l_r_flit [0:NUM_ROUTERS];
wire [LINK_WIDTHS-1:0] r_l_flit [0:NUM_ROUTERS];
wire [LINK_WIDTHS-1:0] b_t_flit [0:VERTICAL-1];	
wire [LINK_WIDTHS-1:0] t_b_flit [0:VERTICAL-1];

// wr_en - write enables
wire l_r_wr_en [0:NUM_ROUTERS];	//First and last wire left hanging
wire r_l_wr_en [0:NUM_ROUTERS];
wire b_t_wr_en [0:VERTICAL-1];
wire t_b_wr_en [0:VERTICAL-1];

wire l_r_buf_control [0:NUM_ROUTERS];
wire r_l_buf_control [0:NUM_ROUTERS];
wire b_t_buf_control [0:VERTICAL-1];
wire t_b_buf_control [0:VERTICAL-1];
// generate variables to create mesh in each dimension
genvar row;
genvar column;
generate
	for (row=0; row<MESH_ROWS; row=row+1) begin
		for (column=0; column<MESH_COLUMNS; column=column+1) begin
			Router #(
				.LINK_WIDTH(LINK_WIDTHS),
				.PORTS(PORTS),
				.BUFFER_DEPTH(BUFFER_DEPTH),
				.MESH_DIM(MESH_ROWS),
				.ROUTER_ID(column+MESH_COLUMNS*row)
			) router_main_dut (
				.clk(clk),
				.rst(rst),
				.router_out_wr_en_0(b_t_wr_en[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_out_wr_en_1(l_r_wr_en[column+MESH_COLUMNS*row+1]),
				.router_out_wr_en_2(t_b_wr_en[column+MESH_COLUMNS*row]),
				.router_out_wr_en_3(r_l_wr_en[column+MESH_COLUMNS*row]),
				//.router_out_wr_en_4(router_out_wr_en_4),
				.router_in_flit_0(t_b_flit[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_in_flit_1(r_l_flit[column+MESH_COLUMNS*row+1]),
				.router_in_flit_2(b_t_flit[column+MESH_COLUMNS*row]),
				.router_in_flit_3(l_r_flit[column+MESH_COLUMNS*row]),
				.router_in_flit_4(local_in_flit[column+MESH_COLUMNS*row]),
				.router_out_flit_0(b_t_flit[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_out_flit_1(l_r_flit[column+MESH_COLUMNS*row+1]),
				.router_out_flit_2(t_b_flit[column+MESH_COLUMNS*row]),
				.router_out_flit_3(r_l_flit[column+MESH_COLUMNS*row]),
				.router_out_flit_4(local_out_flit[column+MESH_COLUMNS*row]),
				.router_in_wr_en_0(t_b_wr_en[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_in_wr_en_1(r_l_wr_en[column+MESH_COLUMNS*row+1]),
				.router_in_wr_en_2(b_t_wr_en[column+MESH_COLUMNS*row]),
				.router_in_wr_en_3(l_r_wr_en[column+MESH_COLUMNS*row]),
				.router_in_wr_en_4(local_wr_en[column+MESH_COLUMNS*row]),
				.router_out_full_0(b_t_buf_control[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_out_full_1(l_r_buf_control[column+MESH_COLUMNS*row+1]),
				.router_out_full_2(t_b_buf_control[column+MESH_COLUMNS*row]),
				.router_out_full_3(r_l_buf_control[column+MESH_COLUMNS*row]),
				.router_out_full_4(router_out_full[column+MESH_COLUMNS*row]),
				.router_in_ON_OFF_0(t_b_buf_control[column+MESH_COLUMNS*row+MESH_ROWS]),
				.router_in_ON_OFF_1(r_l_buf_control[column+MESH_COLUMNS*row+1]),
				.router_in_ON_OFF_2(b_t_buf_control[column+MESH_COLUMNS*row]),
				.router_in_ON_OFF_3(l_r_buf_control[column+MESH_COLUMNS*row])
				//.router_in_ON_OFF_4(router_in_ON_OFF_4)
			);
		end
	end
endgenerate
endmodule
