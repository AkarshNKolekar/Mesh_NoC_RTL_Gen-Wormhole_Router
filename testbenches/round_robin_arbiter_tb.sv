`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// testing out the round robin arbiter

module round_robin_arbiter_tb ();

wire [4:0] grant;
reg  clk;
reg [4:0]  req;
reg ON_OFF_signal;
reg rst;

always #5 clk = ~clk;
//checking if request gets serviced and how many cycles it gets a priority for
initial begin
	clk = 1'b0;
	req = 5'b00000;
	ON_OFF_signal = 1'b0;
	rst = 1'b0;
	#2.5 rst = 1'b1;
	#5 rst = 1'b0;
	#2.5 req = 5'b00011;
end

round_robin_arbiter rra (.clk(clk), .req(req), .grant(grant), .ON_OFF_signal(ON_OFF_signal), .rst(rst));

always #200 $finish;

endmodule