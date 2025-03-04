%Project
function Project1Script
clear all;
clc;
pkg load symbolic

s11 = polar(0.61, 165) %input Reflection coeff
s21 = polar(3.72, 59) %abs and square this and its forward power gain
s12 = polar(0.05, 42)
s22 = polar(0.45, -48)

portImpedance = 50;


%Section 3: Gain Block Stability and Intrinsic RF Characteristics 
[del,K] = K(s11,s12,s21,s22)



%Maximum available gain
GTMAX = abs(s21/s12) * (K - sqrt(K**2-1))

TPG = abs(s21) **2
inputVSWR = (1+abs(s11))/(1-abs(s11))
outputVSWR = (1+abs(s22))/(1-abs(s22))

%Section 4: IMN analysis


freq = 2E9
radFreq = 2*pi * freq
C = 100E-12
Xc = 1/(j*radFreq*C)

ZoTLine = 50;
ocLen = 0.197;
scLen = 0.066
ser1Len= 0.024
ser2Len = 0.120

portXcSeries = portImpedance + Xc;

ZocStub = - j * ZoTLine  * cot(2*pi*ocLen)
ZocParellelPort = (ZocStub*portXcSeries) / (ZocStub+ portXcSeries)
reflZocPort = (ZocParellelPort - ZoTLine)/(ZocParellelPort + ZoTLine)
Zs = ZoTLine * (1 + reflZocPort*e**(-j*4*pi*ser1Len))/(1 - reflZocPort*e**(-j*4*pi*ser1Len))

%Section 5: OMN analysis


ZscStub = j * ZoTLine * tan(2*pi*scLen)
ZscParalellPort = (ZscStub * portImpedance) / (ZscStub + portImpedance)
reflZscPort = (ZscParalellPort - ZoTLine) / (ZscParalellPort + ZoTLine)
ZL = ZoTLine * (1 + reflZscPort*e**(-j*4*pi*ser2Len))/(1 - reflZscPort*e**(-j*4*pi*ser2Len))
ZL = ZL + Xc

%Section 6: RF Performance Analysis
%Calculate Gamma in and gamma out and show stability
gammaL = (ZL - ZoTLine) / (ZL + ZoTLine)
gammaS = (Zs - ZoTLine) / (Zs + ZoTLine)

gammaIn = s11 + (s12*s21*gammaL) / (1 - s22*gammaL)
gammaOut = s22 + (s12*s21*gammaS) / (1-s11*gammaS)

%Verify Stability
magGammaIn = abs(gammaIn)
magGammaOut = abs(gammaOut)

%Calculate Max gain using the big eqn
tpg = maxGainSonly(s11,s12,s21,s22,gammaS,gammaL)


%calculate VSWR looking into IMN to sys and into OMN to sys
%First find ZinWhole
ZTL1 =  ZoTLine * (1 + gammaIn*e**(-j*4*pi*ser1Len))/(1 - gammaIn*e**(-j*4*pi*ser1Len))
ZwholeIn = Xc + (ZTL1 * ZocStub) / (ZocStub + ZTL1)

%Get the Zout
Zout = -ZoTLine * (gammaOut + 1) / (gammaOut - 1)
%add the cap in series
Zout = Zout + Xc
%back to the Reflection coeff
gammaOutwCap = (Zout - ZoTLine) / (Zout + ZoTLine)
ZTL2 =  ZoTLine * (1 + gammaOutwCap*e**(-j*4*pi*ser2Len))/(1 - gammaOutwCap*e**(-j*4*pi*ser2Len))
ZwholeOut = (ZTL2*ZscStub) / (ZTL2 + ZscStub)

%Now back into reflection and then into VSWR
gammaWholeOut = (ZwholeOut - ZoTLine) / (ZwholeOut + ZoTLine)
gammaWholeIn =  (ZwholeIn - ZoTLine) / (ZwholeIn + ZoTLine)

VSWRin = (1 + abs(gammaWholeIn)) / (1 - abs(gammaWholeIn))
VSWRout = (1 + abs(gammaWholeOut)) / (1 - abs(gammaWholeOut))

theta = linspace(0, 2*pi, 360);
plot(cos(theta), sin(theta), 'k');  % Plot the unit circle
axis equal; grid on;
title('Smith Chart');

abs(ZL)
end

%functions
function [del,K] = K(s11,s12,s21,s22)
  del = del(s11,s12,s21,s22)
  K = (1+ abs(del)**2 - abs(s11)**2 - abs(s22)**2)/ (2*abs(s12*s21))
  fprintf('|del| =%d\n', abs(del));
  fprintf('|K| =%d\n', abs(K));
  
end

function tpg = maxGainSonly(s11,s12,s21,s22, GammaS, GammaL)
  tpg = (1 - abs(GammaS)^2) * abs(s21)^2 * (1 - abs(GammaL)^2) / abs( (1 - s11*GammaS)*(1 - s22*GammaL) - s12*s21*GammaS*GammaL )^2;
  end