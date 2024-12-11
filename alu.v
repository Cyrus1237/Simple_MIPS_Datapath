`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 12:51:20 AM
// Design Name: 
// Module Name: alu
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

module alu(
    input [31:0] a,
    input [31:0] b,
    input [2:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

    always @(*) begin
        case (alu_control)
            3'b000: result = a & b;          // AND
            3'b001: result = a | b;          // OR
            3'b010: result = a + b;          // ADD
            3'b011: result = 32'bx;
            3'b100: result = 32'bx;
            3'b110: result = a - b;          // SUBTRACT
            3'b111: result = 32'bx;
            default: result = 32'bx;         // Undefined
        endcase

        // Set zero flag if result is 0
        zero = (result == 32'b0);
    end

endmodule
