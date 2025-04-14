module control(
    input logic clk, rst,
    input logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic write_back, mem_wr, mem_rd, alu_src,
    output logic [3:0] alu_op
);
    // Add = 0000
    // Subtract = 0001
    // XOR = 0010
    // OR = 0011
    // AND = 0100
    always_comb begin
        case opcode
            7'b0110011 : begin // R-type instruction
                case funct3
                    3'b000 : alu_op = (funct7[5]) ? 4'b0001 : 4'b0000;
                    3'b100 : alu_op = 4'b0010;
                    3'b110 : alu_op = 4'b0011;
                    3'b111 : alu_op = 4'b0100;
                    default : alu_op = 4'b0000;
                endcase
                write_back = 1'b1;
                mem_wr = 1'b0;
                mem_rd = 1'b0;
                alu_src = 1'b0;
            end
            7'b0010011 : begin // I-type instruction
                case funct3
                    3'b000 : alu_op = 4'b0000;
                    3'b100 : alu_op = 4'b0010;
                    3'b110 : alu_op = 4'b0011;
                    3'b111 : alu_op = 4'b0100;
                    default : alu_op = 4'b0000;
                endcase
                write_back = 1'b1;
                mem_wr = 1'b0;
                mem_rd = 1'b0;
                alu_src = 1'b1;
            end
            default : begin
                write_back = 1'b1;
                mem_wr = 1'b0;
                mem_rd = 1'b0;
                alu_src = 1'b1;
                alu_op = 4'b0000;
            end
        endcase
    end
endmodule