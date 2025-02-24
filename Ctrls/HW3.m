pkg load symbolic

syms i1 i2 s
left = [[1/(2*s) + 6], [6]; [10, 9]];
right = [[-4/s]; 0];

solved = left \ right;
disp(solved)

i1timedomain = ilaplace(solved(1))
