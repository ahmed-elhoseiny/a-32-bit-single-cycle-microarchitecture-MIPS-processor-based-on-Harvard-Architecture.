module Datapath #(
    parameter  WIDTH = 32,
    parameter  DEPTH = 100,
    parameter  IMMEDIATE_size = 16,
    parameter  REG_ADDR_size = 5,
    //parameter  Opcode_size = 6,
    parameter Target_Addr_size = 26) 
(
input wire                  CLK,
input wire                  RST,
input wire                  Jump,
input wire  [2:0]           ALUControl,
input wire                  PCSrc,
input wire                  MemtoReg,
input wire                  ALUSrc,
input wire                  RegDst,
input wire                  RegWrite,
input wire  [WIDTH-1:0]     ReadData,

// for ports that indicates instruction formats (R-type,I-type,J-type) 
input wire  [REG_ADDR_size-1:0]           Rs_Addr,
input wire  [REG_ADDR_size-1:0]           Rt_Addr,
input wire	[REG_ADDR_size-1:0]		      Rd_Addr,
input wire  [IMMEDIATE_size-1:0]          Immediate_value,
input wire	[Target_Addr_size-1:0]	      Target_addr,   //for branch instruction like jump


output wire                 Zero,
output wire [WIDTH-1:0]     PC,
output wire [WIDTH-1:0]     ALUOut_ALUResult,
output wire [WIDTH-1:0]     WriteData
);


wire	[REG_ADDR_size-1:0]	    WriteReg ;
wire	[WIDTH-1:0]			    Result ;
wire	[WIDTH-1:0]			    SrcA ;
wire	[WIDTH-1:0]			    SrcB ;	
wire	[WIDTH-1:0]			    SignImm ;	
wire	[WIDTH-1:0]			    shift_left_out1 ;
wire	[Target_Addr_size+1:0]	shift_left_out2 ;
wire	[WIDTH-1:0]			    PCBranch ;
wire	[WIDTH-1:0]			    PCPlus4 ;
wire	[WIDTH-1:0]			    PC_in ;
wire	[WIDTH-1:0]			    PC_in_mux_out ;
wire    [WIDTH-1:0]             PCJump;



Register_File #(.WIDTH(WIDTH), .DEPTH(DEPTH), .REG_ADDR(REG_ADDR_size))	Register_File_U1
(
.A1(Rs_Addr),
.A2(Rt_Addr),
.A3(WriteReg),
.WD3(Result),
.WE3(RegWrite),
.CLK(CLK),
.RST(RST),

.RD1(SrcA),
.RD2(WriteData)
);



MUX #(.WIDTH(WIDTH))	ALU_SrcB_MUX_U1
(
.In1(WriteData),
.In2(SignImm),
.sel(ALUSrc),

.out(SrcB)
);

MUX #(.WIDTH(REG_ADDR_size))	WriteReg_MUX_U2 
(
.In1(Rt_Addr),
.In2(Rd_Addr),
.sel(RegDst),

.out(WriteReg)
);

ALU #(.WIDTH(WIDTH))    ALU_U1 
(
.SrcA(SrcA),
.SrcB(SrcB),
.ALUControl(ALUControl),

.ALUResult(ALUOut_ALUResult),
.Zero(Zero)
);

MUX #(.WIDTH(WIDTH))	Result_MUX_U3 
(
.In1(ALUOut_ALUResult),
.In2(ReadData),
.sel(MemtoReg),

.out(Result)
);


Sign_Extend #(.WIDTH(WIDTH), .Imm_Size(IMMEDIATE_size))	Sign_Extend_U1 
(
.Imm(Immediate_value),

.SignImm(SignImm)
);

shift_left_twice #(.WIDTH(WIDTH))	shift_left_SignImm_U1
(
.IN(SignImm),

.OUT(shift_left_out1)
);

Adder #(.WIDTH(WIDTH))			PCBranch_Adder_U1
(
.A(shift_left_out1),
.B(PCPlus4),

.C(PCBranch)
);

shift_left_twice #(.WIDTH(Target_Addr_size+2))	shift_left_Target_addr_U1
(
.IN({2'b00,Target_addr}),

.OUT(shift_left_out2)
);

Adder #(.WIDTH(WIDTH))			PCPlus4_Adder_U1
(
.A(PC),
.B(32'd4),

.C(PCPlus4)
);


Program_Counter #(.WIDTH(WIDTH))	PC_U1
(
.PC_in(PC_in),
.CLK(CLK),
.RST(RST),

.PC(PC)
);

MUX #(.WIDTH(WIDTH))	PC_in_MUX_stage1_U1 
(
.In1(PCPlus4),
.In2(PCBranch),
.sel(PCSrc),

.out(PC_in_mux_out)
);


assign PCJump={PCPlus4[31:28],shift_left_out2[27:0]};
MUX #(.WIDTH(WIDTH))	PC_in_MUX_stage2_U1 
(
.In1(PC_in_mux_out),
.In2(PCJump),
.sel(Jump),

.out(PC_in)
);


endmodule