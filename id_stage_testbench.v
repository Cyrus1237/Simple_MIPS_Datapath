`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 02:26:52 PM
// Design Name: 
// Module Name: id_stage_testbench
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


module id_stage_testbench();

    // Inputs
    reg clk;
    reg reset;
    reg PCSrc;
    reg [31:0] EX_MEM_NPC;
    reg RegWrite;
    reg [4:0] MEM_WB_Writereg;
    reg [31:0] MEM_WB_Writedata;

    // Outputs
    wire [8:0] control_bits_out;
    wire [31:0] IF_ID_NPC_To_EX_MEM;
    wire [31:0] TO_EX_ALU;
    wire [31:0] To_EX_MUX0_and_EX_MEM;
    wire [31:0] signExtended;
    wire [4:0] EX_Mux_0;
    wire [4:0] EX_Mux_1;

    // Instantiate the Unit Under Test (UUT)
    PIPELINE uut (
        .clk(clk), 
        .reset(reset), 
        .PCSrc(PCSrc), 
        .EX_MEM_NPC(EX_MEM_NPC), 
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

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        PCSrc = 0;
        EX_MEM_NPC = 0;
        RegWrite = 0;
        MEM_WB_Writereg = 0;
        MEM_WB_Writedata = 0;

        // Reset
        #10;
        reset = 0;

        // Run for 10 clock cycles
        #169;

        // End simulation
        $finish;
    end

    // Monitor and display outputs
    always @(posedge clk) begin
        if (!reset) begin
            $display("Time: %0t, Cycle: %0d", $time, ($time-10)/10);
            $display("Control Bits: %b", control_bits_out);
            $display("IF_ID_NPC_To_EX_MEM: %0d", IF_ID_NPC_To_EX_MEM);
            $display("TO_EX_ALU: %0d", TO_EX_ALU);
            $display("To_EX_MUX0_and_EX_MEM: %0d", To_EX_MUX0_and_EX_MEM);
            $display("signExtended: %0d", signExtended);
            $display("EX_Mux_0: %0d", EX_Mux_0);
            $display("EX_Mux_1: %0d", EX_Mux_1);
            $display("-----------------------------");
        end
    end

endmodule
