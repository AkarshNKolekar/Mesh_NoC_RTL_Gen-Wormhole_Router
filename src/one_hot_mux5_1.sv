`timescale 1ns/100ps

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu

// This is the crossbar switch module of the Switch Allocator.
// Selects which input buffer to read flit from based on grant received from round robin arbiter.

module one_hot_mux5_1 (input_buffer0, 
			input_buffer1, 
			input_buffer2, 
			input_buffer3, 
			input_buffer4, 
			select, 
			op_flit);

input [7:0] input_buffer0;
input [7:0] input_buffer1;
input [7:0] input_buffer2;
input [7:0] input_buffer3;
input [7:0] input_buffer4;

input [4:0] select;

output reg [7:0] op_flit;

always @(input_buffer0, input_buffer1, input_buffer2, input_buffer3, input_buffer4, select) begin
	case (select)
		5'b00001: begin
			op_flit = input_buffer0; // read the north input buffer
			end
		5'b00010: begin
			op_flit = input_buffer1; // read the east input buffer
			end
		5'b00100: begin
			op_flit = input_buffer2; // read the south input buffer
			end
		5'b01000: begin
			op_flit = input_buffer3; // read the west input buffer
			end
		5'b10000: begin
			op_flit = input_buffer4; // read the local input buffer
			end
		default: begin
			op_flit = 8'bx; // if no grant is given
			end
	endcase
end

endmodule