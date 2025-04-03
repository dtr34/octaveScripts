%real matlab this time

syms s K
Gs = (s+2/3)/(s^2*(s+6));
Hs = 1;
%open loop Ts
Ts = K * Gs *Hs;

pretty(Ts)
[num,den] = numden(Gs);
num = sym2poly(num);
den = sym2poly(den);
sys = tf(num,den)

rlocus(sys);
grid on;

K ==