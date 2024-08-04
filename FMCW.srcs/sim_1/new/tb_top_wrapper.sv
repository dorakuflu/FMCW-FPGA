`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2024 05:23:16 PM
// Design Name: 
// Module Name: tb_top_wrapper
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


module tb_top_wrapper();

    reg aclk;
    reg aresetn;

    wire s_axis_config_tready;
    
    wire s_axis_data_tready;
    
    wire [31 : 0] m_axis_data_tdata;
    wire m_axis_data_tvalid;
    reg m_axis_data_tready;
    wire m_axis_data_tlast;
    
    reg [31:0] input_data [0:15];
    reg [15:0] output_real;
    reg [15:0] output_imag;
    
    assign output_real = m_axis_data_tdata[15:0];
    assign output_imag = m_axis_data_tdata[31:16];
    
    // Master signals
    logic [15:0] master_tx_data;
    logic master_tx_valid;
    logic [15:0] master_rx_data;
    logic master_busy;
    
    logic [15:0] slave_tx_data;
    logic slave_tx_valid;   
    wire [3:0] io;
    logic cs_n;
    logic sclk;  
    
    // Instantiate QSPI Master
    qspi_master master (
        .clk(aclk),
        .rst_n(aresetn),
        .tx_data(master_tx_data),
        .tx_valid(master_tx_valid),
        .rx_data(master_rx_data),
        .busy(master_busy),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk)
    );
    
    top_wrapper #(
        .DATA_WIDTH(16),
        .WINDOW_SIZE(16)
    ) uut (
        .aclk(aclk),
        .aresetn(aresetn),
        .s_axis_config_tready(s_axis_config_tready),
        .s_axis_data_tready(s_axis_data_tready),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_data_tready(m_axis_data_tready),
        .m_axis_data_tlast(m_axis_data_tlast),
        .slave_tx_data(slave_tx_data),
        .slave_tx_valid(slave_tx_valid),
        .io(io),
        .cs_n(cs_n),
        .sclk(sclk)
        
    );
    
    always begin
        #1.25 aclk = ~aclk;
    end
    
    initial begin
        // Initialize inputs
        aclk = 0;
        aresetn = 0;
        m_axis_data_tready = 1;
        master_tx_valid = 0;
        slave_tx_valid = 0;
        
        
        #100;
        aresetn = 1;

        input_data[0] = 32'h0800;
        input_data[1] = 32'h0764;
        input_data[2] = 32'h05A8;
        input_data[3] = 32'h0310;
        input_data[4] = 32'h0000;
        input_data[5] = 32'hFCF0;
        input_data[6] = 32'hFA58;
        input_data[7] = 32'hF89C;
        input_data[8] = 32'hF800;
        input_data[9] = 32'hF89C;
        input_data[10] = 32'hFA58;
        input_data[11] = 32'hFCF0;
        input_data[12] = 32'h0000;
        input_data[13] = 32'h0310;
        input_data[14] = 32'h05A8;
        input_data[15] = 32'h0764;
    
        // Wait for a few clock cycles
        repeat (5) @(posedge aclk);
        
        // Send data from master to slave
        for (int i = 0; i < 16; i++) begin
            @(posedge aclk);
            master_tx_data = input_data[i];
            master_tx_valid = 1;
            @(posedge aclk);
            master_tx_valid = 0;

            // Wait for transfer to complete
            wait(master_busy == 0);

            // Wait a few clock cycles between transfers
            repeat (5) @(posedge aclk);
        end
        

        // Wait for output
        wait(m_axis_data_tvalid);
        for (int i = 0; i < 16; i++) begin
            @(posedge aclk);
            if (m_axis_data_tvalid) begin
                $display("Output data[%0d]: %h", i, m_axis_data_tdata);
            end
        end

        // Check for tlast
        if (!m_axis_data_tlast) begin
            $display("Error: m_axis_data_tlast not asserted");
        end

        // End simulation
        #300;
        $finish;
    end   
endmodule
