`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2024 09:44:57 AM
// Design Name: 
// Module Name: tb_hamming_window
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

module tb_hamming_window;

    // Parameters
    parameter DATA_WIDTH = 16;
    parameter WINDOW_SIZE = 16;
    
    // Signals
    reg clk;
    reg reset;
    reg signed [DATA_WIDTH-1:0] data_in;
    reg in_valid;
    wire signed [DATA_WIDTH-1:0] data_out;
    wire out_valid;
    wire out_last;
       
    reg signed [DATA_WIDTH-1:0] input_data [0:WINDOW_SIZE-1] = {16'd32767,	16'd30273, 16'd23170, 16'd12539, 16'd0, 16'd52997, 
    16'd42366, 16'd35263, 16'd32769, 16'd35263, 16'd42366, 16'd52997, 16'd0, 16'd12539, 16'd23170, 16'd30273};
    integer i;
    
    // Instantiate the Unit Under Test (UUT)
    hamming_window #(
        .DATA_WIDTH(DATA_WIDTH),
        .WINDOW_SIZE(WINDOW_SIZE)
    ) uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in), 
        .in_valid(in_valid), 
        .data_out(data_out), 
        .out_valid(out_valid),
        .out_last(out_last)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        data_in = 0;
        in_valid = 0;

        // Reset
        #100;
        reset = 0;
        #10;

        // Apply test vector
        for (i = 0; i < 16; i = i + 1) begin
            data_in = input_data[i];
            in_valid = 1;
            #10;
        end
        
        wait(out_last);
        #10;
        // Add some invalid data cycles
        in_valid = 0;
        #30;


        // Finish the simulation
        $finish;
    end

endmodule
