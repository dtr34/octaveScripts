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
  
  %
  disp("\n\n\t---\tQuestion 2 \t---\n\n"); 
  kvals = Kdisp(sparams);
  fprintf("\n\n\t---\t%d > 1 and %d < 1\t      ---\n \t---The system is unconditionally Stable---\n", abs(kvals.K), abs(kvals.del));
  mag = MAG(sparams);
  
  disp("\nNow we will display the TPG, Noise Figure (dB), input and output VSWR with the matching networks omitted \n(Only the active device):\n");
  gammaS1 = (Ztermination - Z0 )/ (Ztermination + Z0);
  gammaL1 = gammaS1;
  gammaInTermination = gammaIn(sparams, gammaL1);
  gammaOutTermination = gammaOut(sparams, gammaS1);
  
  omit.TPG = maxGainSonly(sparams, gammaS1, gammaL1);
  omit.TPGdB = 10*log10(omit.TPG);
  
  omit.VSWRi = getInputVSWR(gammaInTermination.gamma, gammaS1);
  omit.VSWRo = getOutputVSWR(gammaOutTermination.gamma, gammaL1);
  noise.gammaS = (Ztermination - Z0) / (Ztermination+ Z0);
  omit.noiseFigure = noiseFigure(noise);
  omit.noiseFiguredB = 10*log10(omit.noiseFigure);
  fprintf("TPG = %d dB\nNoise Figure = F = %d dB\ninput VSWR = %d\noutput VSWR = %d\n", omit.TPGdB, omit.noiseFiguredB, omit.VSWRi,omit.VSWRo);
  %
   disp("\n\n\t---\tQuestion 3 \t---\n\n"); 
   
   
   noise.gammaS = noise.gammaOpt;
   S.gamma = noise.gammaOpt;
   S.Z = reflToZ(S.gamma, Z0);
   
   out = gammaOut(sparams, noise.gammaS);
  
   L.gamma = conj(out.gamma);
   L.Z = conj(out.Z);
   
fprintf("to minimize noise figure, Gamma S = Gamma Opt:\n\n");
fprintf("GammaS = %f + %fi\n", real(S.gamma), imag(S.gamma));
fprintf("Zs    = %f + %fi\n\n", real(S.Z), imag(S.Z));

fprintf("Then I found GammaOut\n\n");
fprintf("GammaOut = %f + %fi\n\n", real(out.gamma), imag(out.gamma));

fprintf("Then I conjugate matched gammaL to gamma Out to maximize gain:\n\n");
fprintf("GammaL = %f + %fi\n", real(L.gamma), imag(L.gamma));
fprintf("ZL     = %f + %fi\n", real(L.Z), imag(L.Z));

  % 
   disp("\n\n\t---\tQuestion 4 \t---\n\n");
   IMN = twoComponentLMatch(S.Z, Ztermination, freq);
   %
   disp("\n\n\t---\tQuestion 5 \t---\n\n");
   OMN = twoComponentLMatch(L.Z,Ztermination, freq);
   %
   disp("\n\n\t---\tQuestion 6 \t---\n\n");
   
   disp("The ZL is the same as question 3, but the nF cap should be in series with it\n");
   
   ZL = ( 1/(j*freq*2*pi*1E-9) + L.Z);
   gamaell = (ZL - Z0) / (ZL+Z0);
   
   tpgeezy = maxGainSonly(sparams, S.gamma, gamaell);
   tpdbeezy = 10*log10(tpgeezy);
   
   in = gammaIn(sparams, gamaell);
   eff = noiseFigure(noise);
   effdb = 10*log10(eff);
   
   VSWRin = getInputVSWR(in.gamma, noise.gammaS);
   VSWRout= getOutputVSWR( out.gamma, gamaell);
   
   fprintf("\nTPG = %d dB\nF = %d dB\nVSWR at the input = %d\nVSWR at the output = %d\n", tpdbeezy, effdb,VSWRin,VSWRout);
   

   
   
