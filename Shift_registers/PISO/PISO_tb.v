`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module PISO_tb;

    reg clk, rst, ready;
    reg [7:0] parallel_in;
    wire serial_out;
    wire done;

    PISO uut (
        .clk(clk),
        .rst(rst),
        .ready(ready),
        .parallel_in(parallel_in),
        .serial_out(serial_out),
        .done(done)
    );

    // Clock Generation: 10ns period
    initial clk =0;
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        //clk = 0;
        rst = 1;
        ready = 0;
        parallel_in = 8'b0;

        // Reset pulse
        #10;
        rst = 0;

        // Load parallel input
        #10;
        parallel_in = 8'b10110011;
        ready = 1;
        #100;
        parallel_in = 8'b10101010;
        ready = 0;
        #10;
        parallel_in = 8'b10101010;
        ready = 1;
        #100;
        parallel_in = 8'b11111111;
        ready = 1;
        #100;
        parallel_in = 8'b11100010;
        ready = 1;
        #100;
        ready = 0; // Remove ready after one cycle

        // Wait for done signal
        wait(done == 1);

        #20;
        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time\tSerial_Out\tDone");
        $monitor("%0t\t%b\t\t%b", $time, serial_out, done);
    end

endmodule

