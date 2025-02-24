pkg load symbolic 

syms A B C K1 K2 s

A = R -C;
B = A*K1 - C*K2*s;

eqn = C == B * 30/(s*(s+2));

Csoln = solve(eqn, C);
T = simplify(Csoln / R)

syms zet natFreq

eq1 = 1.5 == pi/(natFreq * sqrt(1 - zet**2));
eq2 = 3 == 4/(zet * natFreq);

params = solve (eq1,eq2, zet, natFreq);

zeta = params.zet
wn = params.natFreq

syms k1 k2

answer = solve(30 * k1 == wn**2 , 30*k2 + 2 == 2*wn*zeta, k1, k2)
vpa(answer.k1)
answer.k2