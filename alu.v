//alu module

module alu(
    input [18:0] a, b,          //operads
    input [2:0] alu_ctrl,       //alu control
    output reg [18:0] alu_out,   //alu output
    input L,                        
    output zero                 //zero flag
    );
    
always @(a,b,alu_ctrl) begin
    case(alu_ctrl)
    3'b000 : alu_out <= a + b ;     //add
    3'b001 : alu_out <= a - b ;     //sub
    3'b010 : alu_out <= a * b ;     //mul
    3'b011 : alu_out <= a / b ;     //divide
    3'b100 : alu_out <= a & b ;     //AND
    3'b101 : alu_out <= a | b ;     //OR
    3'b110 : alu_out <= a ^ b ;     //XOR
    default: alu_out = 0;           //default condition
    endcase
    
    if(L==1)
    begin
        case(alu_ctrl)
        3'b000 : alu_out <= a + 1;     //increase
        3'b001 : alu_out <= a - 1;      //decrease
        3'b010 : alu_out <= ~a;         //NOT
        endcase
        
     end
end

assign zero = (alu_out==0) ? 1'b1 : 1'b0;
endmodule