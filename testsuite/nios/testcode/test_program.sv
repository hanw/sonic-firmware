`timescale 1ns/1ps

`define VERBOSITY VERBOSITY_INFO
`define READ_MASTER		tb.nios_base_inst_read_master_bfm
`define WRITE_MASTER	tb.nios_base_inst_write_master_bfm
`define PIO_CTRL		tb.nios_base_inst_ext_ctrl_in_bfm

`define READ_LATENCY 0
`define WAIT_TIME 1
`define BURST_COUNT 1
`define INDEX_ZERO 0

module test_program();
	import verbosity_pkg::*;
	import avalon_mm_pkg::*;

	event idle;

    string message;
	
	Request_t request;
	reg [31:0] address;
	reg [31:0] data;
	reg [7:0]  internal_mem [31:0];

	event irq_start;

	initial 
	begin
		set_verbosity(VERBOSITY_INFO);
		`READ_MASTER.init();
		`WRITE_MASTER.init();
		`READ_MASTER.set_interface_wait_time(1,0);
        #4250000
        ->irq_start;
    end

	always @(`READ_MASTER.signal_command_received)
	begin
		//get the master request
		slave_pop_and_get_command(request, address, data);	
		if (request==REQ_WRITE)
		begin
		  $sformat(message, "%m: Master %s request to address %h with data %h ", convert_to_str(request), address, data);
		  print(VERBOSITY_INFO, message);	
		end
		else if (request==REQ_READ)
		begin
		  $sformat(message, "%m: Master %s request from address %h ", convert_to_str(request), address);
		  print(VERBOSITY_INFO, message);	
		end	
		
		//slave BFM responses to the master's request
		if (request==REQ_WRITE)
		begin
		  internal_mem[address] = data;
		end
		else if (request==REQ_READ)
		begin
		  data = 32'hdeadbeaf;
		  slave_set_and_push_response(data, `READ_LATENCY);
		end
	end
			
	always @(`WRITE_MASTER.signal_command_received)
	begin
		//get the master request
		write_slave_pop_and_get_command(request, address, data);	
		if (request==REQ_WRITE)
		begin
		  $sformat(message, "%m: Master %s request to address %h with data %h ", convert_to_str(request), address, data);
		  print(VERBOSITY_INFO, message);	
		end
		else if (request==REQ_READ)
		begin
		  $sformat(message, "%m: Master %s request from address %h ", convert_to_str(request), address);
		  print(VERBOSITY_INFO, message);	
		end	

        //slave BFM response
		if (request==REQ_WRITE)
		begin
		  internal_mem[address] = data;
		end
		else if (request==REQ_READ)
		begin
		  data = 32'hdeadbeaf;
		  slave_set_and_push_response(data, `READ_LATENCY);
		end
	end

	always @(irq_start)
	begin
		`PIO_CTRL.set_export(4'h0);
		#500
		`PIO_CTRL.set_export(4'h1);
		#500;
		`PIO_CTRL.set_export(4'h0);
    /*
		#500
		`PIO_CTRL.set_export(4'h2);
		#500;
		`PIO_CTRL.set_export(4'h0);

		#500
		`PIO_CTRL.set_export(4'h4);
		#500;
		`PIO_CTRL.set_export(4'h0);
    */
		$sformat (message, "Generate IRQ!");
		print(VERBOSITY_INFO, message);
	end

	//----------------------------------------------------------------------------------
	// tasks
	//----------------------------------------------------------------------------------

	//this task pops the master request from queue and extract the request information  
	task slave_pop_and_get_command;
		output Request_t request;
		output [31:0] address;  
		output [31:0] data;  

		begin
			`READ_MASTER.pop_command();  
			request = `READ_MASTER.get_command_request();
			address = `READ_MASTER.get_command_address();    
			data = `READ_MASTER.get_command_data(`INDEX_ZERO);   
		end
	endtask

	//this task pops the master request from queue and extract the request information  
	task write_slave_pop_and_get_command;
		output Request_t request;
		output [31:0] address;  
		output [31:0] data;  

		begin
			`WRITE_MASTER.pop_command();  
			request = `WRITE_MASTER.get_command_request();
			address = `WRITE_MASTER.get_command_address();    
			data = `WRITE_MASTER.get_command_data(`INDEX_ZERO);   
		end
	endtask

	//this task sets a response as a result of master request and push it back to the master
	task slave_set_and_push_response;  
		input [31:0] data;  
		input int latency; 

		begin 
			`READ_MASTER.set_response_data(data, `INDEX_ZERO);  
			`READ_MASTER.set_response_latency(latency, `INDEX_ZERO);
			`READ_MASTER.set_response_burst_size(`BURST_COUNT);
			`READ_MASTER.push_response();
		end
	endtask

	//this task sets a response as a result of master request and push it back to the master
	task write_slave_set_and_push_response;  
		input [31:0] data;  
		input int latency; 

		begin 
			`WRITE_MASTER.set_response_data(data, `INDEX_ZERO);  
			`WRITE_MASTER.set_response_latency(latency, `INDEX_ZERO);
			`WRITE_MASTER.set_response_burst_size(`BURST_COUNT);
			`WRITE_MASTER.push_response();
		end
	endtask

	//this function converts the enumerated variable to string variable
	function automatic string convert_to_str(Request_t request);
		case(request)
		REQ_READ: return "Read";
		REQ_WRITE: return "Write";
		REQ_IDLE: return "Idle";
	endcase 
	endfunction	

endmodule
