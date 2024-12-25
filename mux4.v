//Logic for 4 to 1 multiplexer

module mux4(
input [18:0] d0, d1, d2, d3,
input [1:0] sel,
output [18:0] y
    );
    assign y = sel[1] ? (sel[0] ? d3 : d2) : (sel[0] ? d1 : d0);
endmodule
