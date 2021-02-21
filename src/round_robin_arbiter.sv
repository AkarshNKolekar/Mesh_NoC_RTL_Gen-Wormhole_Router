`timescale 1ns/100ps
// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//		 Abhishek Upadhyay - aupadhyay31@gatech.edu
// This is the round robin arbiter. 
// It chooses which input port buffer gets priority to use an output port.
// Each input buffer packet gets priority for 4 cycles in a round robin manner.
// This is because each packet consists of 4 flits.
// If the downstream buffer is full, the ON/OFF signal ensures that 
// the packet gets priority until the whole packet is trasmitted to the downstream router.
module round_robin_arbiter
  #(parameter NUM_PORTS = 5) (clk,
			      rst,
			      req, 
			      ON_OFF_signal, 
			      grant);
   
   output reg [NUM_PORTS-1:0] grant;
   
   input 		      clk;
   input 		      rst;
   
   input [NUM_PORTS-1:0]      req;
   input 		      ON_OFF_signal;
   
   localparam [2:0] s_ideal=3'b000;
   localparam [2:0] s0=3'b001;
   localparam [2:0] s1=3'b010;
   localparam [2:0] s2=3'b011;
   localparam [2:0] s3=3'b100;
   localparam [2:0] s4=3'b101;
   
   reg [2:0] 		      state;
   reg [2:0] 		      next_state;
   reg [1:0] 		      count;
   reg 			      inc_cnt;
   reg 			      clr_cnt;
   reg 			      init_cnt;
   
   always @(posedge clk) begin
      if (rst) begin
	 state <= s_ideal;
      end
      else begin
	 state <= next_state;
      end
   end
   
   always @ (posedge clk) begin
      if (clr_cnt | rst) begin
	 count <= 0;
      end
      else if (init_cnt) begin
	 count <= 2'b00;
      end
      else if (ON_OFF_signal) begin
	 count <= count;
      end
      else if (inc_cnt) begin
	 count <= count + 2'b01;
      end
      else begin
	 count <= count;
      end
   end
   
   always @* begin
      inc_cnt = 0;
      clr_cnt = 0;
      init_cnt = 0;
      next_state = state;
      case (state)
	s0: begin
	   if (ON_OFF_signal) begin
	      grant = 5'b00000;
	   end
	   else if (req[0]) begin
	      if(count==2'b11) begin
		 if (req[1]) begin
		    clr_cnt = 1;
		    grant = 5'b00010;
		    next_state = s1;
		 end
		 else if (req[2]) begin
		    clr_cnt = 1;
		    grant = 5'b00100;
		    next_state = s2;
		 end
    		 else if (req[3]) begin
		    clr_cnt = 1;
		    grant = 5'b01000;
		    next_state = s3;
		 end
		 else if (req[4]) begin
		    clr_cnt = 1;
		    grant = 5'b10000;
		    next_state = s4;
		 end
		 else begin
		    clr_cnt = 1;
		    grant = 5'b00001;
		    next_state = s0;
		 end
	      end // if (count==2'b11)
	      else begin
		 inc_cnt = 1;
		 grant = 5'b00001;
	      end // else: !if(count==2'b11)
   	   end // if (req[0])
	   else if (req[1]) begin
	      grant = 5'b00010;
	      next_state = s1;
	      clr_cnt = 1;
   	   end
	   else if (req[2]) begin
	      next_state = s2;
	      grant = 5'b00100;
	      clr_cnt = 1;
   	   end
	   else if (req[3]) begin
	      next_state = s3;
	      grant = 5'b01000;
	      clr_cnt = 1;
   	   end
	   else if (req[4]) begin
	      next_state = s4;
	      clr_cnt = 1;
	      grant = 5'b10000;
	   end
	   else begin
	      clr_cnt = 1;
	      grant = 5'b00000;
	      next_state = s_ideal;
   	   end
	end // case: s0
	
   	s1: begin
           if (ON_OFF_signal) begin
	      grant = 5'b00000;
           end
           else if (req[1]) begin
      	      if (count==2'b11) begin
    		 if (req[2]) begin
         	    clr_cnt = 1;
         	    grant = 5'b00100;
		    next_state = s2;
      		 end
    		 else if (req[3]) begin
         	    clr_cnt = 1;
         	    grant = 5'b01000;
		    next_state = s3;
      		 end
		 else if (req[4]) begin
		    clr_cnt = 1;
		    grant = 5'b10000;
		    next_state = s4;
		 end
    		 else if (req[0]) begin
         	    clr_cnt = 1;
         	    grant = 5'b00001;
		    next_state = s0;
      		 end
    		 else begin
         	    clr_cnt = 1;
         	    grant = 5'b00010;
		    next_state = s1;
      		 end
              end // if (count==2'b11)
      	      else begin
    		 inc_cnt = 1;
		 grant = 5'b00010;
              end // else: !if(count==2'b11)
   	   end // if (req[1])
           else if (req[2]) begin
      	      clr_cnt = 1;
      	      grant = 5'b00100;
	      next_state = s2;
   	   end
           else if (req[3]) begin
      	      clr_cnt = 1;
      	      grant = 5'b01000;
	      next_state = s3;
   	   end
	   else if (req[4]) begin
	      clr_cnt = 1;
	      grant = 5'b10000;
	      next_state = s4;
           end
           else if (req[0]) begin
      	      clr_cnt = 1;
      	      grant = 5'b00001;
	      next_state = s0;
   	   end
           else begin
      	      clr_cnt = 1;
      	      grant = 5'b00000;
	      next_state = s_ideal;
   	   end
     	end // case: s1
	
	
	
   	s2: begin
           if (ON_OFF_signal) begin
	      grant = 5'b00000;
           end
       	   else if (req[2]) begin
      	      if (count==2'b11) begin
    		 if (req[3]) begin
         	    clr_cnt = 1;
         	    grant = 5'b01000;
		    next_state = s3;
      		 end
		 else if (req[4]) begin
		    clr_cnt = 1;
		    grant = 5'b10000;
		    next_state = s4;
		 end
    		 else if (req[0]) begin
         	    clr_cnt = 1;
         	    grant = 5'b00001;
		    next_state = s0;
		 end
    		 else if (req[1]) begin
         	    clr_cnt = 1;
         	    grant = 5'b00010;
		    next_state = s1;
		 end
    		 else begin
         	    clr_cnt = 1;
         	    grant = 5'b00100;
		    next_state = s2;
		 end
              end // if (count==2'b11)
      	      else begin
    		 inc_cnt = 1;
		 grant = 5'b00100;
              end // else: !if(count==2'b11)
   	   end // if (req[2])
           else if (req[3]) begin
      	      clr_cnt = 1;
      	      grant = 5'b01000;
	      next_state = s3;
   	   end
	   else if (req[4]) begin
	      clr_cnt = 1;
	      grant = 5'b10000;
	      next_state = s4;
           end
           else if (req[0]) begin
      	      clr_cnt = 1;
      	      grant = 5'b00001;
	      next_state = s0;
   	   end
           else if (req[1]) begin
      	      clr_cnt = 1;
      	      grant = 5'b00010;
	      next_state = s1;
   	   end
           else begin
      	      clr_cnt = 1;
      	      grant = 5'b00000;
	      next_state = s_ideal;
   	   end
	end // case: s2
	
	s3: begin
           if (ON_OFF_signal) begin
	      grant = 5'b00000;
           end
           else if (req[3]) begin
	      if (count==2'b11) begin
		 if (req[4]) begin
		    clr_cnt = 1;
		    grant = 5'b10000;
		    next_state = s4;
		 end
		 else if (req[0]) begin
		    clr_cnt = 1;
		    grant = 5'b00001;
		    next_state = s0;
		 end
		 else if (req[1]) begin
		    clr_cnt = 1;
		    grant = 5'b00010;
		    next_state = s1;
		 end
		 else if (req[2]) begin
		    clr_cnt = 1;
		    grant = 5'b00100;
		    next_state = s2;
		 end
		 else begin
		    clr_cnt = 1;
		    grant = 5'b01000;
		    next_state = s3;
		 end
	      end // if (count==2'b11)
	      else begin
		 grant = 5'b01000;
		 inc_cnt = 1;
	      end // else: !if(count==2'b11)
           end // if (req[2])
           else if (req[4]) begin
	      clr_cnt = 1;
	      grant = 5'b10000;
	      next_state = s4;
           end
           else if (req[0]) begin
	      clr_cnt = 1;
	      grant = 5'b00001;
	      next_state = s0;
           end
           else if (req[1]) begin
	      clr_cnt = 1;
	      grant = 5'b00010;
	      next_state = s1;
           end
           else if (req[2]) begin
	      clr_cnt = 1;
	      grant = 5'b00100;
	      next_state = s2;
           end
           else begin
	      clr_cnt = 1;
	      grant = 5'b00000;
	      next_state = s_ideal;
           end
	end // case: s2
	
	s4: begin
	   if (ON_OFF_signal) begin
	      grant = 5'b00000;
	   end
	   else if (req[4]) begin
	      if (count==2'b11) begin
		 if (req[0]) begin
		    clr_cnt = 1;
		    grant = 5'b00001;
		    next_state = s0;
		 end
		 else if (req[1]) begin
		    clr_cnt = 1;
		    grant = 5'b00010;
		    next_state = s1;
		 end
		 else if (req[2]) begin
		    clr_cnt = 1;
		    grant = 5'b00100;
		    next_state = s2;
		 end
		 else if (req[3]) begin
		    clr_cnt = 1;
		    grant = 5'b01000;
		    next_state = s3;
		 end
		 else begin
		    clr_cnt = 1;
		    grant = 5'b10000;
		    next_state = s4;
		 end
	      end // if (count==2'b11)
	      else begin
		 grant = 5'b10000;
		 inc_cnt = 1;
	      end // else: !if(count==2'b11)
	   end // if (req[2])
	   else if (req[0]) begin
	      clr_cnt = 1;
	      grant = 5'b00001;
	      next_state = s0;
	   end
	   else if (req[1]) begin
	      clr_cnt = 1;
	      grant = 5'b00010;
	      next_state = s1;
	   end
	   else if (req[2]) begin
	      clr_cnt = 1;
	      grant = 5'b00100;
	      next_state = s2;
	   end
	   else if (req[3]) begin
	      clr_cnt = 1;
	      grant = 5'b01000;
	      next_state = s3;
	   end
	   else begin
	      clr_cnt = 1;
	      grant = 5'b00000;
	      next_state = s_ideal;
	   end
	end // case: s2
	
	default: begin
	   if (ON_OFF_signal) begin
	      grant = 5'b00000;
	   end
	   else if (req[0]) begin
	      init_cnt = 1;
	      grant = 5'b00001;
	      next_state = s0;
   	   end
	   else if (req[1]) begin
      	      init_cnt = 1;
      	      grant = 5'b00010;
	      next_state = s1;
   	   end
	   else if (req[2]) begin
      	      init_cnt = 1;
      	      grant = 5'b00100;
	      next_state = s2;
   	   end
	   else if (req[3]) begin
      	      init_cnt = 1;
      	      grant = 5'b01000;
	      next_state = s3;
   	   end
	   else if (req[4]) begin
	      init_cnt = 1;
	      grant = 5'b10000;
	      next_state = s4;
	   end
	   else begin
      	      init_cnt = 1;
      	      grant = 5'b00000;
	      next_state = s_ideal;
   	   end
	end // case: default
      endcase // case (state)
   end // always @ (state,next_state,count)     
   
endmodule