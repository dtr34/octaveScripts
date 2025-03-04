%lecture example
clear all;
clc;
pkg load symbolic

syms theta1 theta2 theta3 doq dqr drp

H3to2 = DHtoH(theta3,  0, dqr, drp)
H2to1 = DHtoH(theta2, 0, 0, doq)
H1to0 = DHtoH(theta1, -sym(pi)/2, 0, 0)

H = H1to0 * H2to1 * H3to2

H20 = H1to0*H2to1
H20Inv = simplify(inv(H20))
H10inv = simplify(inv(H1to0))
syms p01 p02 p03
H31 = simplify(H2to1 * H3to2)

p3 = [0;0;0;1]
p0 = [p01;p02;p03;1]

left  = H20Inv * p0
right = H3to2 * p3

left1 = H10inv * p0
right1 = H31 * p3

left1simp = left1 .^2
left1eqn = simplify(left1simp(1) + left1simp(2) + left1simp(3))
right1eqn = simplify( sum(right1 .^2))

