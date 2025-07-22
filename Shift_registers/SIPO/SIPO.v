`timescale 1ns/1ps
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module SIPO (
    input clk,
    input rst,
    input ready,             // Enables serial input
    input serial_in,         // 1-bit serial input
    output reg [7:0] parallel_out, // 8-bit parallel output
    output reg done          // High when all 8 bits received
);

    reg [2:0] count;         // Counts number of bits shifted in

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            parallel_out <= 8'b0;
            count <= 3'b0;
            done <= 1'b0;
        end else begin
            if (ready) begin
                parallel_out <= {parallel_out[6:0], serial_in}; // Shift left, LSB first
                count <= count + 1;

                if (count == 3'd7)
                    done <= 1'b1;
                else
                    done <= 1'b0;
            end
        end
    end

endmodule
