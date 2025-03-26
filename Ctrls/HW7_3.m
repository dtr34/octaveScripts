%HW7_3

pkg load symbolic
clear all;
clc;

syms s K Ds Rs;

% these dont change
G1 = 5
G2 = 7/(s+2)

Es = (1 / (1 + G1*G2)) * Rs - (G2/ (1 + G1*G2)) * Ds;

% substitute new values for a, b, and c
Es = subs(Es,{Rs,Ds},{3/s,-1/s})

limEs = s*Es

limEs= simplify(limEs)
einf= subs(limEs,s,0)


vpa(einf)


