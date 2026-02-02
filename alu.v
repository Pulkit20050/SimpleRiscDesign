module fulladder(x,y,cin,sum,cout);
input x,y,cin;
output reg sum,cout;
always@(*)
begin
sum=(x^y)|cin;
cout=((x|y)&cin)|(x&y);
end
endmodule

module bitmath(a,b,c,s0,s1,s2,out,carry);
input a,b,c,s0,s1,s2;
output out,carry;
wire t1,t2,t3,t4,t5;
wire bneg, sneg;
not n1(bneg,b);
not n2(sneg,s);
and a1(t1,s2,b);
and a2(t2,s0,b);
and a3(t3,s1,bneg);
or o1(t4,a,t1);
or o2(t5,t2,t3);
and a4(t6,sneg,c);
fulladder z1(t5,t4,c,out,carry);
endmodule

module alu(
    input [7:0]A,
    input [7:0]B,
    input [3:0]select,
    output fcout,
    output [7:0]fsum
);
wire [6:0]c;//Don't need them for now, later will see if output required, status register
bitmath b1(A[0],B[0],select[3], select[2],select[1],select[0],fsum[0],c[0]);//carry bit is select[3], to act as logic we have select[0]
bitmath b2(A[1],B[1],c[0], select[2],select[1],select[0],fsum[1],c[1]);
bitmath b3(A[2],B[2],c[1], select[2],select[1],select[0],fsum[2],c[2]);
bitmath b4(A[3],B[3],c[2], select[2],select[1],select[0],fsum[3],c[3]);
bitmath b5(A[4],B[4],c[3], select[2],select[1],select[0],fsum[4],c[4]);
bitmath b6(A[5],B[5],c[4], select[2],select[1],select[0],fsum[5],c[5]);
bitmath b7(A[6],B[6],c[5], select[2],select[1],select[0],fsum[6],c[6]);
bitmath b8(A[7],B[7],c[6], select[2],select[1],select[0],fsum[7],fcout);
endmodule


