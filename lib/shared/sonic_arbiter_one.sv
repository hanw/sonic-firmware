/**
 *  The arbiter that implements a fixed-priority arbitration
 *  The priority order is the same as the single channel case,  
 *  We do not change the round-delay to minimize the change
 *  to state machine timing.
 */

module sonic_arbiter_one #(
    parameter width = 16,
    parameter select_width = 4
)(
    input rst_n,
    input clk,
    input [width-1:0] req,
    input tx_mask0,
    input tx_stream_ready0,
    input pci_bus_master_enable,
    input pci_tx_idle,
    input pci_tx_idle_p0_tx_sel,
    output [width-1:0] grant,
    output [select_width-1:0] select
);

    // Port 0
    reg tx_sel_descriptor_dmawr;
    reg tx_sel_requester_dmawr;
    reg tx_sel_dmawr          ;
    reg tx_sel_descriptor_dmard;
    reg tx_sel_requester_dmard ;
    reg tx_sel_pcnt            ;
    reg tx_sel_interrupt	;
    reg tx_sel_command		;

    wire tx_rdy_interrupt;
    wire tx_rdy_command;
    wire tx_rdy_requester_dmard;
    wire tx_rdy_requester_dmawr;
    wire tx_rdy_descriptor_dmard;
    wire tx_rdy_descriptor_dmawr;
    wire tx_ready_pcnt;

    // Port 1
    reg tx_sel_descriptor_dmawr_p1;
    reg tx_sel_requester_dmawr_p1;
    reg tx_sel_dmawr_p1          ;
    reg tx_sel_descriptor_dmard_p1;
    reg tx_sel_requester_dmard_p1 ;
    reg tx_sel_pcnt_p1            ;
    reg tx_sel_interrupt_p1	;
    reg tx_sel_command_p1		;

    wire tx_rdy_interrupt_p1;
    wire tx_rdy_command_p1;
    wire tx_rdy_requester_dmard_p1;
    wire tx_rdy_requester_dmawr_p1;
    wire tx_rdy_descriptor_dmard_p1;
    wire tx_rdy_descriptor_dmawr_p1;
    wire tx_ready_pcnt_p1;

    assign tx_rdy_interrupt         = req[0];
    assign tx_rdy_command           = req[1];
    assign tx_rdy_requester_dmard   = req[2];
    assign tx_rdy_requester_dmawr   = req[3];
    assign tx_rdy_descriptor_dmard  = req[4];
    assign tx_rdy_descriptor_dmawr  = req[5];
    assign tx_ready_pcnt            = req[6];
    // req[7] is 0.
    assign tx_rdy_interrupt_p1         = req[8];
    assign tx_rdy_command_p1           = req[9];
    assign tx_rdy_requester_dmard_p1   = req[10];
    assign tx_rdy_requester_dmawr_p1   = req[11];
    assign tx_rdy_descriptor_dmard_p1  = req[12];
    assign tx_rdy_descriptor_dmawr_p1  = req[13];
    assign tx_ready_pcnt_p1            = req[14];
    // req[15] is 0.

    reg tx_mask_reg;
    reg tx_stream_ready0_reg;

    always @ (posedge clk) begin
        tx_mask_reg <= tx_mask0;
        tx_stream_ready0_reg <= tx_stream_ready0;
    end

    assign grant = {1'b0, tx_sel_pcnt_p1, tx_sel_descriptor_dmawr_p1,
                    tx_sel_descriptor_dmard_p1, tx_sel_requester_dmawr_p1,
                    tx_sel_requester_dmard_p1, tx_sel_command_p1,
                    tx_sel_interrupt_p1, 
                    1'b0, tx_sel_pcnt, tx_sel_descriptor_dmawr,
                    tx_sel_descriptor_dmard, tx_sel_requester_dmawr,
                    tx_sel_requester_dmard, tx_sel_command,
                    tx_sel_interrupt};

    always @ (negedge rst_n or posedge clk) begin
      if (rst_n==1'b0) begin
         tx_sel_descriptor_dmawr <= 1'b0;
         tx_sel_requester_dmawr  <= 1'b0;
         tx_sel_dmawr            <= 1'b0;
         tx_sel_descriptor_dmard <= 1'b0;
         tx_sel_requester_dmard  <= 1'b0;
         tx_sel_pcnt             <= 1'b0;
		 tx_sel_interrupt		 <= 1'b0;
		 tx_sel_command			 <= 1'b0;
         tx_sel_descriptor_dmawr_p1 <= 1'b0;
         tx_sel_requester_dmawr_p1  <= 1'b0;
         tx_sel_dmawr_p1            <= 1'b0;
         tx_sel_descriptor_dmard_p1 <= 1'b0;
         tx_sel_requester_dmard_p1  <= 1'b0;
         tx_sel_pcnt_p1             <= 1'b0;
		 tx_sel_interrupt_p1		<= 1'b0;
		 tx_sel_command_p1			<= 1'b0;
      end
      else begin
         if ((pci_bus_master_enable==1'b0)) begin
            tx_sel_descriptor_dmawr <= 1'b0;
            tx_sel_requester_dmawr  <= 1'b0;
            tx_sel_dmawr            <= 1'b0;
            tx_sel_descriptor_dmard <= 1'b0;
            tx_sel_requester_dmard  <= 1'b0;
            tx_sel_pcnt             <= 1'b1;
			tx_sel_interrupt		<= 1'b0;
			tx_sel_command			<= 1'b0;
            tx_sel_descriptor_dmawr_p1 <= 1'b0;
            tx_sel_requester_dmawr_p1  <= 1'b0;
            tx_sel_dmawr_p1            <= 1'b0;
            tx_sel_descriptor_dmard_p1 <= 1'b0;
            tx_sel_requester_dmard_p1  <= 1'b0;
            tx_sel_pcnt_p1             <= 1'b0;
            tx_sel_interrupt_p1		   <= 1'b0;
            tx_sel_command_p1		   <= 1'b0;
         end
         else if ((pci_tx_idle==1'b1)&&
                  (pci_tx_idle_p0_tx_sel==1'b1)) begin
               if ((tx_mask_reg==1'b1)||
                     (tx_stream_ready0_reg==1'b0)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
			   else if (tx_rdy_interrupt==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b1;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
			   end
			   else if (tx_rdy_interrupt_p1==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b1;
                    tx_sel_command_p1		   <= 1'b0;
               end
			   else if (tx_rdy_command==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b1;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
			   end
			   else if (tx_rdy_command_p1==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b1;
			   end
               else if ((tx_rdy_descriptor_dmard==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b1;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if ((tx_rdy_descriptor_dmard_p1==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b1;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if ((tx_rdy_descriptor_dmawr==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b1;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b1;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if ((tx_rdy_descriptor_dmawr_p1==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b1;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b1;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if ((tx_rdy_requester_dmard==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b1;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if ((tx_rdy_requester_dmard_p1==1'b1)) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b1;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if (tx_rdy_requester_dmawr==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b1;
                     tx_sel_dmawr            <= 1'b1;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if (tx_rdy_requester_dmawr_p1==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b1;
                    tx_sel_dmawr_p1            <= 1'b1;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if (tx_ready_pcnt==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b1;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else if (tx_ready_pcnt_p1==1'b1) begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b1;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
               else begin
                     tx_sel_descriptor_dmawr <= 1'b0;
                     tx_sel_requester_dmawr  <= 1'b0;
                     tx_sel_dmawr            <= 1'b0;
                     tx_sel_descriptor_dmard <= 1'b0;
                     tx_sel_requester_dmard  <= 1'b0;
                     tx_sel_pcnt             <= 1'b0;
					 tx_sel_interrupt		 <= 1'b0;
					 tx_sel_command			 <= 1'b0;
                    tx_sel_descriptor_dmawr_p1 <= 1'b0;
                    tx_sel_requester_dmawr_p1  <= 1'b0;
                    tx_sel_dmawr_p1            <= 1'b0;
                    tx_sel_descriptor_dmard_p1 <= 1'b0;
                    tx_sel_requester_dmard_p1  <= 1'b0;
                    tx_sel_pcnt_p1             <= 1'b0;
                    tx_sel_interrupt_p1		   <= 1'b0;
                    tx_sel_command_p1		   <= 1'b0;
               end
           end
       end
   end


    genvar m,n;
    generate
        for (n=0; n<select_width; n=n+1)
        begin : jl
            wire [width-1:0] tmp_mask;
            for (m=0; m<width; m=m+1)
            begin : il
                assign tmp_mask[m] = m[n];
            end	
            assign select[n] = |(tmp_mask & grant);
        end
    endgenerate
endmodule

