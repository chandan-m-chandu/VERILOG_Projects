
`timescale 1ns/1ps

module FIFO_tb;

    parameter W = 32;
    parameter D = 3;

    reg clk, rst;
    reg rd_en, wrt_en;
    reg [W-1:0] data_in;
    wire [W-1:0] data_out;
    wire full, empty;

    // Instantiate DUT
    FIFO #(W, D) dut (
        .clk(clk),
        .rst(rst),
        .rd_en(rd_en),
        .wrt_en(wrt_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $display("=== FIFO Simple Testbench ===");
        $dumpfile("fifo_tb.vcd");
        $dumpvars(0, FIFO_tb);

        // Initial state
        rst = 1;
        wrt_en = 0;
        rd_en = 0;
        data_in = 0;

        // Deassert reset
        #10 rst = 0;

        // Write data: 3 entries
        #10 wrt_en = 1; data_in = 32'd100;
        #10 data_in = 32'd200;
        #10 data_in = 32'd300;
        #10 wrt_en = 0;

        // Read data
        #10 rd_en = 1;
        #30 rd_en = 0;

        // Finish
        #20 $finish;
    end

endmodule
