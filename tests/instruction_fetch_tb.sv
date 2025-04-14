`timescale 1ps/1ps

module instruction_fetch_tb;
    logic clk, rst;
    logic [31:0] cnt_in;
    logic branch_ctr;
    logic [31:0] instruction, cnt_val_pl4;

    instruction_fetch if1(.clk(clk), .rst(rst),
                          .cnt_in(cnt_in), .branch_ctr(branch_ctr),
                          .instruction(instruction), .cnt_val_pl4(cnt_val_pl4));

    always #5 clk = ~clk;
    
    initial begin
        clk = 1;
        rst = 1;
        cnt_in = 32'd0;
        branch_ctr = 0;
        #10;
        rst = 0;
    end
endmodule