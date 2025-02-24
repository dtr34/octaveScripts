pkg load symbolic

syms E R C s

E = R - C

eqn = C == E * 121/(s * (s+1))

sol = solve(eqn, C)

T = simplify(sol / R)

