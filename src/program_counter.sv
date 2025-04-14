module program_counter(
    input logic clk, rst,
    input logic[31:0] data_in,
    output logic[31:0] cnt_val
);
    logic [31:0] cnt_reg, cnt_next;
    
    always_ff @(negedge clk) begin
        if (rst) begin
            cnt_reg <= 0;
        end else begin
            cnt_reg <= cnt_next;
        end
    end

    always_comb begin
        cnt_next = data_in;
    end

    assign cnt_val = cnt_reg;
endmodule