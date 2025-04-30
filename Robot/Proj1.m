%project 1 Robotics
clear; clc;

%{
DH Table
joint    Rot      Twist     Disp      Offs
1         theta1  0               0           0
2             0      0               d1          L2
3         theta3  pi/2           H2        0
4         theta4  0               0           L3
5             0      0               0           L4
%}

syms theta1, theta3, theta4, d2, L2,L3,L4,H2

Heto4 = DHtoH(0,0,0,L4)
H4to3 = DHtoH(theta4,0,0,L3)
H3to2 = DHtoH(theta3,pi/2,H2,0)
H2to1 = DHtoH(0,0,d2,L2)
H1to0 = DHtoH(theta1,0,0,0)

Hetob= H1to0 * H2to1*H3to2 * H4to3 * Heto4
