module LFSR_6bit (
  input  logic clk, rst_n,
  input  logic sel,
  input  logic [5:0] parallel_in,
  output logic [5:0] parallel_out
);
  logic [5:0] lfsr_reg;
    logic feedback;
    
    // Feedback polynomial: x^6 + x^5 + 1 (taps at bits 5 and 0)
    assign feedback = lfsr_reg[5] ^ lfsr_reg[0];
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr_reg <= 6'b000001; // Non-zero initial state
        end else if (!sel) begin
            // Parallel load mode
            lfsr_reg <= parallel_in;
        end else begin
            // LFSR shift mode
            lfsr_reg <= {lfsr_reg[4:0], feedback};
        end
    end
    
    assign parallel_out = lfsr_reg;
endmodule

