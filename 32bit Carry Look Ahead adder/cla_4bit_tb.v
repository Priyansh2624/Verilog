`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 16:35:15
// Design Name: 
// Module Name: cla_4bit_tb
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


module cla_4bit_tb;
reg [3:0] A,B;
reg Cin;
wire [3:0] S;
wire Cout;

cla_4bit dut(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));

initial begin
A=4'b1010;B=4'b0110;Cin=0;#10;
A=4'b0101;B=4'b0000;Cin=1;#10;
A=4'b1001;B=4'b0011;Cin=0;#10;
A=4'b0000;B=4'b0001;Cin=1;#10;
$finish;
end


endmodule
