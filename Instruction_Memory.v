module Instruction_Memory #(parameter WIDTH = 32, parameter DEPTH = 100) (
input  wire     [WIDTH-1:0]		    PC,
output reg     [WIDTH-1:0] 	    Instr
);

reg [WIDTH-1:0] ROM [0:DEPTH-1];

always @(*) 
begin
    Instr = ROM [PC>>2];
end


initial 
begin
	$readmemh ("Program3.txt", ROM) ;  
end


endmodule