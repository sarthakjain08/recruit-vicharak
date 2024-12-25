module main_decoder(
input [3:0] op,
input [3:0] func3,
output [1:0] ResultSrc,
output MemWrite, RegWrite, Zero, Jump,
output [1:0] ImmSrc,
output L,
output PcSrc,
output [2:0] alu_ctrl
);

wire Branch;
reg Take_Branch;

reg [11:0] controls;

//RegWrite_ImmSrc_MemWrite_ResultSrc_Branch_Jump_L_aluctrl
always@(*)
begin
    case(op)
    4'b0000: controls = {9'b1_00_0_00_0_0_0, alu_ctrl};     //R with logical AND,OR,XOR
    4'b0001: controls = {9'b1_00_0_00_0_1_0, alu_ctrl};     //R INC,DEC,NOT
    4'b0100: controls = {12'b0_01_0_00_1_0_0_000};          //beq
    4'b0011: controls = {12'b0_01_0_00_0_1_0_000};          //jump
    4'b0111: controls = {12'b1_00_0_10_0_0_0_000};          //load
    4'b1000: controls = {12'b0_00_1_00_0_0_0_000};          //store
    endcase
    
    Take_Branch = 0;
    if(Branch) begin
    case(func3)
    3'b000: Take_Branch = Zero;     //beq
    3'b001: Take_Branch = ~Zero;    //bne
    endcase
    end
end

assign PcSrc = (Branch & Take_Branch) | Jump;
assign {RegWrite, ImmSrc, MemWrite, ResultSrc, Branch, Jump, L, alu_ctrl} = controls;
endmodule