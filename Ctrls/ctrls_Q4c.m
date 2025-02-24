%ctrlsHW4c
clear all;
pkg load symbolic
Ts = 1
Tp = 1.1

syms natFrequency Zeta

eq1 = natFrequency*Zeta == 4/Ts;
eq2 = pi/(Tp * (1 - Zeta**2)**0.5) == natFrequency

soln = solve(eq1, eq2)

natFrequency = soln.natFrequency
zeta = soln.Zeta

[pole1, poles2] = secondOrderPoles(zeta,natFrequency);
vpa(pole1,4)
vpa(poles2,4)