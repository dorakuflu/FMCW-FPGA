`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2024 04:28:27 PM
// Design Name: 
// Module Name: data_processing
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


module data_processing #(
    parameter DATA_WIDTH = 16,
    parameter WINDOW_SIZE = 16
)(
    input wire clk,
    input wire rst_n,
    input wire [15:0] tx_data,
    input wire tx_valid,   
    inout wire [3:0] io,
    input wire cs_n,
    input wire sclk,  
    
    output wire signed [DATA_WIDTH-1:0] hamming_data_out,
    output wire hamming_out_valid,
    output wire hamming_out_last
    );
    
    wire [15:0] rx_data;
    wire [15:0] slave_out_data;
    wire slave_out_valid;
    
    qspi_slave receiver (
        .clk(clk),
        .rst_n(rst_n),
        .tx_data(tx_data),
        .tx_valid(tx_valid),
        .hamming_last(hamming_out_last),
        .rx_data(rx_data),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk),
        .out_data(slave_out_data),
        .out_valid(slave_out_valid)
    );
    
    hamming_window #(
        .DATA_WIDTH(DATA_WIDTH),
        .WINDOW_SIZE(WINDOW_SIZE)
    ) hamming_inst (
        .clk(clk),
        .reset(~rst_n),
        .data_in(slave_out_data),
        .in_valid(slave_out_valid),
        .data_out(hamming_data_out),
        .out_valid(hamming_out_valid),
        .out_last(hamming_out_last)
    );
    
endmodule
