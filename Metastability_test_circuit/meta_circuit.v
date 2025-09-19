`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//
module meta_circuit(
input wire clk, rst,
input wire [3:0]async_in,
output reg [3:0]Qd );

reg [3:0] Qa;
reg [3:0] Qb;
reg [3:0] Qc;


always@(posedge clk, posedge rst)begin 
    if(rst)begin 
        Qa <= 4'b0;
        Qd <= 4'b0;
    end  
    else begin 
        Qa <= async_in;
        Qd <= ~(Qb ^ Qc);
    end
end

always@(negedge clk, posedge rst)begin
    if(rst)begin 
        Qb <= 4'b0;
        Qc <= 4'b0;
    end
    else begin 
        Qb <= Qa;
        Qc <= ~Qa;
    end
end

endmodule


/*
module metastability_detector (
    input  wire clk,
    input  wire rst_n,
    input  wire async_in,
    output reg  q1,
    output reg  q2,
    output wire metastable_detected
);

    // Two flops sampling async_in at the same clock edge
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
        end else begin
            q1 <= async_in;
            q2 <= async_in;
        end
    end

    // XOR to detect mismatch
    assign metastable_detected = q1 ^ q2;

endmodule
*/