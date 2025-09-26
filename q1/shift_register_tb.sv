module shift_register_tb;
    parameter N = 4;
    
    logic clk, rst_n;
    logic serial_parallel, load_enable;
    logic serial_in;
    logic [N-1:0] parallel_in;
    logic [N-1:0] parallel_out;
    logic serial_out;
    
    shift_register #(.N(N)) dut (.*);
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0;
        rst_n = 0;
        serial_parallel = 0;
        load_enable = 0;
        serial_in = 0;
        parallel_in = 0;
        
        // Reset
        #10 rst_n = 1;
        
        // Test 1: Serial shift operation
        $display("Test 1: Serial shift operation");
        serial_parallel = 0;
        load_enable = 1;
        
        // Shift in 1011
        serial_in = 1; #10; // bit 3
        serial_in = 0; #10; // bit 2  
        serial_in = 1; #10; // bit 1
        serial_in = 1; #10; // bit 0
        
        // Test 2: Parallel load operation
        $display("Test 2: Parallel load operation");
        serial_parallel = 1;
        parallel_in = 4'b1100;
        #10;
        
        // Test 3: Load enable test
        $display("Test 3: Load enable test");
        load_enable = 0;
        parallel_in = 4'b0101;
        #20;
        load_enable = 1;
        #10;
        
        #100;
        $finish;
    end
    
    always @(posedge clk) begin
        $display("Time: %0t, parallel_out: %b, serial_out: %b", 
                 $time, parallel_out, serial_out);
    end

endmodule
