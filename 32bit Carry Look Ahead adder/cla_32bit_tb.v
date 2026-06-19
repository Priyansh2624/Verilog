`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 17:56:13
// Design Name: 
// Module Name: cla_32bit_tb
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


module cla_32bit_tb;
reg [31:0]A,B;
reg Cin;
wire [31:0]S;
wire Cout;

cla_32bit dut(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));
initial begin
A=32'd30;B=32'd30;Cin=1;#10;
A=32'd20;B=32'd10;Cin=1;#10;
A=32'd40;B=32'd35;Cin=1;#10;
A=32'd25;B=32'd25;Cin=1;#10;
$finish;
end
endmodule
