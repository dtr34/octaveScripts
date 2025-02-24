clear;
pkg load symbolic

syms Va Vi Vo s  % Define symbolic variables

% Define the equation

left = [[1/160 + 1/((40E3/s)+800E-3*s), 0, -1/160]; [1/10E3 + 1/90E3, -1/90E3, 0]]
right = [[0];[0]]

soln = left\right

hs = soln(2)/soln(3)
hs = hs * (1/s)

vt = ilaplace(hs)

