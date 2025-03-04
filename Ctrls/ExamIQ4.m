%ExamI Q4
pkg load symbolic
syms i1 i2 i3 s
eqn1 = -18 + (i1-i2)*250 == 0
eqn2 = (i2-i1)*250 + (i2-i3)* (1/(5E-6*s)) + 9/s + i2*0.8*s -0.0288 ==0
eqn3 = -9/s + (i3-i2) * (1/(5E-6*s)) +250*i3 ==0

currents = solve(eqn1,eqn2,eqn3, [i1,i2,i3])
Vs = currents.i3 * 250
Vs = simplify(Vs)
vt = ilaplace(Vs)
vt = simplify(vt)