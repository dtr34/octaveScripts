clear;
% Load the symbolic package if needed (make sure it is installed)
pkg load symbolic

% Define the S-parameter variables using the polar function.
s11 = polar(0.48, -149);
s21 = polar(5.189, 89);
s12 = polar(0.073, 43);
s22 = polar(0.49, -39);

% Define gammaL and gammaS (update these values as needed)
gammaL = 0.25 + j*0.25;  % example value
gammaS = 0;  % example value

% Compute the intrinsic reflection coefficients.
[gammaIn, gammaOut] = IntrinsicReflectionCoeff(s11, s12, s21, s22, gammaL, gammaS);

magGammaIn = abs(gammaIn);
magGammaOut = abs(gammaOut);

%Rollett Stability metric example:
%Using delta and K, find whether a system is unconditionally stable
delta = abs(del(s11,s12,s21,s22));
K = K(s11,s12,s21,s22)

