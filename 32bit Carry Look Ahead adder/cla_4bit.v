`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 13:20:41
// Design Name: 
// Module Name: cla_4bit
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


module cla_4bit(
    input [3:0]A,B,
    input Cin,
    output [3:0]S,
    output Cout
    );
    wire [3:0]G,P,C;//generate and propagate signals
    assign Cout=C[3];
    assign G=A&B;//generate
    assign P=A^B;//propagate
    
    //sum
    assign S[0]=P[0]^Cin;
    assign S[1]=P[1]^C[0];
    assign S[2]=P[2]^C[1];
    assign S[3]=P[3]^C[2];
  
    //carry
    assign C[0]=G[0]|(P[0]&Cin);
    assign C[1]=G[1]|P[1]&(G[0]|(P[0]&Cin));
    assign C[2]=G[2]|P[2]&(G[1]|P[1]&(G[0]|(P[0]&Cin)));
    assign C[3]=G[3]|P[3]&(G[2]|P[2]&(G[1]|P[1]&(G[0]|(P[0]&Cin))));
 endmodule
