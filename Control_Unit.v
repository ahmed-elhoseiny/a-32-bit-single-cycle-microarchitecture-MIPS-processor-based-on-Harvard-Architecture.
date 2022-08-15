module Control_Unit (
input wire [5:0] Funct,
input wire [5:0] Opcode,
input wire       Zero,

output wire [2:0] ALUControl,
output wire       Jump,
output wire       PCSrc,
output wire       MemtoReg,
output wire       ALUSrc,
output wire       RegDst,
output wire       RegWrite,
output wire       MemWrite
);

wire [1:0] ALUOp;
wire       Branch;

ALU_Decoder U1 (
.ALUControl(ALUControl),
.ALUOp(ALUOp),
.Funct(Funct)
);

Main_Decoder U2 (
.Jump(Jump),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.Branch(Branch),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUOp(ALUOp),
.Opcode(Opcode)
);

assign PCSrc = Zero & Branch;


endmodule