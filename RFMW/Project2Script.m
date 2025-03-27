function Project2Script
  clear all;
  clc;
  freq = 150E6;
  sparams.s11 = polar(0.35, 165);
  sparams.s21 = polar(5.9,66);
  sparams.s12 = polar(0.035,58);
  sparams.s22 = polar(0.46,-31);
  
  noise.gammaOpt = polar(0.68, 142);
  noise.Fmin = 10^(1/10);
  noise.rn = 0.1;
  
  Ztermination= 75;

  sparams.Z0 = 50;
  Z0 = 50;
  
  
  disp("\n\n\t---\tQuestion 2 \t---\n\n"); 
  kvals = Kdisp(sparams);
  fprintf("\n\n\t---\t%d > 1 and %d < 1\t      ---\n \t---The system is unconditionally Stable---\n", abs(kvals.K), abs(kvals.del));
  mag = MAG(sparams);
  
  disp("\nNow we will display the TPG, Noise Figure (dB), input and output VSWR with the matching networks omitted \n(Only the active device):\n");
  
  omit.TPG = abs(sparams.s21)^2;
  omit.TPGdB = 10*log10(omit.TPG);
  refl = sparams.s11;
  omit.VSWRi = (1+refl) / (1-refl);
  refl = sparams.s22;
  omit.VSWRo = (1+refl) / (1-refl);
  noise.gammaS = (Ztermination - Z0) / (Ztermination+ Z0);
  omit.noiseFigure = noiseFigure(noise);
  omit.noiseFiguredB = 10*log10(omit.noiseFigure);
  fprintf("TPG = %d dB\nNoise Figure = F = %d dB\ninput VSWR = %d\noutput VSWR = %d\n", omit.TPGdB, omit.noiseFiguredB, omit.VSWRi,omit.VSWRo);
  
   disp("\n\n\t---\tQuestion 3 \t---\n\n"); 
   
   
   noise.gammaS = noise.gammaOpt;
   
   in.gamma = noise.gammaS;
   in.Z = reflToZ(in.gamma,sparams.Z0);
   S.gamma = conj(in.gamma);
   S.Z = conj(in.Z);
   
   out = gammaIn(sparams, noise.gammaS);
   L.gamma = conj(out.gamma);
   L.Z = conj(out.Z);
   fprintf("to minimize noise figure, Gamma S = Gamma Opt:\n\nGammaS= %d\nZs = %d\n\nThen I found GammaOut\n\nGammaOut = %d \n\nThen I conjugate matched gammaL to gamma Out to maximize gain:\n\n", in.gamma, S.Z,out.gamma);
   fprintf("GammaL = %d\nZL = %d\n", L.gamma, L.Z);
   
   disp("\n\n\t---\tQuestion 4 \t---\n\n");
   IMN = twoComponentLMatch(in.Z, Ztermination, freq);
   OMN = twoComponentLMatch(out.Z,Ztermination, freq);
      

   
   
endfunction


function F= noiseFigure(noise)
  F = noise.Fmin + (4*noise.rn * abs(noise.gammaS - noise.gammaOpt)^2)/((1-abs(noise.gammaS)^2)*abs(1+noise.gammaOpt)^2);
endfunction

function out = gammaIn(sparams, gammaS)
  out.gamma = sparams.s22 + (sparams.s12*sparams.s21*gammaS) / (1-sparams.s11*gammaS);
  out.Z = reflToZ(out.gamma, sparams.Z0);
  endfunction
  