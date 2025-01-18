module LED_blink(
input wire clk,R, [1:0]sw,
output reg LED );

reg [31:0] counter;
reg [31:0] max_count;

always@(*) begin
case(sw)
    2'b00 : max_count= 100000000;    //1sec
    2'b01 : max_count= 200000000;    //2sec
    2'b10 : max_count= 300000000;    //3
    2'b11 : max_count=   5000000;   //0.5
    default : max_count= 1000000;  //10m 
endcase
end

always@(posedge clk , posedge R) begin
    if(R)begin
    counter<=32'b0;
    LED<=1'b0;
    end
    else begin
        if(counter>=max_count)begin 
            counter<=32'b0;
            LED<=~LED;
        end
        else begin
            counter<=counter+1; 
            end
        end
end

endmodule
