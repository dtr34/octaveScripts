syms s

G1s = (s+4) / ((s+3)*(s+7))
Hs = 1/40

G1s = G1s * 10 * 20

Gs= simplify(G1s/(1+G1s*Hs-G1s))

Kp = subs(Gs,s,0)
disp(vpa(Kp));
estep = 1/(1+Kp)
disp(vpa(estep));
 
Kv = subs(s*Gs,s,0)
eramp = 1/Kv

Ka = subs(s^2*Gs,s,0)
eparab = 1/Ka


Rs = 1/s
Es =  simplify (Rs / (1+Gs))

limEs = s*Es

limEs = simplify(subs(limEs,s,0))