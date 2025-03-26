%HW 7_2
pkg load symbolic
clear all;
clc;

syms s K;

Gs = K/(s*(s+3));
Hs = 9*s/K
Ges = simplify(Gs/(1+Gs*Hs));



Rs = 50/s^2
Es = simplify(Rs / (1+Ges))
limEs = s*Es
error = subs(limEs,s = 0)
vpa(error)