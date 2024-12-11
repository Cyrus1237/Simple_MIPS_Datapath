`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 01:21:38 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,
    input [7:0] address,  // 8-bit address for 256 words
    input [31:0] write_data,
    input mem_read,
    input mem_write,
    output reg [31:0] read_data
);

    // Declare 256 32-bit memory locations
    (*rom_style = "block"*) reg [31:0] memory [0:255];
    
//    initial begin
//        $readmemh("data.mem", memory);
//    end
 
    initial begin
        memory[0] = 32'b00000000000000000000000000000000;
        memory[1] = 32'b00000000000000000000000000000001;
        memory[2] = 32'b00000000000000000000000000000010;
        memory[3] = 32'b00000000000000000000000000000011;
        memory[4] = 32'b00000000000000000000000000000100;
        memory[5] = 32'b00000000000000000000000000000101;
    end

    // Read operation
    always @(*) begin
        if (mem_read)
            read_data = memory[address];
        else
            read_data = 32'bz;  // High impedance state when not reading
    end

    // Write operation
    always @(posedge clk) begin
        if (mem_write)
            memory[address] = write_data;
    end

endmodule