clear all;
clc;
%pkg load symbolic
syms theta1(t) theta2(t) theta3(t) phi1 phi2 phi3 L1 L2 L3 M1 M2 M3

H3to2 = DHtoH(theta3(t) + phi3, 0, -L3, M3);
H2to1 = DHtoH(theta2(t) + phi2, 0, L2, M2);
H1to0 = DHtoH(theta1(t) + sym(pi/2), sym(-pi/2), L1, 0);

H3to0 = simplify(H1to0 * H2to1 * H3to2);

disp(H3to0);

px = simplify(H3to0(1,4));
py = simplify(H3to0(2,4));  
pz = simplify(H3to0(3,4));  

dt1 = diff(theta1(t));
dt2 = diff(theta2(t));
dt3 = diff(theta3(t));

dpx = simplify(diff(px, t))
dpy = simplify(diff(py, t))  
dpz = simplify(diff(pz, t))

Jv = [subs(dpx,{dt1,dt2,dt3},{1,0,0}), subs(dpx,{dt1,dt2,dt3},{0,1,0}), subs(dpx,{dt1,dt2,dt3},{0,0,1}) ;subs(dpy,{dt1,dt2,dt3},{1,0,0}), subs(dpy,{dt1,dt2,dt3},{0,1,0}), subs(dpy,{dt1,dt2,dt3},{0,0,1}) ; subs(dpz,{dt1,dt2,dt3},{1,0,0}), subs(dpz,{dt1,dt2,dt3},{0,1,0}), subs(dpz,{dt1,dt2,dt3},{0,0,1})]

%Radial velocity
R1to0 = H1to0(1:3,1:3)
H2to0 = H1to0 *H2to1;
R2to0 = H2to0(1:3,1:3)
R3to0 = H3to0(1:3, 1:3)

Jw = [[1,1,1]', R1to0(3, :).',R2to0(3,:).']

J = [Jv ; Jw]
