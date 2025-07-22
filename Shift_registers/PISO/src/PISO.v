`timescale 1ns/1ps
////////////////////////////////////////////////////////////////////////////////////////////////////////////
module PISO(
    input clk,
    input rst,
    input ready,               // Start when high
    input [7:0] parallel_in,   // 8-bit parallel input
    output reg serial_out,     // Serial output 
    output reg done            // High after all 8 bits are sent
);
    reg [7:0] shift_reg;
    reg [2:0] count; // Need 3 bits to count 0–8
    
    always@(posedge clk, posedge rst)begin
     if(rst)begin 
        count<=3'b0;
     end
     else begin 
        count <= count + 1;
     end
    end 
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            shift_reg <= parallel_in;
            serial_out <= 1'b0;
            done <= 1'b0;
        end 
        else if(ready) begin
            if (count == 0)begin 
                 done <=1'b1;
                 shift_reg <= parallel_in;
            end
            else begin
                serial_out <= shift_reg [count];
                done <= 1'b0; end
        end
    end
endmodule
