`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This testbench implements bit-complement synthetic traffic pattern
// for a 4x4 mesh topology.

module mesh_general_4x4_bc_tb();

// clock and reset signals
reg clk, rst;
// 16 input flit (width = 8bits) registers to inject flits into each router of the mesh
reg [7:0] local_in_flit [0:15];
// local write enable signal. Set to 1 if flit is being injected into the local buffer of the router
reg local_wr_en [0:15];
// if the local buffer is full, packets are not injected into the router by the core (testbench)
reg local_ON_OFF [0:15];
// flit coming out of the router. router is final destination of packet.
wire [7:0] local_out_flit [0:15];
// signal from router telling us that its input buffer is full 
wire router_out_full [0:15];
// dimensions of the mesh topology which can be varied
parameter MESH_COLUMNS = 4;
parameter MESH_ROWS = 4;
parameter BUFFER_DEPTH = 4;
parameter PORTS = 5;
parameter LINK_WIDTHS = 8;
// This parameter can be anything greater than 0, lesser than or equal to 1.
// Packets are injected into the network at this rate.
parameter RATE = 1;
localparam CYCLES = ((1/RATE)*4)-1;

integer i = 0;
//Counters for every router to calculate when to inject packets into the network
reg [7:0] counter0;
reg [7:0] counter1;
reg [7:0] counter2;
reg [7:0] counter3;
reg [7:0] counter4;
reg [7:0] counter5;
reg [7:0] counter6;
reg [7:0] counter7;
reg [7:0] counter8;
reg [7:0] counter9;
reg [7:0] counter10;
reg [7:0] counter11;
reg [7:0] counter12;
reg [7:0] counter13;
reg [7:0] counter14;
reg [7:0] counter15;
//clock toggling
always #5 clk = ~clk;

initial begin
	clk = 0;
	rst	= 0;
	#2 rst = 1;
	#6 rst = 0;
end
//we're saying that no valid flits are being injected into the network initially
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
	#1000 $finish;
end
// counter is incremented every clock cycle unless the router tells us 
// that it's input buffer is full. The counter is reset to 0 if the reset
// signal is set high, or if the counter overflows.
always @ (posedge clk) begin
	if (rst) begin
		counter0 <= 0;
	end
	else if (router_out_full[0]) begin
		counter0 <= counter0;
	end
	else if (counter0 > CYCLES) begin
		counter0 <= 0;
	end
	else begin
		counter0 <= counter0 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter1 <= 0;
	end
	else if (router_out_full[1]) begin
		counter1 <= counter1;
	end
	else if (counter1 > CYCLES) begin
		counter1 <= 0;
	end
	else begin
		counter1 <= counter1 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter2 <= 0;
	end
	else if (router_out_full[2]) begin
		counter2 <= counter2;
	end
	else if (counter2 > CYCLES) begin
		counter2 <= 0;
	end
	else begin
		counter2 <= counter2 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter3 <= 0;
	end
	else if (router_out_full[3]) begin
		counter3 <= counter3;
	end
	else if (counter3 > CYCLES) begin
		counter3 <= 0;
	end
	else begin
		counter3 <= counter3 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter4 <= 0;
	end
	else if (router_out_full[4]) begin
		counter4 <= counter4;
	end
	else if (counter4 > CYCLES) begin
		counter4 <= 0;
	end
	else begin
		counter4 <= counter4 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter5 <= 0;
	end
	else if (router_out_full[5]) begin
		counter5 <= counter5;
	end
	else if (counter5 > CYCLES) begin
		counter5 <= 0;
	end
	else begin
		counter5 <= counter5 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter6 <= 0;
	end
	else if (router_out_full[6]) begin
		counter6 <= counter6;
	end
	else if (counter6 > CYCLES) begin
		counter6 <= 0;
	end
	else begin
		counter6 <= counter6 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter7 <= 0;
	end
	else if (router_out_full[7]) begin
		counter7 <= counter7;
	end
	else if (counter7 > CYCLES) begin
		counter7 <= 0;
	end
	else begin
		counter7 <= counter7 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter8 <= 0;
	end
	else if (router_out_full[8]) begin
		counter8 <= counter8;
	end
	else if (counter8 > CYCLES) begin
		counter8 <= 0;
	end
	else begin
		counter8 <= counter8 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter9 <= 0;
	end
	else if (router_out_full[9]) begin
		counter9 <= counter9;
	end
	else if (counter9 > CYCLES) begin
		counter9 <= 0;
	end
	else begin
		counter9 <= counter9 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter10 <= 0;
	end
	else if (router_out_full[10]) begin
		counter10 <= counter10;
	end
	else if (counter10 > CYCLES) begin
		counter10 <= 0;
	end
	else begin
		counter10 <= counter10 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter11 <= 0;
	end
	else if (router_out_full[11]) begin
		counter11 <= counter11;
	end
	else if (counter11 > CYCLES) begin
		counter11 <= 0;
	end
	else begin
		counter11 <= counter11 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter12 <= 0;
	end
	else if (router_out_full[12]) begin
		counter12 <= counter12;
	end
	else if (counter12 > CYCLES) begin
		counter12 <= 0;
	end
	else begin
		counter12 <= counter12 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter13 <= 0;
	end
	else if (router_out_full[13]) begin
		counter13 <= counter13;
	end
	else if (counter13 > CYCLES) begin
		counter13 <= 0;
	end
	else begin
		counter13 <= counter13 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter14 <= 0;
	end
	else if (router_out_full[14]) begin
		counter14 <= counter14;
	end
	else if (counter14 > CYCLES) begin
		counter14 <= 0;
	end
	else begin
		counter14 <= counter14 + 1;
	end
end

always @ (posedge clk) begin
	if (rst) begin
		counter15 <= 0;
	end
	else if (router_out_full[15]) begin
		counter15 <= counter15;
	end
	else if (counter15 > CYCLES) begin
		counter15 <= 0;
	end
	else begin
		counter15 <= counter15 + 1;
	end
end
// everytime the counter changes, we check what the value of the counter is
// and inject the according flit into the network. Since we assume a packet
// to contain 4 flits to be sent in order, only X is sent onto the link post
// the tail flit. The head flit's 6 MSB bits signify the destination coordinates.
// Traffic pattern can be modified by making changes to the head flits values.
always @ (counter0) begin
	if (!router_out_full[0]) begin
		if (counter0 == 1) begin 
			local_wr_en[0] = 1;
			local_in_flit[0] = 8'b011_011_00;
		end
		else if (counter0 == 2) begin
			local_wr_en[0] = 1;
			local_in_flit[0] = 8'b000_000_01;
		end
		else if (counter0 == 3) begin
			local_wr_en[0] = 1;
			local_in_flit[0] = 8'b010_000_01;
		end
		else if (counter0 == 4) begin
			local_wr_en[0] = 1;
			local_in_flit[0] = 8'b100_000_10;
		end
		else begin
			local_wr_en[0] = 0;
			local_in_flit[0] = 8'bx;
		end
	end
	else begin
		local_wr_en[0] = 0;
		local_in_flit[0] = 8'bx;
	end
end

always @ (counter1) begin
	if (!router_out_full[1]) begin
		if (counter1 == 1) begin 
			local_wr_en[1] = 1;
			local_in_flit[1] = 8'b011_010_00;
		end
		else if (counter1 == 2) begin
			local_wr_en[1] = 1;
			local_in_flit[1] = 8'b000_001_01;
		end
		else if (counter1 == 3) begin
			local_wr_en[1] = 1;
			local_in_flit[1] = 8'b010_001_01;
		end
		else if (counter1 == 4) begin
			local_wr_en[1] = 1;
			local_in_flit[1] = 8'b100_001_10;
		end
		else begin
			local_wr_en[1] = 0;
			local_in_flit[1] = 8'bx;
		end
	end
	else begin
		local_wr_en[1] = 0;
		local_in_flit[1] = 8'bx;
	end
end

always @ (counter2) begin
	if (!router_out_full[2]) begin
		if (counter2 == 1) begin 
			local_wr_en[2] = 1;
			local_in_flit[2] = 8'b011_001_00;
		end
		else if (counter2 == 2) begin
			local_wr_en[2] = 1;
			local_in_flit[2] = 8'b000_010_01;
		end
		else if (counter2 == 3) begin
			local_wr_en[2] = 1;
			local_in_flit[2] = 8'b010_010_01;
		end
		else if (counter2 == 4) begin
			local_wr_en[2] = 1;
			local_in_flit[2] = 8'b100_010_10;
		end
		else begin
			local_wr_en[2] = 0;
			local_in_flit[2] = 8'bx;
		end
	end
	else begin
		local_wr_en[2] = 0;
		local_in_flit[2] = 8'bx;
	end
end

always @ (counter3) begin
	if (!router_out_full[3]) begin
		if (counter3 == 1) begin 
			local_wr_en[3] = 1;
			local_in_flit[3] = 8'b011_000_00;
		end
		else if (counter3 == 2) begin
			local_wr_en[3] = 1;
			local_in_flit[3] = 8'b000_011_01;
		end
		else if (counter3 == 3) begin
			local_wr_en[3] = 1;
			local_in_flit[3] = 8'b010_011_01;
		end
		else if (counter3 == 4) begin
			local_wr_en[3] = 1;
			local_in_flit[3] = 8'b100_011_10;
		end
		else begin
			local_wr_en[3] = 0;
			local_in_flit[3] = 8'bx;
		end
	end
	else begin
		local_wr_en[3] = 0;
		local_in_flit[3] = 8'bx;
	end
end

always @ (counter4) begin
	if (!router_out_full[4]) begin
		if (counter4 == 1) begin 
			local_wr_en[4] = 1;
			local_in_flit[4] = 8'b010_011_00;
		end
		else if (counter4 == 2) begin
			local_wr_en[4] = 1;
			local_in_flit[4] = 8'b000_100_01;
		end
		else if (counter4 == 3) begin
			local_wr_en[4] = 1;
			local_in_flit[4] = 8'b010_100_01;
		end
		else if (counter4 == 4) begin
			local_wr_en[4] = 1;
			local_in_flit[4] = 8'b100_100_10;
		end
		else begin
			local_wr_en[4] = 0;
			local_in_flit[4] = 8'bx;
		end
	end
	else begin
		local_wr_en[4] = 0;
		local_in_flit[4] = 8'bx;
	end
end

always @ (counter5) begin
	if (!router_out_full[5]) begin
		if (counter5 == 1) begin 
			local_wr_en[5] = 1;
			local_in_flit[5] = 8'b010_010_00;
		end
		else if (counter5 == 2) begin
			local_wr_en[5] = 1;
			local_in_flit[5] = 8'b000_101_01;
		end
		else if (counter5 == 3) begin
			local_wr_en[5] = 1;
			local_in_flit[5] = 8'b010_101_01;
		end
		else if (counter5 == 4) begin
			local_wr_en[5] = 1;
			local_in_flit[5] = 8'b100_101_10;
		end
		else begin
			local_wr_en[5] = 0;
			local_in_flit[5] = 8'bx;
		end
	end
	else begin
		local_wr_en[5] = 0;
		local_in_flit[5] = 8'bx;
	end
end

always @ (counter6) begin
	if (!router_out_full[6]) begin
		if (counter6 == 1) begin 
			local_wr_en[6] = 1;
			local_in_flit[6] = 8'b010_001_00;
		end
		else if (counter6 == 2) begin
			local_wr_en[6] = 1;
			local_in_flit[6] = 8'b000_110_01;
		end
		else if (counter6 == 3) begin
			local_wr_en[6] = 1;
			local_in_flit[6] = 8'b010_110_01;
		end
		else if (counter6 == 4) begin
			local_wr_en[6] = 1;
			local_in_flit[6] = 8'b100_110_10;
		end
		else begin
			local_wr_en[6] = 0;
			local_in_flit[6] = 8'bx;
		end
	end
	else begin
		local_wr_en[6] = 0;
		local_in_flit[6] = 8'bx;
	end
end

always @ (counter7) begin
	if (!router_out_full[7]) begin
		if (counter7 == 1) begin 
			local_wr_en[7] = 1;
			local_in_flit[7] = 8'b010_000_00;
		end
		else if (counter7 == 2) begin
			local_wr_en[7] = 1;
			local_in_flit[7] = 8'b000_111_01;
		end
		else if (counter7 == 3) begin
			local_wr_en[7] = 1;
			local_in_flit[7] = 8'b010_111_01;
		end
		else if (counter7 == 4) begin
			local_wr_en[7] = 1;
			local_in_flit[7] = 8'b100_111_10;
		end
		else begin
			local_wr_en[7] = 0;
			local_in_flit[7] = 8'bx;
		end
	end
	else begin
		local_wr_en[7] = 0;
		local_in_flit[7] = 8'bx;
	end
end

always @ (counter8) begin
	if (!router_out_full[8]) begin
		if (counter8 == 1) begin 
			local_wr_en[8] = 1;
			local_in_flit[8] = 8'b001_011_00;
		end
		else if (counter8 == 2) begin
			local_wr_en[8] = 1;
			local_in_flit[8] = 8'b001_000_01;
		end
		else if (counter8 == 3) begin
			local_wr_en[8] = 1;
			local_in_flit[8] = 8'b011_000_01;
		end
		else if (counter8 == 4) begin
			local_wr_en[8] = 1;
			local_in_flit[8] = 8'b101_000_10;
		end
		else begin
			local_wr_en[8] = 0;
			local_in_flit[8] = 8'bx;
		end
	end
	else begin
		local_wr_en[8] = 0;
		local_in_flit[8] = 8'bx;
	end
end

always @ (counter9) begin
	if (!router_out_full[9]) begin
		if (counter9 == 1) begin 
			local_wr_en[9] = 1;
			local_in_flit[9] = 8'b001_010_00;
		end
		else if (counter9 == 2) begin
			local_wr_en[9] = 1;
			local_in_flit[9] = 8'b001_001_01;
		end
		else if (counter9 == 3) begin
			local_wr_en[9] = 1;
			local_in_flit[9] = 8'b011_001_01;
		end
		else if (counter9 == 4) begin
			local_wr_en[9] = 1;
			local_in_flit[9] = 8'b101_001_10;
		end
		else begin
			local_wr_en[9] = 0;
			local_in_flit[9] = 8'bx;
		end
	end
	else begin
		local_wr_en[9] = 0;
		local_in_flit[9] = 8'bx;
	end
end

always @ (counter10) begin
	if (!router_out_full[10]) begin
		if (counter10 == 1) begin 
			local_wr_en[10] = 1;
			local_in_flit[10] = 8'b001_001_00;
		end
		else if (counter10 == 2) begin
			local_wr_en[10] = 1;
			local_in_flit[10] = 8'b001_010_01;
		end
		else if (counter10 == 3) begin
			local_wr_en[10] = 1;
			local_in_flit[10] = 8'b011_010_01;
		end
		else if (counter10 == 4) begin
			local_wr_en[10] = 1;
			local_in_flit[10] = 8'b101_010_10;
		end
		else begin
			local_wr_en[10] = 0;
			local_in_flit[10] = 8'bx;
		end
	end
	else begin
		local_wr_en[10] = 0;
		local_in_flit[10] = 8'bx;
	end
end

always @ (counter11) begin
	if (!router_out_full[11]) begin
		if (counter11 == 1) begin 
			local_wr_en[11] = 1;
			local_in_flit[11] = 8'b001_000_00;
		end
		else if (counter11 == 2) begin
			local_wr_en[11] = 1;
			local_in_flit[11] = 8'b001_011_01;
		end
		else if (counter11 == 3) begin
			local_wr_en[11] = 1;
			local_in_flit[11] = 8'b011_011_01;
		end
		else if (counter11 == 4) begin
			local_wr_en[11] = 1;
			local_in_flit[11] = 8'b101_011_10;
		end
		else begin
			local_wr_en[11] = 0;
			local_in_flit[11] = 8'bx;
		end
	end
	else begin
		local_wr_en[11] = 0;
		local_in_flit[11] = 8'bx;
	end
end

always @ (counter12) begin
	if (!router_out_full[12]) begin
		if (counter12 == 1) begin 
			local_wr_en[12] = 1;
			local_in_flit[12] = 8'b000_011_00;
		end
		else if (counter12 == 2) begin
			local_wr_en[12] = 1;
			local_in_flit[12] = 8'b001_100_01;
		end
		else if (counter12 == 3) begin
			local_wr_en[12] = 1;
			local_in_flit[12] = 8'b011_100_01;
		end
		else if (counter12 == 4) begin
			local_wr_en[12] = 1;
			local_in_flit[12] = 8'b101_100_10;
		end
		else begin
			local_wr_en[12] = 0;
			local_in_flit[12] = 8'bx;
		end
	end
	else begin
		local_wr_en[12] = 0;
		local_in_flit[12] = 8'bx;
	end
end

always @ (counter13) begin
	if (!router_out_full[13]) begin
		if (counter13 == 1) begin 
			local_wr_en[13] = 1;
			local_in_flit[13] = 8'b000_010_00;
		end
		else if (counter13 == 2) begin
			local_wr_en[13] = 1;
			local_in_flit[13] = 8'b001_101_01;
		end
		else if (counter13 == 3) begin
			local_wr_en[13] = 1;
			local_in_flit[13] = 8'b011_101_01;
		end
		else if (counter13 == 4) begin
			local_wr_en[13] = 1;
			local_in_flit[13] = 8'b101_101_10;
		end
		else begin
			local_wr_en[13] = 0;
			local_in_flit[13] = 8'bx;
		end
	end
	else begin
		local_wr_en[13] = 0;
		local_in_flit[13] = 8'bx;
	end
end

always @ (counter14) begin
	if (!router_out_full[14]) begin
		if (counter14 == 1) begin 
			local_wr_en[14] = 1;
			local_in_flit[14] = 8'b000_001_00;
		end
		else if (counter14 == 2) begin
			local_wr_en[14] = 1;
			local_in_flit[14] = 8'b001_110_01;
		end
		else if (counter14 == 3) begin
			local_wr_en[14] = 1;
			local_in_flit[14] = 8'b011_110_01;
		end
		else if (counter14 == 4) begin
			local_wr_en[14] = 1;
			local_in_flit[14] = 8'b101_110_10;
		end
		else begin
			local_wr_en[14] = 0;
			local_in_flit[14] = 8'bx;
		end
	end
	else begin
		local_wr_en[14] = 0;
		local_in_flit[14] = 8'bx;
	end
end

always @ (counter15) begin
	if (!router_out_full[15]) begin
		if (counter15 == 1) begin 
			local_wr_en[15] = 1;
			local_in_flit[15] = 8'b000_000_00;
		end
		else if (counter15 == 2) begin
			local_wr_en[15] = 1;
			local_in_flit[15] = 8'b001_111_01;
		end
		else if (counter15 == 3) begin
			local_wr_en[15] = 1;
			local_in_flit[15] = 8'b011_111_01;
		end
		else if (counter15 == 4) begin
			local_wr_en[15] = 1;
			local_in_flit[15] = 8'b101_111_10;
		end
		else begin
			local_wr_en[15] = 0;
			local_in_flit[15] = 8'bx;
		end
	end
	else begin
		local_wr_en[15] = 0;
		local_in_flit[15] = 8'bx;
	end
end
//instantiation of the mesh topology
mesh_general #(
	.MESH_COLUMNS(MESH_COLUMNS),
	.MESH_ROWS(MESH_ROWS),
	.LINK_WIDTHS(LINK_WIDTHS),
	.BUFFER_DEPTH(BUFFER_DEPTH),
	.PORTS(PORTS)
) mesh_4x4_inst (
	.clk(clk),
	.rst(rst),
	.local_in_flit(local_in_flit),
	.local_wr_en(local_wr_en),
	.local_ON_OFF(local_ON_OFF),
	.local_out_flit(local_out_flit),
	.router_out_full(router_out_full)
);

endmodule
