module instruction_decode(
    input logic clk, rst,
    input logic [31:0] instruction, cnt_val_pl4_in,
    input logic [4:0] wr_reg,
    input logic reg_write,
    input logic [31:0] write_back_data,
    output logic [31:0] reg1_data, reg2_data,
    output logic write_back, mem_wr, mem_rd, alu_src,
    output logic [3:0] alu_op,
    output logic [63:0] immediate,
    output logic [31:0] cnt_val_pl4_out
);
    logic [31:0] reg1_data_wire, reg2_data_wire;
    logic write_back_wire, mem_wr_wire, mem_rd_wire, alu_src_wire;
    logic [3:0] alu_op_wire;
    logic [63:0] immediate_wire;

    control ctr1(.clk(clk), .rst(rst), .opcode(instruction[6:0]),
                 .funct3(instruction[14:12]),
                 .funct7(instruction[31:25]),
                 .write_back(write_back_wire), .mem_wr(mem_wr_wire),
                 .mem_rd(mem_rd_wire), .alu_src(alu_src_wire),
                 .alu_op(alu_op_wire));

    immediate_gen img1(.instr(instruction),
                       .immediate_out(immediate_wire));
    
    register_file rgf1(.clk(clk), .rst(rst), .rd_reg1(instruction[19:15]),
                       .rd_reg2(instruction[24:20]), .wr_reg(wr_reg), .wr(reg_write),
                       .reg1_data(reg1_data_wire),
                       .reg2_data(reg2_data_wire),
                       .wr_data(write_back_data));
    
    always_ff @(posedge clk) begin
        if (rst) begin
            reg1_data <= 0;
            reg2_data <= 0;
            write_back <= 0;
            mem_wr <= 0;
            mem_rd <= 0;
            alu_src <= 0;
            alu_op <= 0;
            immediate <= 0;
            cnt_val_pl4_out <= 0;
        end else begin
            reg1_data <= reg1_data_wire;
            reg2_data <= reg2_data_wire;
            write_back <= write_back_wire;
            mem_wr <= mem_wr_wire;
            mem_rd <= mem_rd_wire;
            alu_src <= alu_src_wire;
            alu_op <= alu_op_wire;
            immediate <= immediate_wire;
            cnt_val_pl4_out <= cnt_val_pl4_in;
        end
    end
endmodule