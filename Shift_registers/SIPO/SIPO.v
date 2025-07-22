`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

module SIPO(input clk, input rst, 
input ready,
input [7:0]serial_in, 
output reg [63:0]parallel_out, 
output reg done );

reg [2:0]count;
reg [63:0]out;

always@(posedge clk, posedge rst)begin
if(rst)begin
    count<=3'b0;
end
else begin 
    count <= count + 1;
end
end

always@(posedge clk, posedge rst)begin
    if(rst)begin 
        parallel_out <= 64'b0; 
        out <= 64'b0;   
        done<=0; 
    end
    else if(ready) begin
                if(count==0)begin 
                parallel_out <= out;
                done<=1;
            end
            else begin
                out <= {out[55:0], serial_in};
                done<=0;
               // parallel_out <= out;
            end
        end
    else begin
        parallel_out <= out;
    end
    end

endmodule
