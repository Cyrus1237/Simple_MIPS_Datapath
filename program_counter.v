`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 04:01:39 PM
// Design Name: 
// Module Name: program_counter
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



module program_counter(
        input clk,
        input reset,
        input [31:0] pc_in,
        output reg [31:0] pc_out
    );

        always @(posedge clk or posedge reset) begin
            if (reset)
                pc_out <= 32'h00000000;
            else
                pc_out <= pc_in;
        end

endmodule