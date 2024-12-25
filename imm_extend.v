//imm_extend is logic for immediate entension

module imm_extend(
input [18:0] instr,
input [1:0] immsrc,
output reg [18:0] immext
);

always@(*)
begin
    case(immsrc)
    2'b00: immext = {{4{instr[18]}}, instr[18:4] };
    2'b01: immext = {{15{instr[10]}}, instr[7:4] };
    endcase
    
end
endmodule

    