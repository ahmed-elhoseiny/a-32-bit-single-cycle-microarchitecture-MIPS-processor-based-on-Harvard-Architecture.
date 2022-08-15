module Data_Memory #(parameter WIDTH =32, parameter DEPTH =100 ) (
input       wire        [WIDTH-1:0]      A,
input       wire        [WIDTH-1:0]      WD,
input       wire                         WE,
input       wire                         CLK,RST,

output      wire        [WIDTH-1:0]      RD,
output      reg         [15:0]           Test_Value
);
    
reg		[WIDTH-1:0] 	RAM		[0:DEPTH-1] ;

integer k ;

always @(posedge CLK or negedge RST) 
begin
    if (!RST) 
    begin
        for ( k=0 ; k<=(DEPTH-1) ; k=k+1) 
        begin
            RAM[k] <= 'b0;
        end
    end else if (WE) 
    begin
        RAM[A] <= WD;
    end //else
    //begin
    //    for ( k=0 ; k<=(DEPTH-1) ; k=k+1) 
    //    begin
    //       RAM[k] <= 'b0;
    //    end
    // end
end

assign RD = RAM[A];

reg    [WIDTH-1:0]  ADDR_0 ;
always @(*) 
begin
    ADDR_0 = RAM[32'b0];
    Test_Value = ADDR_0[15:0];
end 
endmodule