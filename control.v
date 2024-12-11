`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 03:09:48 PM
// Design Name: 
// Module Name: control
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


module control(
    input wire [5:0] control,
    output wire [8:0] controlbits
);
    
    reg [8:0] control_bits; 
    
    always @(*) begin
        case(control)
            6'b000000: control_bits = 9'b100001100; // R-type instruction
            6'b100011: control_bits = 9'b110100001; // lw (load word)
            6'b101011: control_bits = 9'b0x001x001; // sw (store word)
            6'b000100: control_bits = 9'b0x100x010; // beq (branch if equal)
            6'b100000: control_bits = 9'b000000000; // NOP
            default:   control_bits = 9'bxxxxxxxxx; // Default case (no operation)
        endcase
    end

    assign controlbits = control_bits;
    
endmodule
