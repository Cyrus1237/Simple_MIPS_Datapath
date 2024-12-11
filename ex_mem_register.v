`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 12:30:31 AM
// Design Name: 
// Module Name: ex_mem_register
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


module ex_mem_register(
    input clk,
    input reset,
    input [1:0] wb_ctl_in,
    input [2:0] m_ctl_in,
    input [31:0] add_result_in,
    input zero_in,
    input [31:0] alu_result_in,
    input [31:0] read_data2_in,
    input [4:0] mux_out_in,
    output reg [1:0] wb_ctl_out,
    output reg [2:0] m_ctl_out,
    output reg [31:0] add_result_out,
    output reg zero_out,
    output reg [31:0] alu_result_out,
    output reg [31:0] read_data2_out,
    output reg [4:0] mux_out_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wb_ctl_out <= 2'b0;
            m_ctl_out <= 3'b0;
            add_result_out <= 32'b0;
            zero_out <= 1'b0;
            alu_result_out <= 32'b0;
            read_data2_out <= 32'b0;
            mux_out_out <= 5'b0;
        end else begin
            wb_ctl_out <= wb_ctl_in;
            m_ctl_out <= m_ctl_in;
            add_result_out <= add_result_in;
            zero_out <= zero_in;
            alu_result_out <= alu_result_in;
            read_data2_out <= read_data2_in;
            mux_out_out <= mux_out_in;
        end
    end

endmodule
