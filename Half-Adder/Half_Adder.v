module half_adder(A,B,sum,carry);
  input A,B;
  output sum,carry;
  assign {carry,sum}= A+B;
endmodule
