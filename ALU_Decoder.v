module ALU_Decoder #(parameter Funct_size = 6 ) (
input   wire     [Funct_size-1:0]   Funct,
input   wire     [1:0]              ALUOp,

output  reg      [2:0]              ALUControl
);
    
always @(*) 
begin
    case (ALUOp)
        2'b00:
        begin
            ALUControl = 3'b010; 
        end

        2'b01:
        begin
            ALUControl = 3'b100;
        end

        2'b10:
        begin
            case (Funct)
                'b10_0000:    //add
                begin
                    ALUControl = 3'b010;
                end

                'b10_0010:    //sub
                begin
                    ALUControl = 3'b100;
                end

                'b10_1010:    //slt
                begin
                    ALUControl = 3'b110;
                end

                'b01_1100:    //mul
                begin
                    ALUControl = 3'b101;
                end

                default: 
                begin
                    ALUControl = 3'b010;
                end
            endcase
        end

        2'b11 : 	
	    begin
		    ALUControl = 3'b010 ;
	    end

        default: 
        begin
            ALUControl = 3'b010;
        end 
    endcase

end 


endmodule