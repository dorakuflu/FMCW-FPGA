`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2024 02:22:15 PM
// Design Name: 
// Module Name: qspi_master
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


module qspi_master (
    input wire clk,
    input wire rst_n,
    input wire [15:0] tx_data,
    input wire tx_valid,
    output reg [15:0] rx_data,
    output reg busy,
    
    inout wire [3:0] io,
    output reg cs_n,
    output reg sclk
);

    localparam IDLE = 2'b00;
    localparam TRANSFER = 2'b01;
    localparam COMPLETE = 2'b10;

    reg [1:0] state, next_state;
    reg [4:0] bit_count;
    reg [15:0] shift_reg;
    reg [3:0] io_out;
    reg io_oe;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            bit_count <= 0;
            shift_reg <= 16'b0;
            cs_n <= 1'b1;
            sclk <= 1'b0;
            busy <= 1'b0;
            io_oe <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (tx_valid) begin
                        shift_reg <= tx_data;
                        bit_count <= 5'd15;
                        cs_n <= 1'b0;
                        busy <= 1'b1;
                        io_oe <= 1'b1;
                    end
                end
                TRANSFER: begin
                    sclk <= ~sclk;
                    if (sclk) begin
                        shift_reg <= {shift_reg[11:0], io[3:0]};
                        bit_count <= bit_count - 1;
                    end else begin
                        io_out <= shift_reg[15:12];
                    end
                end
                COMPLETE: begin
                    cs_n <= 1'b1;
                    busy <= 1'b0;
                    rx_data <= shift_reg;
                    io_oe <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: next_state = tx_valid ? TRANSFER : IDLE;
            TRANSFER: next_state = (bit_count == 0 && sclk) ? COMPLETE : TRANSFER;
            COMPLETE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    assign io = io_oe ? io_out : 4'bz;

endmodule