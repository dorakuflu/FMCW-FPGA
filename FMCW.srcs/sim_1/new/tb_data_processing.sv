`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2024 04:46:44 PM
// Design Name: 
// Module Name: tb_data_processing
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


module tb_data_processing();

    // Common signals
    logic clk;
    logic rst_n;
    wire [3:0] io;
    logic cs_n;
    logic sclk;

    // Master signals
    logic [15:0] master_tx_data;
    logic master_tx_valid;
    logic [15:0] master_rx_data;
    logic master_busy;

    // Slave signals
    logic [15:0] slave_tx_data;
    logic slave_tx_valid;
    logic [15:0] slave_rx_data;
    logic [15:0] out_data;
    logic out_valid;

    // Test data
    reg [15:0] test_data [0:15];
    int data_index;
    
    // Hamming
    logic signed [15:0] hamming_data_out;
    logic hamming_out_valid;
    logic hamming_out_last;

    // Instantiate QSPI Master
    qspi_master master (
        .clk(clk),
        .rst_n(rst_n),
        .tx_data(master_tx_data),
        .tx_valid(master_tx_valid),
        .rx_data(master_rx_data),
        .busy(master_busy),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk)
    );

    // Instantiate data processing
    data_processing test_process (
        .clk(clk),
        .rst_n(rst_n),
        .tx_data(slave_tx_data),
        .tx_valid(slave_tx_valid),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk),     
        .hamming_data_out(hamming_data_out), 
        .hamming_out_valid(hamming_out_valid),
        .hamming_out_last(hamming_out_last)   
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        master_tx_valid = 0;
        slave_tx_valid = 0;
        data_index = 0;
        
        // cosine
        test_data[0] = 32'h0800;
        test_data[1] = 32'h0764;
        test_data[2] = 32'h05A8;
        test_data[3] = 32'h0310;
        test_data[4] = 32'h0000;
        test_data[5] = 32'hFCF0;
        test_data[6] = 32'hFA58;
        test_data[7] = 32'hF89C;
        test_data[8] = 32'hF800;
        test_data[9] = 32'hF89C;
        test_data[10] = 32'hFA58;
        test_data[11] = 32'hFCF0;
        test_data[12] = 32'h0000;
        test_data[13] = 32'h0310;
        test_data[14] = 32'h05A8;
        test_data[15] = 32'h0764;

        // Reset
        #20 rst_n = 1;

        // Wait for a few clock cycles
        repeat (5) @(posedge clk);

        // Send data from master to slave
        for (int i = 0; i < 16; i++) begin
            @(posedge clk);
            master_tx_data = test_data[i];
            master_tx_valid = 1;
            @(posedge clk);
            master_tx_valid = 0;

            // Wait for transfer to complete
            wait(master_busy == 0);

            // Wait a few clock cycles between transfers
            repeat (5) @(posedge clk);
        end

        // End simulation
        #200 $finish;
    end

    // Monitor QSPI signals
    initial begin
        $monitor("Time=%0t: CS_n=%b, SCLK=%b, IO=%b", $time, cs_n, sclk, io);
    end

endmodule
