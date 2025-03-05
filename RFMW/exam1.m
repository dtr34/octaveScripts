#{
Z0 = 75
gammaL = 0.5

ZL = Z0 * (1+gammaL)/(1-gammaL)
#}
%Question 7
#{
clear all; clc,
s11 = polar(0.28, -58)
s21 = polar(2.1, 65)
s12 = polar(0.08, 92)
s22 = polar(0.8, -30)

Z0 = 50

[del,K] = K(s11,s12,s21,s22)

maxTPG(s12,s21,K)
ZL = 10 + j*25
gammaL = (ZL - Z0)/(ZL+Z0)

gammain = s11 + (s12*s21*gammaL) / (1-s22*gammaL)

#}

Xs = 0;
Rs = 500;
RL = 100

twoComponentLMatch(Xs, Rs, RL)

w = 150E6 *2*pi
[xp1,xs1,xp2,xs2] = twoComponentLMatchParallel(Xs,Rs,RL)
caps = [-1/(w*xp1),-1/(w*xs1),-1/(w*xp2),-1/(w*xs2)]
inductors = [xp1/w,xs1/w,xp2/w,xs2/w]

w = 2*pi * 100E6
L = 0.265E-3 *w
C = 1/ (5.31E-11*w)
