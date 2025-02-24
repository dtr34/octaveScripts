pkg load symbolic

syms C R s
A = (-C/s + R) / (1 + s^2 + 1/s);
eq1 = C == A*(s^2 + 1/s)/s;

Ceqn = solve(eq1, C)
T = simplify(Ceqn / R)

