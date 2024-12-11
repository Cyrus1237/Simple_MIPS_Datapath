`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 11:35:49 PM
// Design Name: 
// Module Name: PIPELINE
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

module PIPELINE(
    input clk,
    input reset,
    input [31:0] EX_MEM_NPC,
    input [4:0] MEM_WB_Writereg,
    input [31:0] MEM_WB_Writedata,
    output [1:0] WB_out,
    output [31:0] read_data_out,
    output [31:0] ALU_result_out,
    output [4:0] write_reg_out,
    output PCSrc,
    output [31:0] write_data_out 
);

    wire [31:0] IF_ID_IR;
    wire [31:0] IF_ID_NPC;
    wire [8:0] control_bits_out;
    wire [31:0] IF_ID_NPC_To_EX_MEM;
    wire [31:0] TO_EX_ALU;
    wire [31:0] To_EX_MUX0_and_EX_MEM;
    wire [31:0] signExtended;
    wire [4:0] EX_Mux_0;
    wire [4:0] EX_Mux_1;


    wire [1:0] WB_out_EX;
    wire [2:0] M_out_EX;
    wire [31:0] ALU_out_EX;
    wire Zero_EX, RegWrite_out;
    wire [31:0] ADD_out_EX;
    wire [31:0] B_out_EX;
    wire [4:0] MUX_out_EX;


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
        .RegWrite(RegWrite_out),
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

    I_EXECUTE execute_stage(
        .clk(clk),
        .reset(reset),
        .WB_in(control_bits_out[8:7]),
        .M_in(control_bits_out[6:4]),
        .EX_in(control_bits_out[3:0]),
        .NPC_in(IF_ID_NPC_To_EX_MEM),
        .A_in(TO_EX_ALU),
        .B_in(To_EX_MUX0_and_EX_MEM),
        .IMM_in(signExtended),
        .RT_in(EX_Mux_0),
        .RD_in(EX_Mux_1),
        .WB_out(WB_out_EX),
        .M_out(M_out_EX),
        .ALU_out(ALU_out_EX),
        .Zero(Zero_EX),
        .ADD_out(ADD_out_EX),
        .B_out(B_out_EX),
        .MUX_out(MUX_out_EX)
    );

    MEMORY memory_stage(
        .clk(clk),
        .reset(reset),
        .WB_in(WB_out_EX), 
        .M_in(M_out_EX), 
        .ALU_result_in(ALU_out_EX), 
        .write_data_in(B_out_EX), 
        .write_reg_in(MUX_out_EX), 
        .Zero_in(Zero_EX), 
        .WB_out(WB_out), 
        .read_data_out(read_data_out), 
        .ALU_result_out(ALU_result_out), 
        .write_reg_out(write_reg_out), 
        .PCSrc(PCSrc)
    );

    WB wb_stage(
        .WB_control(WB_out),  
        .read_data(read_data_out), 
        .ALU_result(ALU_result_out),  
        .write_data(write_data_out), 
        .reg_write(RegWrite_out)  
    );

endmodule