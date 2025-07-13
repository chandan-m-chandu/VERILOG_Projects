
module FIFO#(parameter W=32, D=64)(
    input clk, input rst,
    input wrt_en, rd_en,
    input [W-1:0] data_in,
    output [W-1:0] data_out,
    output full, empty
);

    localparam ADDR_WIDTH = $clog2(D);

    reg [W-1:0] fifo_buff[D-1:0];
    reg [ADDR_WIDTH-1:0] r_ptr, w_ptr;
    reg [W-1:0] data_out_reg;

    reg [ADDR_WIDTH:0] count;

    assign data_out = data_out_reg;
    assign full  = (count == D);
    assign empty = (count == 0);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            r_ptr <= 0;
            w_ptr <= 0;
            count <= 0;
            data_out_reg <= 0;
        end
        else begin
            // Write
            if (wrt_en && !full) begin
                fifo_buff[w_ptr] <= data_in;
                w_ptr <= (w_ptr == D-1) ? 0 : w_ptr + 1;
                count <= count + 1;
            end
            else w_ptr <= w_ptr;

            // Read
            if (rd_en && !empty) begin
                data_out_reg <= fifo_buff[r_ptr];
                r_ptr <= (r_ptr == D-1) ? 0 : r_ptr + 1;
                count <= count - 1;
            end
            else r_ptr<= r_ptr;
        end
    end
endmodule
