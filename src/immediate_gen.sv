module immediate_gen(
    input logic [31:0] instr,
    output logic [63:0] immediate_out
);
    assign immediate_out = {{32{instr[31]}}, instr};
endmodule
