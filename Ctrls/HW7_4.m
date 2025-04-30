%HW7_4


syms s
Hos = s+1
Gs = (10*(s+10))/(s*(s+2))
Hs = s
syms Rs
Ea = Rs / (1+Gs*Hos)

Gs = Gs + Hs
%feedback form to find Error
Es = simplify(Gs / (1+Gs+Hs))
limE = s*Es

limEa = s*Ea


limEas = simplify(subs(limEa, Rs , (1/s^2)))
subs(limEas, s = 0)


