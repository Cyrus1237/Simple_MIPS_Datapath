`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 02:35:23 PM
// Design Name: 
// Module Name: PIPELINE_IF_and_ID
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


module PIPELINE_IF_and_ID(
    input clk,
    input reset,
    input PCSrc,
    input [31:0] EX_MEM_NPC,
    input RegWrite,
    input [4:0] MEM_WB_Writereg,
    input [31:0] MEM_WB_Writedata,
    output [8:0] control_bits_out,
    output [31:0] IF_ID_NPC_To_EX_MEM,
    output [31:0] TO_EX_ALU,
    output [31:0] To_EX_MUX0_and_EX_MEM,
    output [31:0] signExtended,
    output [4:0] EX_Mux_0,
    output [4:0] EX_Mux_1
);

    wire [31:0] IF_ID_IR;
    wire [31:0] IF_ID_NPC;

    I_FETCH fetch_stage(
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .EX_MEM_NPC(EX_MEM_NPC),
        .IF_ID_IR(IF_ID_IR),
        .IF_ID_NPC(IF_ID_NPC)
    );

    I_DECODE decode_stage(
        .clk(clk),
        .reset(reset),
        .IF_ID_IR(IF_ID_IR),
        .IF_ID_NPC_From_IF_ID(IF_ID_NPC),
        .RegWrite(RegWrite),
        .MEM_WB_Writereg(MEM_WB_Writereg),
        .MEM_WB_Writedata(MEM_WB_Writedata),
        .control_bits_out(control_bits_out),
        .IF_ID_NPC_To_EX_MEM(IF_ID_NPC_To_EX_MEM),
        .TO_EX_ALU(TO_EX_ALU),
        .To_EX_MUX0_and_EX_MEM(To_EX_MUX0_and_EX_MEM),
        .signExtended(signExtended),
        .EX_Mux_0(EX_Mux_0),
        .EX_Mux_1(EX_Mux_1)
    );

endmodule
