module ripple_carry_adder_tb();
    logic [3:0]A; logic[3:0]B; logic C; 
    logic[4:0]sum;
    
    Ripple_carry_adder uut(A,B,C,sum,Cout);
    
initial begin 
        A=0;B=0;C=0;
    #10 A=15;B=15;C=1;
    #10 A=7;B=15;C=0;
    #10 A=0;B=7;C=1;
    #10 A=15;B=7;C=1;
    #10 A=15;B=0;C=0;
    #10 A=10;B=9;C=1;
    #10 A=5;B=25;C=0;
    #10;
    
    $finish;
end

endmodule
