%Max Gain Design - Example
clear all; clc;

%Givens
s11= polar(0.3,160);
s12 = polar(0.03,62);
s21 = polar(6.1, 65);
s22 = polar(0.4,-38);

freq = 25E6;
radFreq = 2*pi*freq;
Zo = 50;

%Determine Stability
Kfield = K(s11,s12,s21,s22);

%since its stable, might as well check the MAG
maxAvailGain = MAG(s11,s12,s21,s22)
dB = 10*log10(maxAvailGain)
%Simultaneous Conjugate match
gammaField = SCM(s11,s12,s21,s22);

%Check max available gain
maxgaincheck= maxGainSonly(s11,s12,s21,s22,gammaField.S,gammaField.L)
10*log10(maxgaincheck)

Zs = reflToZ(gammaField.S, Zo)
ZL = reflToZ(gammaField.L, Zo)

twoComponentLMatch(Zs, Zo, freq);
