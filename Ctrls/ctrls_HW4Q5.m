pkg load symbolic
Tp = 127;
percentOS = 30;

zeta = -log(30/100) / (sqrt(pi**2 +( log(0.3))**2))

natFreq = pi / (Tp * (1- zeta**2)**0.5)

natFreq **2
2 * zeta * natFreq

