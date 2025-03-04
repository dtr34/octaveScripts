%Test review

pkg load symbolic
syms t s a b
laplace(e**(-4*t))
laplace(e**(2*t)*cos(5*t))
%int(function, variable, lower limit, upper limit)
%eqn for
f = 1* e**(-s*t)
int(f,t,a,b)

%pfd

expr = (5*s**2 - 15*s-11) / ((s+1)*(s-2)**3)
 pfd = partfrac(expr)
 

