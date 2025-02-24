pkg load symbolic
Ts = 0.5

zeta = -log(0.15)/(sqrt(pi**2 + (log(0.15))**2))
natFrequency = 4/(zeta*Ts)

secondOrderPoles(zeta,natFrequency)
