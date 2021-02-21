# Mesh NoC RTL Generator with Wormhole Routers

// Engineers: Akarsh Ningoji Rao Kolekar - akolekar6@gatech.edu
//            Abhishek Upadhyay - aupadhyay31@gatech.edu

This is a NoC RTL generator which generates a Mesh topology with wormhole routers. 
To run this, RTL simulator is required and for this project we have used Modelsim. 

Files in SRC directory:

1) ram.sv - This module is responsible for allocating the memory for the buffers.

2) buffer.sv - This module addresses the memory instantiated by the ram.sv module in a FIFO format. 
The control signal used to write in the ram is 'wr_en' and to read from it is 'rd_en'. 
When 'wr_en' is high, it stores the flit in the memory location addressed by the write pointer and after the write process is complete, it increments the write pointer. 
When 'rd_en' is high, it outputs the flit stored in the memory location addressed by the read pointer and after the read process is complete, it increments the read pointer. 
The full and empty signals indicate the condition of the buffer that it is full or empty.

3) route_compute.sv - This module calculates the output port for the packet from the head flit. 
It takes inputs from all the buffers North, East, South, West and Local and generates an output port request for each packet.

4) demux_1to5.sv - One separate demux is used for each input buffer. 
This demux generates a one-hot encoded request for the arbiter. The request is 5 bits, each bit for each output port. 
The bits are allocated from MSB to LSB as local, west, south, east and north respectively.

5) round_robin_arbiter.sv - It arbitrates the requests generated by the demux in order to assign one output port to one request at a time. 
The priority is decided based on round robin scheme in order to ensure fairness and the priority is static for 4 cycles as each packet consists of 4 flits. 
This maintains the wormhole router functionality.

6) one_hot_mux5_1.sv - This mux is a crossbar switch instantiated for each output port and is responsible for sending the flit from the input buffer (that wins arbitration) to its requested output port. 
The select signal of this switch is provided by round_robin_arbiter.sv.

7) switch_allocator.sv - This module instantiates demux_1to5.sv, round_robin_arbiter.sv and one_hot_mux5_1.sv for one router and sends the control signal 'rd_en' within the router and 'wr_en' to the downstream router.

8) Router.sv - This module instantiates a router. Currently the routers are not parameterizable in terms of the number of ports. 
The number of ports are fixed to 5.

FOR USER TO EDIT <br/>
9) mesh_general.sv - This file takes in the configuration of the mesh topology for which RTL is to be generated. 

MESH_COLUMNS specify the number of columns in the mesh and MESH_ROWS specifies the number of rows. 

The NoC generator generates square mesh and the row and column numbers should be same while using this file. 

The MESH_ROWS and MESH_COLUMNS can be currently set to a maximum of 8, since the number of bits allocated to each of the coordinates in the head flit is fixed to 3. 

LINK_WIDTHS specifies the size of the message that traverses through the links. This is equal to the number of bits in the flits that are sent through these links. 

BUFFER_DEPTH is used to specify the size of the buffers at each input port. The minimum size of the buffer must be the number of flits in a packet. 

PORTS specify the number of ports per router. This number is fixed for mesh topology. 

The rest of the input signals for local input flit, clock, reset and local write enable are provided by the testbench. 
A sample test bench for synthetic traffic pattern bit-complement is also provided.

Files in TESTBENCHES folder:

1) buffer_tb.sv - It can be used to test the functionality of buffer.sv. 
It provides flits to the buffer and reads according to the for loops provided in the testbench. 
The loops can be changed to insert the flits and read fro the buffer accordingly. 
Ensure that the module ram.sv is also in the working directory in order to avoid ERRORS.

2) route_compute_tb.sv - It injects the flits (HEAD, BODY and TAIL) in the route compute and monitors the output ports calculated by the route compute unit. 
The flits can also be changed according to the user.

3) demux_1to5_tb.sv - This testbench tests the demux for all the select cases.

4) round_robin_arbiter_tb.sv - This test bench generates requests for the output ports and at the output we can see the request that wins the arbitration in a round robin fashion.

5) one_hot_mux5_1_tb.sv - This testbench tests the crossbar switch (mux) for all the select cases.

6) switch_allocator_tb.sv - It injects flits in the buffers and sends the output ports for the buffer in order to see what flits appear at the output port after winning the arbitration for the crossbar switch.

7) mesh_gereral_4x4_bc_tb.sv - This testbench generates a bit-complement traffic pattern and inserts it into the mesh topology in mesh_general.sv. 
The packets can be injected at varying injection rates in the local buffers of the routers by changing the variable RATE in the testbench. 
The output can be observed at the local output flits of the destination buffers. 
This test bench also dumps the number of cycles taken by a packet to reach its destination from the source. 
The destinations of the packets can be changed by changing the head flit injected into the network (hence changing the traffic pattern).

TO RUN:
1) Open Mentor Graphics ModelSim software.

2) Any file can opened from this view.

3) Compile each module as a check along with the test-bench. Ensure that SystemVerilog is selected in compilation options.
3-a) If Modelsim asks to create a work directory, click on "Yes".

4) Start simulation of the "mesh_gereral_4x4_bc_tb.sv" file. 

5) In the command line interface provided by ModelSim, type "log -r *" and press Enter.

6) Then type "run -a" and press Enter. Packets will continuously be injected into the network until the value specified by "$finish" command in the test-bench. ModelSim will ask the user if they want to finish. Click on "No".

7) In the Instance window, a mesh_NxN_inst would be present. There will be several genblk1 created. If making a 4x4 mesh, there will be 4 top level genblk1 created, inside each of these there will be 4 more genblk1 created. There will be a router_main_dut inside this. The router_main_dut will consist of north_buffer, east_buffer, south_buffer, west_buffer, local_buffer, route_compute and switch_allocator. Clicking on any of these will show the signals that can be viewed for them in the "Objects" window right next to it. To view a signal's waveform, right-click on that signal in the "Objects" window, and click on "Add Wave". The test-bench has a default timescale of 1ns/100ps, i.e., the x-axis of the waveform will be 1ns long with a granularity of marking as 100ps. The entire waveform upto the limit specified by "$finish" can be viewed by clicking on the waveform display window and pressing the "f" key. Keep an eye out for router_out_flit_4 signal of any router. These are the flits that have reached the destination router.
