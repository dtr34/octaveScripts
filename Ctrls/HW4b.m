pkg load symbolic
Tp = 10

zeta = -log(0.08)/(sqrt(pi**2 + (log(0.08))**2))
natFrequency = pi/(Tp * sqrt(1-zeta **2))

secondOrderPoles(zeta,natFrequency)
