clear all
pkg load symbolic

syms Rs Xs Xser RL Xpar

Eq1 = Rs - j*Xs == j*Xser + (RL * j*Xpar)/(j*Xpar +RL)
Eq2 = RL == (j*Xpar * (Rs+j*Xs + j*Xser))/(Rs+j*Xs + j * (Xser + Xpar))

[Xser,Xpar] = solve(Eq1,Eq2,Xser,Xpar)
