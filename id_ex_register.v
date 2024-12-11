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

module id_ex_register(
    input clk,
    input reset,
    input [8:0] control_bits_in,  // 9-bit control input
    input [31:0] NPC_in,
    input [31:0] Reg_rs_in,
    input [31:0] Reg_rt_in,
    input [31:0] signExtended_in,
    input [4:0] Instr_20_16_in,
    input [4:0] Instr_15_11_in,
    output reg [8:0] control_bits_out,
    output reg [31:0] NPC_out,
    output reg [31:0] Reg_rs_out,
    output reg [31:0] Reg_rt_out,
    output reg [31:0] signExtended_out,
    output reg [4:0] Instr_20_16_out,
    output reg [4:0] Instr_15_11_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            control_bits_out <= 9'b0;
            NPC_out <= 32'h00000000;
            Reg_rs_out <= 32'h00000000;
            Reg_rt_out <= 32'h00000000;
            signExtended_out <= 32'h00000000;
            Instr_20_16_out <= 5'b00000;
            Instr_15_11_out <= 5'b00000;
        end else begin
            control_bits_out <= control_bits_in;
            NPC_out <= NPC_in;
            Reg_rs_out <= Reg_rs_in;
            Reg_rt_out <= Reg_rt_in;
            signExtended_out <= signExtended_in;
            Instr_20_16_out <= Instr_20_16_in;
            Instr_15_11_out <= Instr_15_11_in;
        end
    end

endmodule
