module risc_v_top(
    input logic clk, rst,
    input logic [31:0] cnt_in,
    input logic branch_ctr,
    input logic [4:0] wr_reg,
    input logic reg_write,
    input logic [31:0] write_back_data,
    output logic [31:0] reg1_data, reg2_data,
    output logic write_back, mem_wr, mem_rd, alu_src,
    output logic [3:0] alu_op,
    output logic [63:0] immediate,
    output logic [31:0] cnt_val_pl4_out
);
    logic [31:0] instruction, cnt_val_pl4;

    instruction_fetch if1(.clk(clk), .rst(rst),
                          .cnt_in(cnt_in), .branch_ctr(branch_ctr),
                          .instruction(instruction), .cnt_val_pl4(cnt_val_pl4));
    
    instruction_decode id1(.clk(clk), .rst(rst),
                           .instruction(instruction), .cnt_val_pl4_in(cnt_val_pl4),
                           .wr_reg(wr_reg), .reg_write(reg_write),
                           .write_back_data(write_back_data),
                           .reg1_data(reg1_data), .reg2_data(reg2_data), 
                           .write_back(write_back), .mem_wr(mem_wr), 
                           .mem_rd(mem_rd), .alu_src(alu_src), .alu_op(alu_op),
                           .immediate(immediate), .cnt_val_pl4_out(cnt_val_pl4_out));
endmodule