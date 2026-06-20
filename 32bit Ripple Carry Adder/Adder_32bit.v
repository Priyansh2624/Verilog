`timescale 1ns / 1ps
module adder32(
    input  [31:0] A,
    input  [31:0] B,
    input Cin,
    output [31:0] S,
    output Cout
);

wire [32:0] C; //intermediate carries

assign C[0] = 1'b0; //carry in

genvar i; // generate variable(not hardware)

generate
    for(i=0; i<32; i=i+1)
    begin : FA_STAGE
        Full_adder FA(
            .A(A[i]),
            .B(B[i]),
            .Cin(C[i]),
            .S(S[i]),
            .Cout(C[i+1])
        );
    end
endgenerate

assign Cout = C[32];

endmodule
