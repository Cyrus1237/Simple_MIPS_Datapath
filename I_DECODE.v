`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2024 11:00:46 PM
// Design Name: 
// Module Name: I_DECODE
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

    
module I_DECODE(
    input clk,
    input reset,
    input [31:0] IF_ID_IR,  // Instruction from IF/ID latch
    input [31:0] IF_ID_NPC_From_IF_ID,
    input RegWrite,  // From WB stage
    input [4:0] MEM_WB_Writereg,  // From WB stage
    input [31:0] MEM_WB_Writedata,  // From WB stage
    output [8:0] control_bits_out,  // Combined 9-bit control output
    output [31:0] IF_ID_NPC_To_EX_MEM,
    output [31:0] TO_EX_ALU,
    output [31:0] To_EX_MUX0_and_EX_MEM,
    output [31:0] signExtended,
    output [4:0] EX_Mux_0,
    output [4:0] EX_Mux_1
);

    wire [8:0] control_bits;
    wire [31:0] read_data1, read_data2;
    wire [31:0] sign_extended_wire;

    control control_unit(
        .control(IF_ID_IR[31:26]),
        .controlbits(control_bits)
    );

    register reg_file(
        .clk(clk),
        .reset(reset),
        .reg_write(RegWrite),
        .read_reg1(IF_ID_IR[25:21]),
        .read_reg2(IF_ID_IR[20:16]),
        .write_reg(MEM_WB_Writereg),
        .write_data(MEM_WB_Writedata),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    sign_extend sign_extend_unit(
        .imm16(IF_ID_IR[15:0]),
        .imm32(sign_extended_wire)
    );

    id_ex_register id_ex_reg(
        .clk(clk),
        .reset(reset),
        .control_bits_in(control_bits),
        .NPC_in(IF_ID_NPC_From_IF_ID),
        .Reg_rs_in(read_data1),
        .Reg_rt_in(read_data2),
        .signExtended_in(sign_extended_wire),
        .Instr_20_16_in(IF_ID_IR[20:16]),
        .Instr_15_11_in(IF_ID_IR[15:11]),
        .control_bits_out(control_bits_out),
        .NPC_out(IF_ID_NPC_To_EX_MEM),
        .Reg_rs_out(TO_EX_ALU),
        .Reg_rt_out(To_EX_MUX0_and_EX_MEM),
        .signExtended_out(signExtended),
        .Instr_20_16_out(EX_Mux_0),
        .Instr_15_11_out(EX_Mux_1)
    );

endmodule