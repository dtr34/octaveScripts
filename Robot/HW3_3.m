clear all;
clc;

a1 = sym(50*sqrt(2) - 50);
a2 = sym(25*sqrt(2));
a3 = sym(10);

syms theta1(t) theta2(t) theta3(t)


Px = a1*cosd(theta1) + a2*cosd(-theta2+theta1) + a3*cosd(theta1-theta2-theta3)
Py = a1*sind(theta1) + a2*sind(theta1-theta2)+a3*sind(theta1-theta2-theta3)
gamma = theta1-theta2-theta3

Vx = diff(Px, t)
Vy = diff(Py,t)
w = diff(gamma,t)
dt1 = diff(theta1(t),t)
dt2 = diff(theta2,t)
dt3 = diff(theta3,t)
Vxsubd = subs(Vx, {dt1,dt2,dt3, theta1,theta2,theta3}, {5, 120, 20, 120, -120, -90})
Vysubd = subs(Vy,  {dt1,dt2,dt3, theta1,theta2,theta3}, {5, 120, 20, 120, -120, -90})
wsubd = subs(w,  {dt1,dt2,dt3, theta1,theta2,theta3}, {5, 120, 20, 120, -120, -90})

Vxsubd = vpa(Vxsubd)
Vysubd = vpa(Vysubd)

px = 35
py = sym(50*sqrt(2)-25)

Px = subs(Px, theta3, (-theta1+theta2))
Py = subs(Py, theta3, (-theta1+theta2))
gamma = subs(gamma, theta3, (-theta1+theta2))
g = 0
vx = 0
vy = 10
syms omeg


eqn1 = px == Px
eqn2 = py == Py
eqn3 = g == gamma 

solns = solve([eqn1,eqn2],[eqn3,theta1,theta2])

