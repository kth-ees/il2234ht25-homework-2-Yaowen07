module tb_LFSR_6bit;
    logic clk, rst_n;
    logic sel;
    logic [5:0] parallel_in;
    logic [5:0] parallel_out;
    
    LFSR_6bit dut (.*);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst_n = 0;
        sel = 0;
        parallel_in = 0;
        
        #10 rst_n = 1;
        
        // Test parallel load
        parallel_in = 6'b101010;
        #10;
        
        // Test LFSR mode
        sel = 1;
        #100;
        
        // Switch back to parallel load
        sel = 0;
        parallel_in = 6'b111000;
        #10;
        
        #50;
        $finish;
    end
    
    always @(posedge clk) begin
        $display("Time: %0t, LFSR state: %b", $time, parallel_out);
    end
endmodule
