`timescale 1ns/100ps
// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// testing out a 4x4 mesh by injecting packets into each router. 
// No control over packet injection even if buffer is full.
// primitive bit complement traffic pattern.
module mesh_general_bc_tb();

reg clk, rst;
reg [7:0] local_in_flit [0:15];
reg local_wr_en [0:15];
reg local_ON_OFF [0:15];

wire [7:0] local_out_flit [0:15];
wire [7:0] router_out_full [0:15];

parameter MESH_COLUMNS = 4;
parameter MESH_ROWS = 4;
parameter BUFFER_DEPTH = 4;
parameter PORTS = 5;
parameter LINK_WIDTHS = 8;
integer i = 0;
integer counter;

always #5 clk = ~clk;

initial begin
	clk = 0;
	rst	= 0;
	#2 rst = 1;
	#6 rst = 0;
end

initial begin
	local_wr_en[0] = 0;
	local_wr_en[1] = 0;
	local_wr_en[2] = 0;
	local_wr_en[3] = 0;
	local_wr_en[4] = 0;
	local_wr_en[5] = 0;
	local_wr_en[6] = 0;
	local_wr_en[7] = 0;
	local_wr_en[8] = 0;
	local_wr_en[9] = 0;
	local_wr_en[10] = 0;
	local_wr_en[11] = 0;
	local_wr_en[12] = 0;
	local_wr_en[13] = 0;
	local_wr_en[14] = 0;
	local_wr_en[15] = 0;
	#500 $finish;
end

always @ (posedge clk) begin
	if (rst) begin
		counter = 0;
	end
	else if (counter == 4) begin
		counter = 0;
	end
	else begin
		counter = counter + 1;
	end
end

always @ (counter) begin
	if (counter == 1) begin
		local_wr_en[0] = 1;
		local_wr_en[1] = 1;
		local_wr_en[2] = 1;
		local_wr_en[3] = 1;
		local_wr_en[4] = 1;
		local_wr_en[5] = 1;
		local_wr_en[6] = 1;
		local_wr_en[7] = 1;
		local_wr_en[8] = 1;
		local_wr_en[9] = 1;
		local_wr_en[10] = 1;
		local_wr_en[11] = 1;
		local_wr_en[12] = 1;
		local_wr_en[13] = 1;
		local_wr_en[14] = 1;
		local_wr_en[15] = 1;
		//All the head flits for the bit complement 4x4 mesh
		local_in_flit[0] = 8'b011_011_00;
		local_in_flit[1] = 8'b011_010_00;
		local_in_flit[2] = 8'b011_001_00;
		local_in_flit[3] = 8'b011_000_00;
		local_in_flit[4] = 8'b010_011_00;
		local_in_flit[5] = 8'b010_010_00;
		local_in_flit[6] = 8'b010_001_00;
		local_in_flit[7] = 8'b010_000_00;
		local_in_flit[8] = 8'b001_011_00;
		local_in_flit[9] = 8'b001_010_00;
		local_in_flit[10] = 8'b001_001_00;
		local_in_flit[11] = 8'b001_000_00;
		local_in_flit[12] = 8'b000_011_00;
		local_in_flit[13] = 8'b000_010_00;
		local_in_flit[14] = 8'b000_001_00;
		local_in_flit[15] = 8'b000_000_00;
	end
	else if (counter == 2) begin
		local_in_flit[0] = 8'b000_000_01;
		local_in_flit[1] = 8'b000_001_01;
		local_in_flit[2] = 8'b000_010_01;
		local_in_flit[3] = 8'b000_011_01;
		local_in_flit[4] = 8'b000_100_01;
		local_in_flit[5] = 8'b000_101_01;
		local_in_flit[6] = 8'b000_110_01;
		local_in_flit[7] = 8'b000_111_01;
		local_in_flit[8] = 8'b001_000_01;
		local_in_flit[9] = 8'b001_001_01;
		local_in_flit[10] = 8'b001_010_01;
		local_in_flit[11] = 8'b001_011_01;
		local_in_flit[12] = 8'b001_100_01;
		local_in_flit[13] = 8'b001_101_01;
		local_in_flit[14] = 8'b001_110_01;
		local_in_flit[15] = 8'b001_111_01;
	end
	else if (counter == 3) begin
		local_in_flit[0] = 8'b010_000_01;
		local_in_flit[1] = 8'b010_001_01;
		local_in_flit[2] = 8'b010_010_01;
		local_in_flit[3] = 8'b010_011_01;
		local_in_flit[4] = 8'b010_100_01;
		local_in_flit[5] = 8'b010_101_01;
		local_in_flit[6] = 8'b010_110_01;
		local_in_flit[7] = 8'b010_111_01;
		local_in_flit[8] = 8'b011_000_01;
		local_in_flit[9] = 8'b011_001_01;
		local_in_flit[10] = 8'b011_010_01;
		local_in_flit[11] = 8'b011_011_01;
		local_in_flit[12] = 8'b011_100_01;
		local_in_flit[13] = 8'b011_101_01;
		local_in_flit[14] = 8'b011_110_01;
		local_in_flit[15] = 8'b011_111_01;
	end
	else if (counter == 4) begin
		local_in_flit[0] = 8'b100_000_10;
		local_in_flit[1] = 8'b100_001_10;
		local_in_flit[2] = 8'b100_010_10;
		local_in_flit[3] = 8'b100_011_10;
		local_in_flit[4] = 8'b100_100_10;
		local_in_flit[5] = 8'b100_101_10;
		local_in_flit[6] = 8'b100_110_10;
		local_in_flit[7] = 8'b100_111_10;
		local_in_flit[8] = 8'b101_000_10;
		local_in_flit[9] = 8'b101_001_10;
		local_in_flit[10] = 8'b101_010_10;
		local_in_flit[11] = 8'b101_011_10;
		local_in_flit[12] = 8'b101_100_10;
		local_in_flit[13] = 8'b101_101_10;
		local_in_flit[14] = 8'b101_110_10;
		local_in_flit[15] = 8'b101_111_10;
	end
	else begin
		local_wr_en[0] = 0;
		local_wr_en[1] = 0;
		local_wr_en[2] = 0;
		local_wr_en[3] = 0;
		local_wr_en[4] = 0;
		local_wr_en[5] = 0;
		local_wr_en[6] = 0;
		local_wr_en[7] = 0;
		local_wr_en[8] = 0;
		local_wr_en[9] = 0;
		local_wr_en[10] = 0;
		local_wr_en[11] = 0;
		local_wr_en[12] = 0;
		local_wr_en[13] = 0;
		local_wr_en[14] = 0;
		local_wr_en[15] = 0;
		local_ON_OFF[0] = 0;
		local_ON_OFF[1] = 0;
		local_ON_OFF[2] = 0;
		local_ON_OFF[3] = 0;
		local_ON_OFF[4] = 0;
		local_ON_OFF[5] = 0;
		local_ON_OFF[6] = 0;
		local_ON_OFF[7] = 0;
		local_ON_OFF[8] = 0;
		local_ON_OFF[9] = 0;
		local_ON_OFF[10] = 0;
		local_ON_OFF[11] = 0;
		local_ON_OFF[12] = 0;
		local_ON_OFF[13] = 0;
		local_ON_OFF[14] = 0;
		local_ON_OFF[15] = 0;
	end
end

//Mesh instantiation is left. Ill have to look at it as right now I dont have access to the linux server.
mesh_general #(
	.MESH_COLUMNS(MESH_COLUMNS),
	.MESH_ROWS(MESH_ROWS),
	.LINK_WIDTHS(LINK_WIDTHS),
	.BUFFER_DEPTH(BUFFER_DEPTH),
	.PORTS(PORTS)
) mesh_2x2_inst (
	.clk(clk),
	.rst(rst),
	.local_in_flit(local_in_flit),
	.local_wr_en(local_wr_en),
	.local_ON_OFF(local_ON_OFF),
	.local_out_flit(local_out_flit),
	.router_out_full(router_out_full)
);

endmodule // mesh_general_bc_tb