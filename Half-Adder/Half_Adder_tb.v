module half_adder_tb(A,B,C,sum,carry);
  input A,B,C;
  output sum,carry;
assign {carry,sum}=A+B+C;
endmodule
