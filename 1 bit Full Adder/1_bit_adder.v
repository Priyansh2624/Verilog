`timescale 1ns / 1ps
module _1_bit_adder(
    input a,b,cin,
    output sum,carry
    );
    wire[3:0]y;
    //sum
    xor x1(sum,a,b,cin);
    //carry
    and a1(y[0],a,b);
    and a2(y[1],b,cin);
    and a3(y[2],a,cin);
    or o1 (carry,y[0],y[1],y[2]);
endmodule
