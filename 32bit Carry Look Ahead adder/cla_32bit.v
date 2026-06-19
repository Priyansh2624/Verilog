`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 16:48:54
// Design Name: 
// Module Name: cla_32bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cla_32bit(
    input [31:0]A,B,
    input Cin,
    output [31:0]S,
    output Cout
    );
    wire [7:0] C; //intermediate carries
    
    cla_4bit adder0(.A(A[3:0]),.B(B[3:0]),.Cin(Cin),.S(S[3:0]),.Cout(C[0]));
    cla_4bit adder1(.A(A[7:4]),.B(B[7:4]),.Cin(C[0]),.S(S[7:4]),.Cout(C[1]));
    cla_4bit adder2(.A(A[11:8]),.B(B[11:8]),.Cin(C[1]),.S(S[11:8]),.Cout(C[2]));
    cla_4bit adder3(.A(A[15:12]),.B(B[15:12]),.Cin(C[2]),.S(S[15:12]),.Cout(C[3]));
    cla_4bit adder4(.A(A[19:16]),.B(B[19:16]),.Cin(C[3]),.S(S[19:16]),.Cout(C[4]));
    cla_4bit adder5(.A(A[23:20]),.B(B[23:20]),.Cin(C[4]),.S(S[23:20]),.Cout(C[5]));
    cla_4bit adder6(.A(A[27:24]),.B(B[27:24]),.Cin(C[5]),.S(S[27:24]),.Cout(C[6]));
    cla_4bit adder7(.A(A[31:28]),.B(B[31:28]),.Cin(C[6]),.S(S[31:28]),.Cout(C[7]));
    assign Cout=C[7];
endmodule
