`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2024 02:57:18 PM
// Design Name: 
// Module Name: cfar
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

// NOT COMPLETE!

module cfar #(
    parameter DATA_WIDTH = 16,
    parameter FFT_WIDTH = 32,
    parameter WINDOW_SIZE = 16,
    parameter GUARD_CELLS = 2,
    parameter SCALING_FACTOR = 5
)(
    input wire aclk,
    input wire aresetn,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire data_valid,
    output reg [DATA_WIDTH-1:0] threshold,
    output reg [WINDOW_SIZE-1:0] detection
);

    // Declare registers and wires
    reg [DATA_WIDTH-1:0] kernel [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] data_fft_real [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] data_fft_imag [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] kernel_fft_real [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] kernel_fft_imag [WINDOW_SIZE-1:0];
    reg [FFT_WIDTH-1:0] mult_real [WINDOW_SIZE-1:0];
    reg [FFT_WIDTH-1:0] mult_imag [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] ifft_real [WINDOW_SIZE-1:0];
    wire [FFT_WIDTH-1:0] ifft_imag [WINDOW_SIZE-1:0];
    reg [DATA_WIDTH-1:0] data_input [WINDOW_SIZE-1:0];
    reg [DATA_WIDTH-1:0] data_threshold [WINDOW_SIZE-1:0];

    integer i;
    
    // FFT signals
    wire event_frame_started,
        event_tlast_unexpected,
        event_tlast_missing,
        event_status_channel_halt,
        event_data_in_channel_halt,
        event_data_out_channel_halt;
   
    reg [7:0] s_axis_config_tdata;
    wire s_axis_config_tvalid = 1;
    wire s_axis_config_tready;
    
    reg [31:0] s_axis_data_tdata;
    reg s_axis_data_tvalid;
    wire s_axis_data_tready;
    reg s_axis_data_tlast;    
    

    wire [31:0] m_axis_data_tdata;
    wire m_axis_data_tvalid;
    reg m_axis_data_tready;
    wire m_axis_data_tlast;
    

    // Initialize kernel
    initial begin
        for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
            if (i < GUARD_CELLS || i >= WINDOW_SIZE - GUARD_CELLS) begin
                kernel[i] = 0;
            end else begin
                kernel[i] = 1;
            end
        end
    end

    // Instantiate FFT module
    FFT1 FFT1 (
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

    // Multiply FFTs
    always @(posedge aclk) begin
        if (!aresetn) begin
            for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
                mult_real[i] <= 0;
                mult_imag[i] <= 0;
            end
        end else if (data_valid) begin
            for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
                mult_real[i] <= data_fft_real[i] * kernel_fft_real[i] - data_fft_imag[i] * kernel_fft_imag[i];
                mult_imag[i] <= data_fft_real[i] * kernel_fft_imag[i] + data_fft_imag[i] * kernel_fft_real[i];
            end
        end
    end

    // Calculate threshold and make detection decision
    always @(posedge aclk) begin
        if (!aresetn) begin
            for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
                threshold[i] <= 0;
                detection[i] <= 0;
            end
        end else if (data_valid) begin
            for (i = 0; i < WINDOW_SIZE; i = i + 1) begin
                threshold[i] <= (ifft_real[i] * SCALING_FACTOR) / (WINDOW_SIZE - 2*GUARD_CELLS - 1);
                detection[i] <= (data_in[i] > threshold[i]);
            end
        end
    end

endmodule