`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 13:19:55
// Design Name: 
// Module Name: Full_adder
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


module Full_adder(
    input A,B,Cin,
    output S,Cout
    );
    wire C1,C2,S1;
   Half_adder HA1(.A(A),.B(B),.S(S1),.Cout(C1));
   Half_adder HA2(.A(S1),.B(Cin),.S(S),.Cout(C2));
   assign Cout=C1|C2;
endmodule
