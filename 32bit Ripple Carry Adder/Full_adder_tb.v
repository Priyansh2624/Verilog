`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 19:24:23
// Design Name: 
// Module Name: Full_adder_tb
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


module Full_adder_tb;
reg A,B,Cin;
wire S,Cout;
Full_adder dut(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));
initial begin
A=0;B=0;Cin=0;#1;
A=0;B=0;Cin=1;#1;
A=0;B=1;Cin=0;#1;
A=0;B=1;Cin=1;#1;
A=1;B=0;Cin=0;#1;
A=1;B=0;Cin=1;#1;
A=1;B=1;Cin=0;#1;
A=1;B=1;Cin=1;#1;
$finish;
end

endmodule
