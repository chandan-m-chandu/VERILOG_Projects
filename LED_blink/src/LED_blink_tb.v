`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module LED_blink_tb;
    reg clk;
    reg R;
    reg [1:0] sw;
    wire LED;

    // Instantiate the DUT (Device Under Test)
    LED_blink dut (
        .clk(clk),
        .R(R),
        .sw(sw),
        .LED(LED)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // Generate a 100 MHz clock
    end

    initial begin
        R=1'b1;  sw=2'b00; #20; R=1'b0;

        #50 sw = 2'b01; // Change switch settings
        #50 sw = 2'b10;
        #50 sw = 2'b11;
        #50; $finish;
    end
endmodule
