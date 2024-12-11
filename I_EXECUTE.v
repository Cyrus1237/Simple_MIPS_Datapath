`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 12:47:16 AM
// Design Name: 
// Module Name: I_EXECUTE
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


module I_EXECUTE(
    input clk,
    input reset,
    input [1:0] WB_in,
    input [2:0] M_in,
    input [3:0] EX_in,
    input [31:0] NPC_in,
    input [31:0] A_in,
    input [31:0] B_in,
    input [31:0] IMM_in,
    input [4:0] RT_in,
    input [4:0] RD_in,
    output [1:0] WB_out,
    output [2:0] M_out,
    output [31:0] ALU_out,
    output Zero,
    output [31:0] ADD_out,
    output [31:0] B_out,
    output [4:0] MUX_out
);

    wire [31:0] alu_b_input;
    wire [2:0] alu_control;
    wire [4:0] mux_5bit_out;
    wire [31:0] ALU_result;
    wire [31:0] ADD_result;
    wire zero_wire;

    alu_control alu_control_unit(
        .ALUOp(EX_in[2:1]),  // ALUSOp
        .funct(IMM_in[5:0]),
        .ALUControl(alu_control)
    );

    mux alu_src_mux(
        .a(IMM_in),
        .b(B_in),
        .sel(EX_in[0]),  // ALUSrc
        .y(alu_b_input)
    );

    alu main_alu(
        .a(A_in),
        .b(alu_b_input),
        .alu_control(alu_control),
        .result(ALU_result),
        .zero(zero_wire)
    );

    n_bit_adder #(32) branch_adder(
        .a(NPC_in),
        .b({IMM_in[29:0], 2'b00}),  // Shift left by 2
        .cin(1'b0),
        .sum(ADD_result),
        .cout()  // Not used
    );

    mux #(5) reg_dst_mux(
        .a(RD_in),
        .b(RT_in),
        .sel(EX_in[3]),  // RegDst
        .y(mux_5bit_out)
    );

    ex_mem_register ex_mem_reg(
        .clk(clk),
        .reset(reset),
        .wb_ctl_in(WB_in),
        .m_ctl_in(M_in),
        .add_result_in(ADD_result),
        .zero_in(zero_wire),
        .alu_result_in(ALU_result),
        .read_data2_in(B_in),
        .mux_out_in(mux_5bit_out),
        .wb_ctl_out(WB_out),
        .m_ctl_out(M_out),
        .add_result_out(ADD_out),
        .zero_out(Zero),
        .alu_result_out(ALU_out),
        .read_data2_out(B_out),
        .mux_out_out(MUX_out)
    );

endmodule
