module control(
    input logic clk, rst,
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    output logic write_back, mem_wr, mem_rd, alu_src,
    output logic [3:0] alu_op
);
endmodule