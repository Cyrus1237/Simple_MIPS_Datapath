`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 06:43:01 PM
// Design Name: 
// Module Name: alu_control
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

module alu_control(
    input [1:0] ALUOp,      
    input [5:0] funct,       
    output reg [2:0] ALUControl 
);

    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b010; // LW/SW: Add
            2'b01: ALUControl = 3'b110; // BEQ: Subtract
            2'b10: begin                 // R-type instructions
                case (funct)
                    6'b100000: ALUControl = 3'b010; // ADD
                    6'b100010: ALUControl = 3'b110; // SUB
                    6'b100100: ALUControl = 3'b000; // AND
                    6'b100101: ALUControl = 3'b001; // OR
                    6'b101010: ALUControl = 3'b111; // SLT
                    default:   ALUControl = 3'bxxx; 
                endcase
            end
            default: ALUControl = 3'bxxx;
        endcase
    end

endmodule