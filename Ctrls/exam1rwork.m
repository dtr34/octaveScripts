%ExamI Rework
pkg load symbolic
syms s

%Q1
%roots([1, -2, 10])
%eqnS = (s**3 -2*s**2+1) / (s**2*(s**2 +1)) 
%partial = partfrac(eqnS)
%timedomn = ilaplace(partial)

%problem 4
syms i1 i2
L = 0.8
C = 5E-6
vC0 = 9
iL0 = 36E-3
R = 250
XC = 1/(C*s)
eqn1 = i1*L*s - L*iL0 + (i1-i2)*(XC) + vC0/s == 0
eqn2 = -vC0/s + (i2-i1)*XC + i2*R ==0

currents = solve(eqn1,eqn2, i1,i2)
I2 = simplify(currents.i2)
Vc = currents.i2 * 250

vct = ilaplace(Vc)
