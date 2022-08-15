module Sign_Extend #(parameter WIDTH = 32, parameter Imm_Size = 16)
(
input    wire     [Imm_Size-1:0]     Imm,
output   reg     [WIDTH-1:0]        SignImm
);

always @(*) 
begin
    if (Imm[Imm_Size-1]) 
    begin
        SignImm = {{(WIDTH-Imm_Size){1'b1}},Imm};
    end else 
    begin
        SignImm = {{(WIDTH-Imm_Size){1'b0}},Imm};
    end
end 
endmodule