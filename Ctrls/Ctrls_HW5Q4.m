pkg load symbolic
clear all;

syms E R C s K alpha

E = R - C
eqn = C == (R-C) * K / (s*(s+alpha))

soln = solve(eqn, C)
T = simplify(soln / R)


zet = -log(10/100) / (sqrt(pi**2 + (log(10/100))**2))
wn = 4 / (0.17 * zet)


Ksoln = wn**2
alpha = 2*wn*zet