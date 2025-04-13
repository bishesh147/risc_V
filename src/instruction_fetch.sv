module instruction_fetch(
    input logic clk, rst,
    input logic [31:0] cnt_in,
    input logic branch_ctr,
    output logic [31:0] instruction, cnt_val_pl4
);
    logic [31:0] cnt_val;
    logic [31:0] instr_reg, instr_next;

    program_counter pc1(.clk(clk), .rst(rst), 
                        .data_in(branch_ctr ? cnt_in : cnt_val_pl4),
                        .cnt_val(cnt_val));
    
    instruction_memory im1(.clk(clk), .rst(rst),
                           .addr(cnt_val), .out_data(instr_next));
    
    assign cnt_val_pl4 = cnt_val + 4;

    always_ff @(posedge clk) begin
        if (rst) begin
            instr_reg <= 0;
        end else begin
            instr_reg <= instr_next;
        end
    end

    assign instruction = instr_reg;
endmodule