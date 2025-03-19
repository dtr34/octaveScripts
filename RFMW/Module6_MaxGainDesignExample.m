%Max Gain Design - Example
clear all; clc;

%Givens
sparams.s11= polar(0.3,160);
sparams.s12 = polar(0.03,62);
sparams.s21 = polar(6.1, 65);
sparams.s22 = polar(0.4,-38);

freq = 25E6;
radFreq = 2*pi*freq;
Zo = 50;

%Determine Stability
Kfield = K(sparams);

%since its stable, might as well check the MAG
maxAvailGain = MAG(sparams)
dB = 10*log10(maxAvailGain)
%Simultaneous Conjugate match
gammaField = SCM(sparams);

%Check max available gain
maxgaincheck= maxGainSonly(sparams, gammaField.S,gammaField.L)
10*log10(maxgaincheck)



Zs = reflToZ(gammaField.S, Zo)
ZL = reflToZ(gammaField.L, Zo)



twoComponentLMatch(conj(Zs), Zo, freq);
twoComponentLMatch(conj(ZL),Zo,freq);


