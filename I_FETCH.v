`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 10:26:16 PM
// Design Name: 
// Module Name: I_FETCH
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


module I_FETCH(
        input clk,
        input reset,
        input PCSrc,
        input [31:0] EX_MEM_NPC,
        output [31:0] IF_ID_IR,
        output [31:0] IF_ID_NPC
    );
    
    wire [31:0] IR_MEM_WIRE;

    wire [31:0] PC_out;
    wire [31:0] mux_out;
    wire [31:0] incremented_pc;

    program_counter pc (
        .clk(clk),
        .reset(reset),
        .pc_in(mux_out),
        .pc_out(PC_out)
    );

    instruction_memory I_MEM (
        .address(PC_out[8:2]),
        .instruction(IR_MEM_WIRE)
    );

    incrementer inc (
        .pcin(PC_out),
        .pcout(incremented_pc)
    );

    mux pc_mux (
        .a(EX_MEM_NPC),
        .b(incremented_pc),
        .sel(PCSrc),
        .y(mux_out)
    );

    if_id_register if_id (
        .clk(clk),
        .reset(reset),
        .npc(incremented_pc),
        .instr(IR_MEM_WIRE),
        .npcout(IF_ID_NPC),
        .instrout(IF_ID_IR)
    );

endmodule
