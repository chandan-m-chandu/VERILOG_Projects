`timescale 1ns/1ps

module SIPO_tb;

    reg clk, rst, ready;
    reg serial_in;
    wire [7:0] parallel_out;
    wire done;

    // Instantiate the SIPO module
    SIPO uut (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .serial_in(serial_in),
        .parallel_out(parallel_out),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        ready = 0;
        serial_in = 0;

        // Reset
        #10;
        rst = 0;

        // Send 8 bits serially (example: 10110011, LSB first)
        #10; serial_in = 1; ready = 1;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1; ready = 0;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 0;
        #10; serial_in = 1;
        #10; serial_in = 1;
        #10; serial_in = 0;

        // Wait and finish
        #20;
        $finish;
    end

    // Display output
    initial begin
        $display("Time\tSerial\tParallel\tDone");
        $monitor("%0t\t%b\t%b\t%b", $time, serial_in, parallel_out, done);
    end

endmodule
