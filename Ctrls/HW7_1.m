%HW 7
pkg load symbolic
clear all;
clc;

syms s;

Gs = (1350*(s+2)*(s+10)*(s+32))/(s*(s+4)*(s^2+8*s+32));
Ts = simplify(Gs/(1+Gs));

[num,den] = numden(Ts);

roots(sym2poly(den));

Rs = 32/s^3
Es = simplify(Rs / (1+Gs))
limEs = s*Es
error = subs(limEs, 0)
vpa(error)