`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 01:37:35 AM
// Design Name: 
// Module Name: WB
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


module WB(
    input [1:0] WB_control,
    input [31:0] read_data,
    input [31:0] ALU_result,
    output [31:0] write_data,
    output reg_write
);

    // Extract control signals
    wire mem_to_reg = WB_control[0];
    assign reg_write = WB_control[1];

    // Instantiate the mux for selecting between memory data and ALU result
    mux #(32) wb_mux (
        .a(read_data),
        .b(ALU_result),
        .sel(mem_to_reg),
        .y(write_data)
    );

endmodule
