`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2024 09:42:12 AM
// Design Name: 
// Module Name: top_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_wrapper#(
    parameter DATA_WIDTH = 16,
    parameter WINDOW_SIZE = 16
)(
        input wire aclk,
        input wire aresetn,
        
        output wire s_axis_config_tready,
        
        output wire s_axis_data_tready,
        
        output wire [31:0] m_axis_data_tdata,
        output wire m_axis_data_tvalid,
        input wire m_axis_data_tready,
        output wire m_axis_data_tlast,
     
        input wire [15:0] slave_tx_data,
        input wire slave_tx_valid,   
        inout wire [3:0] io,
        input wire cs_n,
        input wire sclk  
    );
    
    wire event_frame_started,
        event_tlast_unexpected,
        event_tlast_missing,
        event_status_channel_halt,
        event_data_in_channel_halt,
        event_data_out_channel_halt;
    
    wire [7:0] s_axis_config_tdata = 8'h01;
    wire s_axis_config_tvalid = 1;
    
    reg [31:0] s_axis_data_tdata;
    reg s_axis_data_tvalid;
    reg s_axis_data_tlast;
    
    wire signed [DATA_WIDTH-1:0] hamming_data_out;
    wire hamming_out_valid;
    wire hamming_out_last;
    reg [15:0] hamming_out_reg [0:15];
    
    reg hamming_complete;
    reg fft_in_complete;
    reg fft_in_cycle;
    
    integer i;
    integer j;

    // Instantiate data processing
    data_processing test_process (
        .clk(aclk),
        .rst_n(aresetn),
        .tx_data(slave_tx_data),
        .tx_valid(slave_tx_valid),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk),     
        .hamming_data_out(hamming_data_out), 
        .hamming_out_valid(hamming_out_valid),
        .hamming_out_last(hamming_out_last)   
    );
    
    FFT0 FFT0 (
      .aclk(aclk),                                                // input wire aclk
      .aresetn(aresetn),                                          // input wire aresetn
      .s_axis_config_tdata(s_axis_config_tdata),                  // input wire [7 : 0] s_axis_config_tdata
      .s_axis_config_tvalid(s_axis_config_tvalid),                // input wire s_axis_config_tvalid
      .s_axis_config_tready(s_axis_config_tready),                // output wire s_axis_config_tready
      .s_axis_data_tdata(s_axis_data_tdata),                      // input wire [31 : 0] s_axis_data_tdata
      .s_axis_data_tvalid(s_axis_data_tvalid),                    // input wire s_axis_data_tvalid
      .s_axis_data_tready(s_axis_data_tready),                    // output wire s_axis_data_tready
      .s_axis_data_tlast(s_axis_data_tlast),                      // input wire s_axis_data_tlast
      .m_axis_data_tdata(m_axis_data_tdata),                      // output wire [31 : 0] m_axis_data_tdata
      .m_axis_data_tvalid(m_axis_data_tvalid),                    // output wire m_axis_data_tvalid
      .m_axis_data_tready(m_axis_data_tready),                    // input wire m_axis_data_tready
      .m_axis_data_tlast(m_axis_data_tlast),                      // output wire m_axis_data_tlast
      .event_frame_started(event_frame_started),                  // output wire event_frame_started
      .event_tlast_unexpected(event_tlast_unexpected),            // output wire event_tlast_unexpected
      .event_tlast_missing(event_tlast_missing),                  // output wire event_tlast_missing
      .event_status_channel_halt(event_status_channel_halt),      // output wire event_status_channel_halt
      .event_data_in_channel_halt(event_data_in_channel_halt),    // output wire event_data_in_channel_halt
      .event_data_out_channel_halt(event_data_out_channel_halt)  // output wire event_data_out_channel_halt
    );
    
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            for (i = 0; i < 16; i = i+1) begin
                hamming_out_reg[i] <= 0;
            end
            hamming_complete <= 0;
            fft_in_complete <= 0;
            fft_in_cycle <= 0;
            i = 0;
            j = 0;
            s_axis_data_tdata <= 0;
            s_axis_data_tvalid <= 0;
            s_axis_data_tlast <= 0;
        end else begin
            s_axis_data_tvalid <= 0;
            s_axis_data_tlast <= 0;
            
            if (hamming_out_valid) begin
                for (i = 0; i < 15; i = i+1) begin
                    hamming_out_reg[i] <= hamming_out_reg[i+1];
                end
                hamming_out_reg[15] <= hamming_data_out;
                
                if (~hamming_complete) begin
                    hamming_complete <= hamming_out_last;
                end
            end else if (hamming_complete & s_axis_data_tready & ~fft_in_complete) begin
                s_axis_data_tvalid <= 1;

                if (fft_in_cycle == 0) begin
                    s_axis_data_tvalid <= 1;
                    s_axis_data_tdata <= {16'b0, hamming_out_reg[j]};
                    fft_in_cycle <= 1;
                end else begin
                    s_axis_data_tvalid <= 0;
                    s_axis_data_tdata <= 32'b0;
                    fft_in_cycle <= 0;
                    
                    if (j == 15) begin
                        s_axis_data_tlast <= 1;
                        fft_in_complete <= 1;
                    end else begin
                        j <= j + 1;
                    end
                end                
            end
        end
    end
    
endmodule
