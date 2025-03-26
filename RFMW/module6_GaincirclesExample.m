function module6_GaincirclesExample
clear all;
clc;

%We are designing the appropriate IMN and OMN
%To get TPG=14.1dB at 1.5 GHz

sparams.s11 = polar(0.8, 120);
sparams.s12 = polar(0.02, 62);
sparams.s21 = polar(4.0, 60);
sparams.s22 = polar(0.2, -30);

Zo = 50;
freq = 1.5E6;

%first check stability
disp("First Check Stability\n");
Kvals = Kdisp(sparams);
disp("\nThen check MAG to ensure 14.1dB is possible\n");

MAG(sparams);
gaindb = 14.1;
desiredGain = 10^(gaindb/10)

gainCircle = availableGain(sparams, desiredGain)

printImag(gainCircle.CA);
plotStabilityCircle(gainCircle.CA,gainCircle.rA);

%choose a value of gammaS
%The point closest to the origin is the easiest to compute:
gammaS = (abs(gainCircle.CA) - gainCircle.rA) * (gainCircle.CA)/ abs(gainCircle.CA)
printImag(gammaS);

%Choose a value of gammaL 
gammaOut = sparams.s22 + (sparams.s12*sparams.s21*gammaS)/(1-sparams.s11*gammaS);
gammaL = conj(gammaOut);
%check your answer
maxGainSonly(sparams, gammaS, conj(gammaOut));

%design input output impedance matches
Zs = reflToZ(gammaS, Zo)
ZL = reflToZ(gammaL, Zo)

%stub line input matching network problem

endfunction 