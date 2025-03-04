function Project1Wyatt
clear;
clc;
%% Basic Params
ZO = 50;
freq = 2e9;
lamda = 3e8 / 2e9;
w = 2*pi*freq;
%% Components Values
Cin = 100e-12;
Cout = 100e-12;
Cin_reactance = 1 / (1i*w*Cin);
Cout_reactance = 1 / (1i*w*Cin);
%% TL Lengths
OCTL_length = 0.197*lamda;
TLin_length = 0.024*lamda;
SCTL_length = 0.066*lamda;
TLout_length = 0.120*lamda;
%% S-Parameters and Del
s11 = beastpol2cart(0.61,165);
s12 = beastpol2cart(0.05,42);
s21 = beastpol2cart(3.72,59);
s22 = beastpol2cart(0.45,-48);
Del = getDel(s11,s12,s21,s22);

%% Part 3: Stability and Maximum Gain
fprintf('<strong>Part 3: Stability and Maximum Gain:\n</strong>');
K = getK(s11,s12,s21,s22,Del);
Kstring = sprintf('  K has a value of %0.5g and |\x0394| has a value %0.5g', K, abs(Del));
disp(Kstring);
fprintf('  Since K >1 and |\x0394| < 1 that means the gain two-port is unconditionally stable\n');
MSG = getMAG(s12,s21,K);
MSG_dB = 10*log10(MSG);
MSG_string = sprintf('  The maximum stable gain is %0.5g dB', MSG_dB);
disp(MSG_string);

%Without IMN and OMN
fprintf('Without OMN and IMN:\n')
MSG2 = abs(s21).^2;
MSG2_dB = 10*log10(MSG2);
VSWR_In = getVSWR(s11);
VSWR_Out = getVSWR(s22);
no_IMNstring = sprintf('   The MSG is %0.5g dB and the Input and Output VSWR''s are %0.5g and %0.5g respectively', MSG2_dB,VSWR_In,VSWR_Out);
disp(no_IMNstring);

%% Part 4: IMN Analysis
fprintf('<strong>Part 4: IMN Analysis\n</strong>');
OCTL_reactance = getOCStubTLReactance(freq,OCTL_length,ZO);
ZL_TLin = ((50 + Cin_reactance)*OCTL_reactance) / ((50 + Cin_reactance) + OCTL_reactance);
ZS = getTLInputImpedance(freq,TLin_length,ZO,ZL_TLin);
gamma_S = (ZS - ZO) / (ZS + ZO);
SourceString = sprintf('   ZS = %0.5g%0.5gj and \x0393S = %0.5g%0.5gj', real(ZS), imag(ZS), real(gamma_S),imag(gamma_S));
disp(SourceString);

%% Part 5: OMN Analysis
fprintf('<strong>Part 5: OMN Analysis\n</strong>');
SCTL_reactance = getSCStubTLReactance(freq,SCTL_length,ZO);
ZL_TLout = ((50*SCTL_reactance) / (50 + SCTL_reactance));
ZL = getTLInputImpedance(freq,TLout_length,ZO,ZL_TLout) + Cout_reactance;
gamma_L = (ZL - ZO) / (ZL + ZO);
LoadString = sprintf('   ZL = %0.5g+%0.5gj and \x0393L = %0.5g+%0.5gj', real(ZL), imag(ZL), real(gamma_L),imag(gamma_L));
disp(LoadString);


%% Part 6: RF Perfomance Analysis
%Reflection coefficient
fprintf('<strong>Part 6: RF Performance Analysis\n</strong>');
gamma_out = getGammaOut(s11,s12,s21,s22,gamma_S);
gamma_in = getGammaIn(s11,s12,s21,s22,gamma_L);
gammaString = sprintf('   \x0393in = %0.5g+%0.5gj and \x0393out = %0.5g%0.5gj', real(gamma_in),imag(gamma_in),real(gamma_out),imag(gamma_out));
disp(gammaString);
mag_string = sprintf('   |\x0393in| = %0.5g, |\x0393out| = %0.5g, |\x0393S| = %0.5g, |\x0393L| = %0.5g\n   Since each of these are less than 1 the amplifier is stable', abs(gamma_in),abs(gamma_out),abs(gamma_S),abs(gamma_L));
disp(mag_string);
%TPG
TPG = getTPG(s11,s12,s21,s22,gamma_S,gamma_L);
TPG_dB = 10*log10(TPG);
TPG_string = sprintf('   The TPG of this amplifier is %0.5g dB which is neraly equal to the Maximum TPG calculated earlier',TPG_dB);
disp(TPG_string);
%VSWR Input
Zin = ZO*((gamma_in + 1) / (1 - gamma_in));
Zin_TLin2 = getTLInputImpedance(freq,TLin_length,ZO,Zin);
Zin_total = Cin_reactance + ((OCTL_reactance*Zin_TLin2) / (OCTL_reactance + Zin_TLin2));
gamma_inTotal = (Zin_total - ZO) / (Zin_total + ZO);
VSWR_inTotal = getVSWR(gamma_inTotal);
%VSWR Output
Zout = ZO*((gamma_out + 1) / (1 - gamma_out));
Zout_TLout = getTLInputImpedance(freq,TLout_length,ZO,(Zout + Cout_reactance));
Zout_total = (SCTL_reactance*Zout_TLout) / (SCTL_reactance + Zout_TLout);
gamma_outTotal = (Zout_total - ZO) / (Zout_total + ZO);
VSWR_outTotal = getVSWR(gamma_outTotal);
VSWR_String = sprintf('   The Total Output VSWR = %0.5g and the Total Input VSWR = %0.5g', VSWR_outTotal, VSWR_inTotal);
disp(VSWR_String);


