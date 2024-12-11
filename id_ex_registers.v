`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 05:04:58 PM
// Design Name: 
// Module Name: id_ex_registers
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

module id_ex_registers(
    input wire clk,
    input wire reset,
    input wire [31:0] npc,
    input wire [31:0] readdat1,
    input wire [31:0] readdat2,
    input wire [31:0] signext_out,
    input wire [4:0] instr_2016,
    input wire [4:0] instr_1511,
    input wire [1:0] ctlwb_out,
    input wire [2:0] ctlm_out,
    input wire [3:0] ctlex_out,
    output reg [31:0] npcout,
    output reg [31:0] rdata1out,
    output reg [31:0] rdata2out,
    output reg [31:0] s_extendout,
    output reg [4:0] instrout_2016,
    output reg [4:0] instrout_1511,
    output reg [1:0] wb_ctlout,
    output reg [2:0] m_ctlout,
    output reg [3:0] ex_ctlout
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            npcout <= 32'h00000000;
            rdata1out <= 32'h00000000;
            rdata2out <= 32'h00000000;
            s_extendout <= 32'h00000000;
            instrout_2016 <= 5'b00000;
            instrout_1511 <= 5'b00000;
            wb_ctlout <= 2'b00;
            m_ctlout <= 3'b000;
            ex_ctlout <= 4'b0000;
        end else begin
            npcout <= npc;
            rdata1out <= readdat1;
            rdata2out <= readdat2;
            s_extendout <= signext_out;
            instrout_2016 <= instr_2016;
            instrout_1511 <= instr_1511;
            wb_ctlout <= ctlwb_out;
            m_ctlout <= ctlm_out;
            ex_ctlout <= ctlex_out;
        end
    end

endmodule