`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2024 09:43:26 AM
// Design Name: 
// Module Name: hamming_window
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

module hamming_window #(
    parameter DATA_WIDTH = 16,
    parameter WINDOW_SIZE = 16
)(
    input wire clk,
    input wire reset,
    input wire signed [DATA_WIDTH-1:0] data_in,
    input wire in_valid,
    output reg signed [DATA_WIDTH-1:0] data_out,
    output reg out_valid,
    output reg out_last
);

    reg signed [DATA_WIDTH-1:0] window_coeffs [0:WINDOW_SIZE-1];
    reg signed [2*DATA_WIDTH-1:0] mult_result;
    reg done;
    integer i;
    
    initial begin
        window_coeffs[0] = 16'd2621; 
        window_coeffs[1] = 16'd3924;
        window_coeffs[2] = 16'd7608;
        window_coeffs[3] = 16'd13036;
        window_coeffs[4] = 16'd19270;
        window_coeffs[5] = 16'd25231; 
        window_coeffs[6] = 16'd29888;
        window_coeffs[7] = 16'd32438;
        window_coeffs[8] = 16'd32438;
        window_coeffs[9] = 16'd29888;
        window_coeffs[10] = 16'd25231;
        window_coeffs[11] = 16'd19270;
        window_coeffs[12] = 16'd13036;
        window_coeffs[13] = 16'd7608;
        window_coeffs[14] = 16'd3924;
        window_coeffs[15] = 16'd2621;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            i <= 0;
            data_out <= 0;
            out_valid <= 0;
        end else begin
            if (in_valid) begin
                // Perform fixed-point multiplication
                mult_result <= data_in * window_coeffs[i];
                
                // Round and truncate the result
                data_out <= mult_result[2*(DATA_WIDTH-1):DATA_WIDTH-1] + mult_result[DATA_WIDTH-2];
                out_valid <= 1'b1;
                
                // Increment or wrap around the index
                out_last <= (i == (WINDOW_SIZE - 1));
                i <= (i == (WINDOW_SIZE - 1)) ? 0 : i + 1;
            end else begin
                out_valid <= 0;
            end
        end
    end

endmodule