endfunction
function Kfield = K(sparams)
  del = del(sparams);
  K = (1+ abs(del)**2 - abs(sparams.s11)**2 - abs(sparams.s22)**2)/ (2*abs(sparams.s12*sparams.s21));
  Kfield.del = del;
  Kfield.K = K;
  
end

function Kfield = Kdisp(sparams)
  function maxTPG = maxTPG(s12, s21, K)
  maxTPG = abs(s21/s12) * (K-sqrt(K**2 -1));
end

  del = del(sparams);
  K = (1+ abs(del)**2 - abs(sparams.s11)**2 - abs(sparams.s22)**2)/ (2*abs(sparams.s12*sparams.s21));
  Kfield.del = del;
  Kfield.K = K;
  fprintf('|del| =%d\n', abs(del));
  fprintf('|K| =%d\n', abs(K));
  
end

function maxavailablegain = MAG(sparams)
  kvals= K(sparams);
  maxavailablegain= maxTPG(sparams.s12,sparams.s21, kvals.K);
  fprintf("MAG: %d \t or\t%d dB\n", maxavailablegain, 10*log10(maxavailablegain));
  
endfunction

function Zs = reflToZ(refl, Zref)
Zs = Zref * (1 + refl) / (1 - refl);
endfunction
%Zs and RL should both be looking into the IMN/OMN
function M = twoComponentLMatch(Zs,RL, freq)
  
  radFreq = freq * 2*pi;
  Xs = -imag(Zs);
  Rs = real(Zs);
if (RL < Rs)
    disp("no series solutions")
   
    M.reactancesParallel = twoComponentLMatchParallel(Xs,Rs,RL);
    fprintf("\nParallel First Reactances:\n");
    calculateComponents(radFreq, M.reactancesParallel);
else
    M.reactancesParallel = twoComponentLMatchParallel(Xs,Rs,RL);
    fprintf("\nParallel First Reactances:\n");
    M.componentsParallel = calculateComponents(radFreq, M.reactancesParallel);
    M.reactancesSeries = twoComponentLMatchSeries(Xs,Rs,RL);
    fprintf("\nSeries First Reactances:\n");
    M.componentsSeries = calculateComponents(radFreq, M.reactancesSeries);
  endif
  
  
  %when you come back to this: you will need to move the componentValues call into the individual
  %functions, so that the no solution error check works.
  
endfunction
function reactances = twoComponentLMatchParallel(Xs,Rs,RL)

  % Define the source impedance: Zs = Rs + j*Xs
  Zs = Rs + 1j*Xs;
  
  % For the two‐component L-match network, the quadratic equation in s is:
  %   (RL - Rs)*s^2 + (2*Xs*RL)*s + RL*|Zs|^2 = 0
  % where |Zs|^2 = Rs^2 + Xs^2.
  A = RL - Rs;
  B = 2 * Xs * RL;
  C = RL*(Rs^2 + Xs^2);
  
  % Calculate discriminant
  disc = sqrt(B^2 - 4*A*C);
  
  % Use the quadratic formula:
  % s = (-B ± disc) / (2*A)
  % Assign the positive square-root branch to Xpar1 and the negative to Xpar2.
  Xpar1 = (-B + disc) / (2*A)
  Xpar2 = (-B - disc) / (2*A)
  
  % Now, compute the series reactance values.
  % The formulas below are as given with j as the imaginary unit.
  Xser1 = -imag((1j*Xpar1*Zs) / (1j*Xpar1 + Zs))
  Xser2 = -imag((1j*Xpar2*Zs) / (1j*Xpar2 + Zs))
  reactances = struct(...
        'Xpar1', Xpar1, ...
        'Xser1', Xser1, ...
        'Xpar2', Xpar2, ...
        'Xser2', Xser2);
