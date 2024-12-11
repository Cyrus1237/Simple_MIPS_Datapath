`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 04:09:24 PM
// Design Name: 
// Module Name: if_id_register
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


module if_id_register(
        input wire clk,
        input wire reset,
        input wire [31:0] npc,
        input wire [31:0] instr,
        output reg [31:0] npcout,
        output reg [31:0] instrout
    );
    
        always @(posedge clk or posedge reset) begin
            if (reset) begin
                npcout <= 32'h00000000;
                instrout <= 32'h00000000;
            end else begin
                npcout <= npc;
                instrout <= instr;
            end
        end
    
endmodule
