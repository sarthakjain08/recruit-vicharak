//reset_ff is resetable d flip flop
module reset_ff(
input clk, rst,
input [18:0] d,
output reg [18:0] q
);

always@(posedge clk or posedge rst)
    begin
        if(rst) q <= 0;
        else q <= d;
    end
endmodule