module full_adder(input A,B,Cin,output sum, carry );
    assign sum=A^B^Cin;
    assign carry=(A&B)|(B&Cin)|(Cin&A);
endmodule
