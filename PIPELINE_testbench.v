`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 12:06:58 AM
// Design Name: 
// Module Name: PIPELINE_testbench
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


module PIPELINE_testbench();

    reg clk;
    reg reset;
    
    wire [1:0] WB_out;
    wire [31:0] read_data_out;
    wire [31:0] ALU_result_out;
    wire [4:0] write_reg_out;
    wire PCSrc;
    wire [31:0] write_data_out;

    // Instantiate the PIPELINE module
    PIPELINE uut (
        .clk(clk),
        .reset(reset),
        .EX_MEM_NPC(32'b0), // Initial NPC value
        .MEM_WB_Writereg(write_reg_out),
        .MEM_WB_Writedata(write_data_out),
        .WB_out(WB_out),
        .read_data_out(read_data_out),
        .ALU_result_out(ALU_result_out),
        .write_reg_out(write_reg_out),
        .PCSrc(PCSrc),
        .write_data_out(write_data_out)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock 
    end


    initial begin

        reset = 1;
        #10; // Hold reset for a few cycles
        reset = 0;

        #1000; 

        $finish; 
    end

endmodule
