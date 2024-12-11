`timescale 1ns / 1ps

module if_stage_testbench();

    reg clk;
    reg reset;
    reg PCSrc;
    reg [31:0] EX_MEM_NPC;

    wire [31:0] IF_ID_IR;
    wire [31:0] IF_ID_NPC;

    // Instantiate the I_FETCH module
    I_FETCH uut (
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .EX_MEM_NPC(EX_MEM_NPC),
        .IF_ID_NPC(IF_ID_NPC),
        .IF_ID_IR(IF_ID_IR)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        PCSrc = 0;
        EX_MEM_NPC = 32'h0000000c;

        // Assert reset
        #10 reset = 0;

        // Test sequential instruction fetching
        repeat (8) @(posedge clk) begin
            $display("Cycle: %d, IF_ID_IR: %h, IF_ID_NPC: %d",
                     $time / 10, IF_ID_IR, IF_ID_NPC);
        end

        // Test branch instruction handling
        PCSrc = 1;
        EX_MEM_NPC = 32'h0000000c; 
        @(posedge clk);
        #1;
        $display("Branch Cycle: %d, IF_ID_IR: %h, IF_ID_NPC: %d",
                 $time / 10, IF_ID_IR, IF_ID_NPC);

        // Resume sequential fetching
        PCSrc = 0;
        repeat (5) @(posedge clk) begin
            #1;
            $display("Post-Branch Cycle: %d, IF_ID_IR: %h, IF_ID_NPC: %d",
                     $time / 10, IF_ID_IR, IF_ID_NPC);
        end

        $finish;
    end

endmodule
