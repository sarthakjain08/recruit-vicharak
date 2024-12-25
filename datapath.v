module datapath(
    input clk,reset,
    input [1:0] ResultSrc,
    input PcSrc, RegWrite,
    input [1:0] ImmSrc,
    input L,
    input [3:0] ALUControl,
    output Zero,
    output [18:0] PC,
    input [18:0] Instr,
    output [18:0] Mem_wr_addr, Mem_wr_data,
    input [18:0]ReadData
);
    
    wire [18:0] PCNext, PCPlus1, PCTarget;
    wire [18:0] ImmExt, SrcA, SrcB, WriteData, ALUResult, readDataMem;
    wire [18:0] Result;
    wire [18:0] temp;
    
    
assign Mem_wr_data = WriteData;   
//Next PC Logic  
    reset_ff pcreg(clk, reset, PCNext, PC);
    adder pcadd1(PC, 19'd1, PCPlus1);
    mux2 pcmux(PCPlus1, ImmExt, PcSrc, PCNext);

//Register File
    reg_file rf(clk, RegWrite, Instr[7:4], Instr[14:11], Instr[18:15], Result, SrcA, WriteData);
    imm_extend immExt(Instr[18:4], ImmSrc, ImmExt);

//ALULogic
    alu ALU(SrcA, SrcB, ALUControl, ALUResult, L, Zero);
    
 //Result Mux
    mux4 resultMux(ALUResult, PCPlus1, ReadData, temp, ResultSrc, Result);
    
    //assign Mem_wr_data = WriteData
    assign Mem_wr_addr = {{8{Instr[14]}}, Instr[14:4] };
 
 endmodule
    
 