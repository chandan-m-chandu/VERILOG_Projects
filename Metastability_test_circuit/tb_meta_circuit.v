`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module tb_meta_circuit;

    reg clk;
    reg rst;
    reg [3:0] async_in;
    wire [3:0] Qd;

    // DUT instantiation
    meta_circuit uut (
        .clk(clk),
        .rst(rst),
        .async_in(async_in),
        .Qd(Qd)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #0.111 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        rst = 1;
        async_in = 4'b0000;
        // Release reset after some time
        #2 rst = 0;
            async_in = 4'b1011;
        #0.03 async_in = 4'b0111;
        #0.03 async_in = 4'b0101;
        #0.33 async_in = 4'b1010;
        #0.03 async_in = 4'b0101;
        #0.33 async_in = 4'b1010;
        rst = 0;#1 rst = 1;
        #0.3 async_in = 4'b1111;
        #0.33 async_in = 4'b1101;
        #0.03 async_in = 4'b1001;
        
        #10 $finish;
    end

    // Monitor values
    initial begin
        $monitor("T=%0t | clk=%b | rst=%b | async_in=%b | Qd=%b",
                  $time, clk, rst, async_in, Qd);
    end

    // Optional: waveform dump for GTKWave
    initial begin
        $dumpfile("meta_circuit_tb.vcd");
        $dumpvars(0, tb_meta_circuit);
    end

endmodule

/*
`timescale 1ns/1ps

module tb_metastability_detector;

    reg clk;
    reg rst_n;
    reg async_in;
    wire q1, q2;
    wire metastable_detected;

    // DUT instantiation
    metastability_detector dut (
        .clk(clk),
        .rst_n(rst_n),
        .async_in(async_in),
        .q1(q1),
        .q2(q2),
        .metastable_detected(metastable_detected)
    );

    // Clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        rst_n = 0;
        async_in = 0;
        #12 rst_n = 1;

        // Toggle async_in far from edges (safe)
        #7   async_in = 1;
        #20  async_in = 0;

        // Toggle async_in very close to clock edges (to induce metastability)
        #28.9 async_in = 1;
        #29.1 async_in = 0;

        #38.9 async_in = 1;
        #39.1 async_in = 0;

        #50 async_in = 1;
        #55 async_in = 0;

        #100 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("T=%0t | clk=%b | async_in=%b | q1=%b q2=%b | metastable=%b",
                  $time, clk, async_in, q1, q2, metastable_detected);
    end

    // Dump waves for GTKWave
    initial begin
        $dumpfile("metastability_detector_tb.vcd");
        $dumpvars(0, tb_metastability_detector);
    end

endmodule
*/