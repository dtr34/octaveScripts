clear all;
clc;
pkg load symbolic
syms theta1 theta2
theta3 = -theta1 + theta2
Px = 35
Py = sym(50*sqrt(2)-25)
a1 = sym(50*sqrt(2) - 50)
a2 = sym(25*sqrt(2))
a3 = 10

eq1 = Px== a1*cos(theta1) + a2*cos(-theta2+theta1) 
eq2 = Py == a1*sin(theta1) + a2*sin(theta1-theta2)
solns = solve(eq1,eq2, theta1,theta2)
