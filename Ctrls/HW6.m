%RouthHurwitz
clear;close all; clc;
pkg load symbolic
%{
%Question 1
coefficientVec = [1,0,6,5,8,20]

RouthHurwitz(coefficientVec)

coefficientVecRev = [20, 8, 5, 6, 0, 1]
RouthHurwitz(coefficientVecRev)

RouthHurwitz([4,8,1,0])

roots(coefficientVec) 
%}
%Question 2
#{
coefficientVec = [1, -2, 4, -3, 2, -3]
RouthHurwitz(coefficientVec)

roots(coefficientVec)
#}

%Question 3
#{
syms K s a b

Gs = (K * (s-a)) / (s*(s-b))

Ts = simplify(Gs / (1 + Gs))
[num,den] = numden(Ts)
coefficientVec = sym2poly(den, s)
RouthHurwitz(coefficientVec)
#}

%Question 4
#{
syms K s

Gs = (K*(s+4)*(s-4)) / (s**2 + 3)

Ts = simplify(Gs / (1+Gs))
[num,den] = numden(Ts)
coeffs = sym2poly(den,s)
RouthHurwitz(coeffs)

coeffs = [K+1, 2*K+2, -16*K+3]
RouthHurwitz(coeffs)
#}

%Question 5
#{
syms K s
Gs = (K*(s-2)*(s+4)*(s+5)) / (s^2 + 12)

Ts = simplify(Gs / (1+Gs))
[num,den] = numden(Ts)
coeffs = sym2poly(den,s)
M = RouthHurwitz(coeffs)

simplify(M)
#}

%Qeustion 6
syms K s

Gs = (K*s*(s+2)) / ((s^2 -4*s + 8)*(s+3))

Ts = simplify(Gs / (1+Gs))
[num,den] = numden(Ts)
coeffs = sym2poly(den,s)
M = RouthHurwitz(coeffs)

simplify(M)

