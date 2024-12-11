`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 01:25:56 AM
// Design Name: 
// Module Name: MEMORY
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


module MEMORY(
    input clk,
    input reset,
    input [1:0] WB_in,
    input [2:0] M_in,
    input [31:0] ALU_result_in,
    input [31:0] write_data_in,
    input [4:0] write_reg_in,
    input Zero_in,
    output [1:0] WB_out,
    output [31:0] read_data_out,
    output [31:0] ALU_result_out,
    output [4:0] write_reg_out,
    output PCSrc
);

    wire [31:0] mem_read_data;
    wire mem_read, mem_write, branch;
    
    assign mem_write = M_in[2];
    assign mem_read = M_in[1];
    assign branch = M_in[0];

    assign PCSrc = branch && Zero_in;

    data_memory D_MEM(
        .clk(clk),
        .address(ALU_result_in[7:0]),  // Use lower 8 bits of ALU result as address
        .write_data(write_data_in),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .read_data(mem_read_data)
    );

    mem_wb_register MEM_WB(
        .clk(clk),
        .reset(reset),
        .wb_ctl_in(WB_in),
        .read_data_in(mem_read_data),
        .alu_result_in(ALU_result_in),
        .write_reg_in(write_reg_in),
        .wb_ctl_out(WB_out),
        .read_data_out(read_data_out),
        .alu_result_out(ALU_result_out),
        .write_reg_out(write_reg_out)
    );

endmodule
