`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 13:10:39
// Design Name: 
// Module Name: Half_adder_tb
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


module Half_adder_tb;
reg A,B;
wire S,Cout;
Half_adder dut(.A(A),.B(B),.S(S),.Cout(Cout));
initial begin
A=0;B=0;#10;
A=0;B=1;#10;
A=1;B=0;#10;
A=1;B=1;#10;
$monitor("A=%b B=%b Sum=%b C=%b",A,B,S,Cout);
$finish;
end
endmodule