end
function reactances = twoComponentLMatchSeries(Xs,Rs,RL)
  if (RL < Rs)
    disp("no solutions")
    return;
  endif
  Xpar1 = sqrt((RL**2*Rs)/(RL-Rs))
  Xser1 = -Xs - imag((j*Xpar1*RL)/(j*Xpar1 +RL))
  Xpar2 = -sqrt((RL**2*Rs)/(RL-Rs))
  Xser2 = -Xs - imag((j*Xpar2*RL)/(j*Xpar2 +RL))
  reactances = struct(...
        'Xpar1', Xpar1, ...
        'Xser1', Xser1, ...
        'Xpar2', Xpar2, ...
        'Xser2', Xser2);
  
  endfunction
function componentValues = calculateComponents(omega, reactances)
  
    % Initialize output structure
    componentValues = struct();
    fields = fieldnames(reactances);
    
    for i = 1:length(fields)
        X = reactances.(fields{i});
        
        if X > 0
            % Inductive reactance (X = ωL)
            componentValues.(fields{i}) = struct(...
                'Type', 'Inductor', ...
                'Value', X / omega, ...
                'Unit', 'H');
        else
            % Capacitive reactance (X = -1/(ωC))
            componentValues.(fields{i}) = struct(...
                'Type', 'Capacitor', ...
                'Value', -1/(omega * X), ...
                'Unit', 'F');
        end
    end
    
    % Display results
    fprintf('\nComponent Values at ω = %.2f rad/s:\n', omega);
    fprintf('------------------------------------\n');
    
    for i = 1:length(fields)
        comp = componentValues.(fields{i});
        fprintf('%s:\n', fields{i});
        fprintf('  Type: %s\n', comp.Type);
        
        if strcmp(comp.Type, 'Inductor')
           if comp.Value < 1e-9
                fprintf('  Value: %.4f pH\n', comp.Value*1e12);
            elseif comp.Value < 1e-6
                fprintf('  Value: %.4f nH\n', comp.Value*1e9);
            elseif comp.Value < 1e-3
                fprintf('  Value: %.4f µH\n', comp.Value*1e6);
            elseif comp.Value < 1e-1
                fprintf('  Value: %.4f mH\n', comp.Value*1e3);
            else
                fprintf('  Value: %.4e F\n', comp.Value);
            end

        else
            % Convert to more readable units if needed
            if comp.Value < 1e-9
                fprintf('  Value: %.4f pF\n', comp.Value*1e12);
            elseif comp.Value < 1e-6
                fprintf('  Value: %.4f nF\n', comp.Value*1e9);
            elseif comp.Value < 1e-3
                fprintf('  Value: %.4f µF\n', comp.Value*1e6);
            elseif comp.Value < 1e-1
                fprintf('  Value: %.4f mF\n', comp.Value*1e3);
            else
                fprintf('  Value: %.4e F\n', comp.Value);
            end
        end
        fprintf('------------------------------------\n');
    end
end

function F= noiseFigure(noise)
  F = noise.Fmin + (4*noise.rn * abs(noise.gammaS - noise.gammaOpt)^2)/((1-abs(noise.gammaS)^2)*abs(1+noise.gammaOpt)^2);
endfunction

function out = gammaOut(sparams, gammaS)
  out.gamma = sparams.s22 + (sparams.s12*sparams.s21*gammaS) / (1-sparams.s11*gammaS);
  out.Z = reflToZ(out.gamma, sparams.Z0);
endfunction

function in = gammaIn(sparams, gammaL)
  in.gamma = sparams.s11 + (sparams.s12*sparams.s21*gammaL) / (1-sparams.s22*gammaL);
  in.Z = reflToZ(in.gamma, sparams.Z0);
endfunction

function VSWR = getInputVSWR(gammaIn, gammaS1)
  gammaI = abs((gammaIn - conj(gammaS1)) / (1 - gammaIn*gammaS1));
  VSWR = (1+gammaI) / (1-gammaI);
endfunction

function VSWR = getOutputVSWR(gammaOut, gammaL)
  gammaO = abs((gammaOut - conj(gammaL)) / (1 - gammaOut*gammaL));
  VSWR = (1+gammaO) / (1-gammaO);
  endfunction
  