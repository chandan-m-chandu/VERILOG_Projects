`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2025 15:26:36
// Design Name: 
// Module Name: tb_sipo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
/*

`timescale 1ns / 1ps

module tb_sipo;

  reg clk;
  reg rst;
  reg ready;
  reg [7:0] serial_in;
  wire [63:0] parallel_out;
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
  initial clk = 0;
  always #5 clk = ~clk; // 100MHz clock

  initial begin
    $display("Starting SIPO test...");
    $monitor("Time: %0t | serial_in: %h | parallel_out: %h | count: %d", $time, serial_in, parallel_out, uut.count);
    
    // Initial values
    
    rst = 1;
    ready = 0;
    serial_in = 8'h00;

    // Hold reset
    #10;
    rst = 0;

    // Feed 8 bytes serially
    repeat (8) begin
      @(posedge clk);
      ready = 1;
      serial_in = $random;
    end

    // Wait a few more cycles
    ready = 0;
    #500;

    $display("Final Output = %h", parallel_out);
    $finish;
  end

endmodule

*/

`timescale 1ns / 1ps

module tb_sipo;

  reg clk;
  reg rst;
  reg ready;
  reg [7:0] serial_in;
  wire [63:0] parallel_out;
  wire done;

  // DUT instantiation
  SIPO uut (
    .clk(clk),
    .rst(rst),
    .ready(ready),
    .serial_in(serial_in),
    .parallel_out(parallel_out),
    .done(done)
  );

  // Clock generation (100MHz)
  always #5 clk = ~clk;

  // Internal variables
  reg [7:0] input_bytes [0:7];  // Store 8 input bytes
  reg [63:0] expected_output;
  integer i;

  initial begin
    $display("----- SIPO Testbench Started -----");
    $dumpfile("sipo_tb.vcd");   // For GTKWave
    $dumpvars(0, tb_sipo);

    clk = 0;
    rst = 1;
    ready = 0;
    serial_in = 8'h00;
    expected_output = 64'b0;

    // Reset for a few cycles
    #20;
    rst = 0;
    #10;

    // Test 1: Feed known pattern
    $display("\n[Test 1] Feeding known pattern: 0x01 to 0x08");
    for (i = 0; i < 8; i = i + 1) begin
      input_bytes[i] = i + 8'h01; // Values from 0x01 to 0x08
      @(posedge clk);
      ready = 1;
      serial_in = input_bytes[i];
    end

    @(posedge clk);
    ready = 0;

    // Wait a few cycles
    #20;

    // Compute expected output
    expected_output = {input_bytes[0], input_bytes[1], input_bytes[2], input_bytes[3],
                       input_bytes[4], input_bytes[5], input_bytes[6], input_bytes[7]};
    if (parallel_out === expected_output)
      $display("[PASS] Output matched expected pattern: %h", parallel_out);
    else begin
      $display("[FAIL] Output mismatch.");
      $display("  Expected: %h", expected_output);
      $display("  Got     : %h", parallel_out);
    end

    // Test 2: Reset mid-way
    $display("\n[Test 2] Reset during shifting...");
    rst = 1;
    #10;
    rst = 0;
    #5;

    // Feed 4 bytes
    for (i = 0; i < 4; i = i + 1) begin
      @(posedge clk);
      ready = 1;
      serial_in = 8'hF0 + i;
    end

    // Now reset mid-stream
    @(posedge clk);
    rst = 1;
    #10;
    rst = 0;
    @(posedge clk);
    ready = 0;

    if (parallel_out == 64'b0)
      $display("[PASS] Output correctly cleared on reset.");
    else
      $display("[FAIL] Output not cleared. Got: %h", parallel_out);

    // Test 3: Random bytes
    $display("\n[Test 3] Feeding random 8 bytes");
    for (i = 0; i < 8; i = i + 1) begin
      input_bytes[i] = $random;
      @(posedge clk);
      ready = 1;
      serial_in = input_bytes[i];
    end

    @(posedge clk);
    ready = 0;
    #20;

    expected_output = {input_bytes[0], input_bytes[1], input_bytes[2], input_bytes[3],
                       input_bytes[4], input_bytes[5], input_bytes[6], input_bytes[7]};
    if (parallel_out === expected_output)
      $display("[PASS] Random output matched.");
    else begin
      $display("[FAIL] Random output mismatch.");
      $display("  Expected: %h", expected_output);
      $display("  Got     : %h", parallel_out);
    end

    // Wait and end
    #50;
    $display("----- SIPO Testbench Completed -----");
    $finish;
  end

endmodule
