module Ripple_carry_adder(input [3:0]A,[3:0]B,Cin,
output wire [3:0]sum,Cout);
wire c0,c1,c2;
    full_adder f0(A[0],B[0],Cin,sum[0],c0);
    full_adder f1(A[1],B[1],c0,sum[1],c1);
    full_adder f2(A[2],B[2],c1,sum[2],c2);
    full_adder f3(A[3],B[3],c2,sum[3],Cout);
endmodule
