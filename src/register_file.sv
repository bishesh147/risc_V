module register_file
#(
    parameter MEM_SIZE = 32,
    parameter WORD_SIZE = 32
)
(
    input logic clk, rst,
    input logic [$clog2(MEM_SIZE)-1:0] rd_reg1, rd_reg2, wr_reg,
    input logic wr,
    input logic [WORD_SIZE-1:0] wr_data,
    output logic [WORD_SIZE-1:0] reg1_data, reg2_data
);
    logic [WORD_SIZE-1:0] mem_reg[0:MEM_SIZE-1];
    logic [WORD_SIZE-1:0] mem_next[0:MEM_SIZE-1];
    
    always_ff @(negedge clk) begin
        if (rst) begin
            for (int i=0; i < MEM_SIZE; i=i+1) begin
                mem_reg[i] <= 0;
            end
        end else begin
            for (int i=0; i < MEM_SIZE; i=i+1) begin
                mem_reg[i] <= mem_next[i];
            end
        end
    end

    always_comb begin
        for (int i=0; i < MEM_SIZE; i=i+1) begin
            mem_next[i] = mem_reg[i];
        end
        if (wr) begin
            mem_next[wr_reg] = wr_data;
        end
    end
    assign reg1_data = mem_reg[rd_reg1];
    assign reg2_data = mem_reg[rd_reg2];
endmodule

