module instruction_memory
#(
    parameter MEM_SIZE = 128,
    parameter WORD_SIZE = 8
)
(
    input logic clk, rst,
    input logic [$clog2(MEM_SIZE)-1:0] addr,
    output logic [WORD_SIZE-1:0]out_data
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
    end
    assign out_data = {mem_reg[addr], mem_reg[addr+1], mem_reg[addr+2], mem_reg[addr+3]};
endmodule

