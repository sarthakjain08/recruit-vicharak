//Logic for 2 to 1 multiplexer

module mux2(
input [18:0] d0, d1,
input sel,
output [18:0] y
);
assign y = sel ? d1 : d0;
endmodule