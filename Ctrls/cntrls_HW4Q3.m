%Question A
disp("question A")
zeta = 3/8
naturalFreq = 4
secondOrderResponse(zeta, naturalFreq)

clear all;
disp("question B")
zeta = 0.05
naturalFreq = 0.2
secondOrderResponse(zeta, naturalFreq)

clear all;
disp("question C")
zeta = (1.6E3 /2) / (sqrt(1.05E7))
naturalFreq = sqrt(1.05E7)
secondOrderResponse(zeta, naturalFreq)
