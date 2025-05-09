%Test1 Q5
pkg load symbolic

syms Vi Vo s
Xc = 1/(2E-6*s)
R1 = 500E3
R2 = 200E3
eqn = Vi / (R1+Xc) + Vo/ (R2+Xc) ==0


VoSoln = solve(eqn, Vo)

Gs = simplify(VoSoln / Vi)

unitResp = Gs * (1/s)
vot = ilaplace(unitResp)