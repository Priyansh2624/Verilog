`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 20:19:27
// Design Name: 
// Module Name: adder32_tb
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


module adder32_tb;
reg [31:0]A,B;
reg Cin;
wire [31:0]S;
wire Cout;

adder32 dut(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));

initial begin
A=32'd10;B=32'd10;Cin=0;#10;
A=32'd20;B=32'd10;Cin=1;#10;
A=32'd40;B=32'd25;Cin=0;#10;
A=32'd35;B=32'd30;Cin=1;#10;
$finish;
end

endmodule
