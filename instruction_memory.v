`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 04:04:17 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input wire [6:0] address,
    output wire [31:0] instruction
);

    (*rom_style = "block"*) reg [31:0] memory [0:127];

//    initial begin
//        $readmemh("risc.mem", memory);
//    end

    initial begin
        memory[0] = 32'b10001100000000010000000000000001;
        memory[1] = 32'b10001100000000100000000000000010;
        memory[2] = 32'b10001100000000110000000000000011;
        memory[3] = 32'b10000000000000000000000000000000;
        memory[4] = 32'b10000000000000000000000000000000;
        memory[5] = 32'b00000000001000100000100000100000;
        memory[6] = 32'b10000000000000000000000000000000;
        memory[7] = 32'b10000000000000000000000000000000;
        memory[8] = 32'b10000000000000000000000000000000;
        memory[9] = 32'b00000000001000110000100000100000;
        memory[10] = 32'b10000000000000000000000000000000;
        memory[11] = 32'b10000000000000000000000000000000;
        memory[12] = 32'b10000000000000000000000000000000;
        memory[13] = 32'b00000000001000010000100000100000;
        memory[14] = 32'b10000000000000000000000000000000;
        memory[15] = 32'b10000000000000000000000000000000;
        memory[16] = 32'b10000000000000000000000000000000;
        memory[17] = 32'b00000000001000000000100000100000;
        memory[18] = 32'b10000000000000000000000000000000;
        memory[19] = 32'b10000000000000000000000000000000;
        memory[20] = 32'b10000000000000000000000000000000;
    end

    assign instruction = memory[address];

endmodule




//            $readmemh("risc.mem", memory);