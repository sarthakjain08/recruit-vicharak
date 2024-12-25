
module CPU_19_bit(
input clk, reset,
output [18:0] PC,
input [18:0] Instr,
output [18:0] Mem_wr_addr, Mem_wr_data,
input [18:0] ReadData
);
    
wire [18:0] Result;
wire RegWrite, Zero, PcSrc, Jump;
wire [1:0] ResultSrc, ImmSrc;
wire [2:0] ALUControl;
wire L;

  
main_decoder controller(
    .op(Instr[3:0]),
    .func3(Instr[10:8]),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite), 
    .RegWrite(RegWrite),
    .Zero(Zero), 
    .Jump(Jump),
    .ImmSrc(ImmSrc),
    .L(L),
    .PcSrc(PcSrc),
    .alu_ctrl(ALUControl)
);
    
datapath Datapath(
    .clk(clk), 
    .reset(reset),
    .ResultSrc(ResultSrc),
    .PcSrc(PcSrc), 
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .L(L),
    .ALUControl(ALUControl),
    .Zero(Zero),
    .PC(PC),
    .Instr(Instr),
    .Mem_wr_addr(Mem_wr_addr),
    .Mem_wr_data(Mem_wr_data),
    .ReadData(ReadData)
);
endmodule
