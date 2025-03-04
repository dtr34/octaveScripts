pkg load symbolic
syms H L2 L3 d3 theta1 theta2 theta4
Heto3 = DHtoH(theta4,0,0,0)
H3to2 = DHtoH(-sym(pi) /2 , 0, -d3, 0)
H2to1 = DHtoH(theta2, sym(pi), 0, L3)
H1to0 = DHtoH(theta1, 0, H, L2)

HomoTransform = H1to0 * H2to1 * H3to2 * Heto3

