module Main_Decoder (
input   wire    [5:0]    Opcode,

output  reg                 Jump, MemtoReg, MemWrite ,Branch ,ALUSrc ,RegDst ,RegWrite,
output  reg     [1:0]    ALUOp
);

always @(*) 
begin
    case (Opcode)
    6'b10_0011:     //loadWord
    begin
        Jump = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        Branch = 1'b0;
    end
        
    6'b10_1011:     //storeWord
    begin
        Jump = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b1;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b1;
        Branch = 1'b0;
    end

                 
    6'b00_0000 :     //rType
    begin
        Jump = 1'b0;
        ALUOp = 2'b10;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b1;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
    end

        
    6'b00_1000 :     //addImmediate
    begin
        Jump = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b1;
        RegDst = 1'b0;
        ALUSrc = 1'b1;
        MemtoReg = 1'b0;
        Branch = 1'b0;
    end

         
    6'b00_0100 :     //branchIfEqual
    begin
        Jump = 1'b0;
        ALUOp = 2'b01;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b1;
    end

            
    6'b00_0010:     //jump_inst
    begin
        Jump = 1'b1;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
    end

    default:           //default
    begin
        Jump = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        RegWrite = 1'b0;
        RegDst = 1'b0;
        ALUSrc = 1'b0;
        MemtoReg = 1'b0;
        Branch = 1'b0;
    end
endcase
end

endmodule