%% Smith Chart Code
%Frequency Range
frequency_range = linspace(1e9,3e9,100);
%Capacitor reactance
Z_C = 1 ./ (1i.*(2.*pi.*frequency_range).*Cout);
%TL lengths 
SC_length = 0.066.*(3e8 ./ frequency_range);
OC_length = 0.197.*(3e8 ./ frequency_range);
TL_outLength = 0.120.*(3e8 ./ frequency_range);
TL_inLength = 0.024.*(3e8 ./ frequency_range);
%OC/SC reactances
SC_reactance = getSCStubTLReactance(frequency_range,SC_length,ZO);
OC_reactance = getOCStubTLReactance(frequency_range,OC_length,ZO);
%TL out input Impedance from left
ZL_TLout_Smith = ((50.*SC_reactance) ./ (50 + SC_reactance));
Z_L_Smith = getTLInputImpedance(frequency_range,TL_outLength,ZO,ZL_TLout_Smith) + Z_C;
gamma_Lsmith = (Z_L_Smith - ZO) ./ (Z_L_Smith + ZO);
%TLIn input impedance from left
gamma_insmith = getGammaIn(s11,s12,s21,s22,gamma_Lsmith);
Zin_smith = ZO.*((gamma_insmith + 1) ./ (1 - gamma_insmith));
Zin_TLin = getTLInputImpedance(frequency_range,TL_inLength,ZO,Zin_smith);
%Impedace combinatin for overall input impedance
Zin_total2 = Z_C + ((OC_reactance.*Zin_TLin) ./ (OC_reactance + Zin_TLin));
gamma_inTotal2 = (Zin_total2 - ZO) ./ (Zin_total2 + ZO);


s = smithplot(frequency_range,gamma_inTotal2);
hold on;
s.Marker = {'+'};
end

function Zin = getOCStubTLReactance(freq,length,ZO)
    lamda = 3e8 ./ freq;
    Zin = -1i.*ZO.*cot(((2.*pi.*length) ./ lamda));
end

function Zin = getTLInputImpedance(freq, length, ZO, ZL)
    lamda = 3e8 ./ freq;
    gamma = (ZL - ZO) ./ (ZL + ZO);
    

    num = 1 + gamma.*exp(-((1i.*4.*pi.*length) ./ lamda));
    denom = 1 - gamma.*exp(-((1i.*4.*pi.*length) ./ lamda));

    Zin = ZO.*(num/denom);
end

function Zin = getSCStubTLReactance(freq,length,ZO)
    lamda = 3e8 ./ freq;
    Zin = 1i.*ZO.*tan(((2.*pi.*length) ./ lamda));
end

function VSWR = getVSWR(gamma)
    g = abs(gamma);
    VSWR = (1 + g) / (1 - g);
end

function beastpol2cart = beastpol2cart(mag,deg)
    ang = deg2rad(deg);
    [r,i] = pol2cart(ang,mag);
    beastpol2cart = r + 1i*i;
end

function getDel = getDel(s11, s12, s21, s22)
    getDel = s11*s22 - s12*s21;
end

function getK = getK(s11, s12, s21, s22, Del)
    getK = (1 + ((abs(Del)).^2) - ((abs(s11)).^2) - ((abs(s22)).^2)) / (2*abs((s12*s21))); 
end

function getMAG = getMAG(s12,s21,K)
    getMAG = abs(s21/s12) * (K - sqrt(K.^2 - 1));
end

function getGammaIn = getGammaIn(s11,s12,s21,s22,gamma_L)
    getGammaIn = s11 + (s12*s21*gamma_L) / (1 - s22*gamma_L);
end

function getGammaOut = getGammaOut(s11,s12,s21,s22,gamma_S)
    getGammaOut = s22 + (s12*s21*gamma_S) / (1 - s11*gamma_S);
end

function TPG = getTPG(s11,s12,s21,s22,gamma_S,gamma_L)
    gamma_LMag = abs(gamma_L);
    gamma_SMag = abs(gamma_S);

    num = (1 - (gamma_SMag.^2))*(abs(s21).^2)*(1 - (gamma_LMag.^2));
    denom = (abs(((1 - (s11*gamma_S))*(1 - (s22*gamma_L)) - (s12*s21*gamma_S*gamma_L))).^2);

    TPG = (num / denom);
end











