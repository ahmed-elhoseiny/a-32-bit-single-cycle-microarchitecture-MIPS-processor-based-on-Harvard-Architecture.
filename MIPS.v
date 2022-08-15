module MIPS #(
    parameter  WIDTH = 32,
    parameter  DEPTH = 100,
    parameter  IMMEDIATE_size = 16,
    parameter  REG_ADDR_size = 5,
    //parameter  Opcode_size = 6,
    parameter Target_Addr_size = 26)  
(
input       wire        CLK,RST,

output      wire [15:0] Test_Value
);

wire						Jump;
wire	[2:0]				ALUControl ;
wire                        Zero ;
wire                        PCSrc ;
wire                        MemtoReg ;
wire                        ALUSrc ;
wire                        RegDst ;
wire                        RegWrite ;
wire                        MemWrite ;
		
wire    [WIDTH-1:0]         WriteData ;
wire	[WIDTH-1:0] 		ALUOut;
wire    [WIDTH-1:0]         ReadData;

wire    [WIDTH-1:0]         PC;
wire    [WIDTH-1:0]         Instr ;


Control_Unit 	Control_Unit_U1
(
.Funct(Instr[5:0]),
.Opcode(Instr[31:26]),
.Zero(Zero),

.ALUControl(ALUControl),
.Jump(Jump),
.PCSrc(PCSrc),
.MemtoReg(MemtoReg),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.MemWrite(MemWrite)
);

Data_Memory #(.WIDTH(WIDTH), .DEPTH(DEPTH) )	Data_Memory_U1	
(
.A(ALUOut),
.WD(WriteData),
.WE(MemWrite),
.CLK(CLK),
.RST(RST),

.RD(ReadData),
.Test_Value(Test_Value)

);

Instruction_Memory #(.WIDTH(WIDTH), .DEPTH(DEPTH))		Instruction_Memory_U1
(
.PC(PC),

.Instr(Instr)
);


Datapath #(.WIDTH(WIDTH), .DEPTH(DEPTH), .IMMEDIATE_size(IMMEDIATE_size), .REG_ADDR_size(REG_ADDR_size), .Target_Addr_size(Target_Addr_size) )		Datapath_U1
(
.CLK(CLK),
.RST(RST),
.Jump(Jump),
.ALUControl(ALUControl),
.PCSrc(PCSrc),
.MemtoReg(MemtoReg),
.ALUSrc(ALUSrc),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ReadData(ReadData),

// for ports that indicates instruction formats (R-type,I-type,J-type) 
.Rs_Addr(Instr[25:21]),
.Rt_Addr(Instr[20:16]),
.Rd_Addr(Instr[15:11]),
.Immediate_value(Instr[15:0]),
.Target_addr(Instr[25:0]),   //for branch instruction like jump

.Zero(Zero),
.PC(PC),
.ALUOut_ALUResult(ALUOut),
.WriteData(WriteData)
);



endmodule