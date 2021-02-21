`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// testing out the route compute unit by varying the flits entering each of the input ports.
// checking if output port is being calculated correctly and is held for entire duration
// of packet to implement wormhole router

module route_compute_tb();

localparam ROUTER_ID = 0;

reg clk;
reg rst;

reg [7:0] flit0;
reg [7:0] flit1;
reg [7:0] flit2;
reg [7:0] flit3;
reg [7:0] flit4;

wire [2:0] op_port0;
wire [2:0] op_port1;
wire [2:0] op_port2;
wire [2:0] op_port3;
wire [2:0] op_port4;

reg [3:0] router_id;

initial begin
	clk = 0;
	rst = 0;
	#1 rst = 1;
	#6 rst = 0;
end

always #5 clk = ~clk;

initial begin
	#15 flit0 = 8'b000_000_00;
	flit1 = 8'b000_011_00;
	flit2 = 8'b011_011_00;
	flit3 = 8'b011_000_00;
	flit4 = 8'b001_001_00;
	#10 flit0 = 8'b000_000_01;
	flit1 = 8'b000_000_01;
	flit2 = 8'b000_000_01;
	flit3 = 8'b000_000_01;
	flit4 = 8'b000_000_01;
	#10 flit0 = 8'b000_001_01;
	flit1 = 8'b000_001_01;
	flit2 = 8'b000_001_01;
	flit3 = 8'b000_001_01;
	flit4 = 8'b000_001_01;
	#10 flit0 = 8'b000_000_10;
	flit1 = 8'b000_000_10;
	flit2 = 8'b000_000_10;
	flit3 = 8'b000_000_10;
	flit4 = 8'b000_000_10;
//---------------------------------
	#10 flit0 = 8'bx;
	flit1 = 8'bx;
	flit2 = 8'bx;
	flit3 = 8'bx;
	flit4 = 8'bx;
//---------------------------------
	#10 flit0 = 8'b000_001_00;
	flit1 = 8'b011_001_00;
	flit2 = 8'b010_010_00;
	flit3 = 8'b001_011_00;
	flit4 = 8'b000_010_00;
	#10 flit0 = 8'b000_000_01;
	flit1 = 8'b000_000_01;
	flit2 = 8'b000_000_01;
	flit3 = 8'b000_000_01;
	flit4 = 8'b000_000_01;
	#10 flit0 = 8'b000_001_01;
	flit1 = 8'b000_001_01;
	flit2 = 8'b000_001_01;
	flit3 = 8'b000_001_01;
	flit4 = 8'b000_001_01;
	#10 flit0 = 8'b000_000_10;
	flit1 = 8'b000_000_10;
	flit2 = 8'b000_000_10;
	flit3 = 8'b000_000_10;
	flit4 = 8'b000_000_10;
end

route_compute #(.ROUTER_ID(ROUTER_ID)) RC (.clk(clk), .rst(rst), .flit0(flit0), .flit1(flit1), .flit2(flit2), .flit3(flit3), .flit4(flit4), .op_port0(op_port0), .op_port1(op_port1), .op_port2(op_port2), .op_port3(op_port3), .op_port4(op_port4));

initial begin
    $monitor("clk=%b, rst=%b, flit0=%b, flit1=%b, flit2=%b, flit3=%b, flit4=%b",clk, rst, flit0, flit1, flit2, flit3, flit4);
end

always #100 $finish;

endmodule