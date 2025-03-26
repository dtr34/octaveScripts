clear all;
clc;
pkg load symbolic
syms d2(t) theta1(t) vx vy
Px = d2(t) * cos(theta1(t))
Py = d2(t) * sin(theta1(t))

dd2 = diff(d2(t),t)
dt1 = diff(theta1(t),t)

Vx = vx ==  diff(Px, t)
Vy = vy ==diff(Py, t)

jointVels = solve([Vx, Vy], [dd2, dt1]);
% Access fields using derivative expressions as strings
disp(jointVels.('Derivative(d2(t), t)'))
disp(jointVels.('Derivative(theta1(t), t)'))

dd2 = simplify(jointVels.('Derivative(d2(t), t)'))
dt1 = simplify(jointVels.('Derivative(theta1(t), t)'))  

d2d2 = simplify(diff(dd2, t))
d2t1 = simplify(diff(dt1,t))