`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2024 02:23:38 PM
// Design Name: 
// Module Name: qspi_slave
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


module qspi_slave (
    input wire clk,
    input wire rst_n,
    input wire [15:0] tx_data,
    input wire tx_valid,
    input wire hamming_last,
    output reg [15:0] rx_data,
    
    inout wire [3:0] io,
    input wire cs_n,
    input wire sclk,
    
    output reg [15:0] out_data,
    output reg out_valid
);

    reg [15:0] shift_reg;
    reg [3:0] io_out;
    reg io_oe;
    reg [4:0] bit_count;
    
    reg [15:0] received_sig [0:15];
    reg complete;
    integer i;
    integer j;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 16'b0;
            io_oe <= 1'b0;
            bit_count <= 0;
            i <= 0;
            j <= 0;
            complete <= 0;
            out_data <= 0;
            out_valid <= 0;
            
            for (i = 0; i < 16; i = i + 1) begin
                received_sig[i] <= 0;
            end
        end else begin
            if (!cs_n) begin
                out_valid <= 0;
                
                if (tx_valid && bit_count == 0) begin
                    shift_reg <= tx_data;
                    io_oe <= 1'b1;
                end
                
                if (sclk) begin
                    shift_reg <= {shift_reg[11:0], io[3:0]};
                    bit_count <= bit_count + 1;
                end else begin
                    io_out <= shift_reg[15:12];
                end
                
                if (bit_count == 5'd16) begin
                    rx_data <= shift_reg;
                    bit_count <= 0;
                    io_oe <= 1'b0;
                    received_sig[i] <= shift_reg;
                    complete <= (i == 15) ? 1 : 0;
                    i <= (i == 15) ? 0 : i + 1;
                end
            end else begin
                io_oe <= 1'b0;
                bit_count <= 0;
                
                if (complete && (j < 16)) begin
                   out_data <= received_sig[j];
                   out_valid <= 1;
                   j <= j + 1;
                end else begin
                    complete <= 0;
                    if (hamming_last) begin
                        out_valid <= 0;
                    end
                end
            end
        end
    end

    assign io = io_oe ? io_out : 4'bz;

endmodule