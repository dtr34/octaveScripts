%E2Q4
clear all;
clc;
sparams.s11 = polar(0.61,165);
sparams.s21 = polar(2.72,59);
sparams.s12 = polar(0.05,42);
sparams.s22 = polar(0.45,-48);

desiredGain = 10^(14/10);

gainCircle = availableGain(sparams,desiredGain)

gammaS = (abs(gainCircle.CA) - gainCircle.rA) * (gainCircle.CA)/ abs(gainCircle.CA)
printImag(gammaS);
reflToZ(gammaS, 50)

gammaOut = sparams.s22 + (sparams.s12*sparams.s21*gammaS)/(1-sparams.s11*gammaS);
gammaL = conj(gammaOut);
reflToZ(gammaL,50)