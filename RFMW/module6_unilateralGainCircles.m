function module6_unilateralGainCircles
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

u = uMerit(sparams)

gtuMax = unilateralTPGmax(sparams);
 
  
  
endfunction


function GTU = unilateralTPG(sparams,gammaS,gammaL)
  GTU = (1 - abs(gammaS)^2) / abs(1 - sparams.s11*gammaS)^2 * (1-abs(gammaL)^2)/(1 - sparams.s22 *abs(gammaL)^2) * abs(s21)^2;
endfunction

function GTUmax = unilateralTPGmax(sparams)
  GTUmax.gtu= 1/(1-abs(sparams.s11)^2) * 1/(1-abs(sparams.s22)^2) * abs(sparams.s21)^2;
  GTUmax.G1 = 1/(1-abs(sparams.s11)^2);
  GTUmax.G2 = 1/(1-abs(sparams.s22)^2);
  GTUmax.G0 = abs(sparams.s21)^2;
  db = 10*log10(GTUmax.gtu);
 fprintf("max possible gain in dB = %d", db); 
  
endfunction

function GTU = unilateralGainCircle(sparams, gammaS,gammaL) 
  GTU.G1 =  (1 - abs(gammaS)^2) / abs(1 - sparams.s11*gammaS)^2 ;
  GTU.G2 = (1-abs(gammaL)^2)/(1 - sparams.s22 *abs(gammaL)^2);
  GTU.g1 = GTU.G1 * (1-abs(sparams.s11)^2)
  GTU.C1 = (GTU.g1 * conj(sparams.s11)) ...
                    / (1-abs(sparams.s11)^2*(1-GTU.g1));
  GTU.r1 = (sqrt(1-GTU.g1)*(1-abs(sparams.s11)^2)) ...
                  / (1-abs(sparams.s11)^2 * (1-GTU.g1));
                  
  GTU.g2 = GTU.G2 * (1-abs(sparams.s22)^2)
  GTU.C2 = (GTU.g2 * conj(sparams.s22)) ...
                    / (1-abs(sparams.s22)^2*(1-GTU.g2));
  GTU.r2 = (sqrt(1-GTU.g2)*(1-abs(sparams.s22)^2)) ...
                  / (1-abs(sparams.s22)^2 * (1-GTU.g2));
endfunction

function u = uMerit(sparams)
  u = (abs(sparams.s11*sparams.s12*sparams.s21*sparams.s22)) / ...
          ((1-abs(sparams.s11)^2) * (1-abs(sparams.s22)^2));
         
 endfunction
 
 
 
 
 