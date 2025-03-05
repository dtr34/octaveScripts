function [Xpar1,Xser1,Xpar2,Xser2] = twoComponentLMatchParallel(Xs,Rs,RL)
  % Check for validity of solution
  if (RL > Rs)
    disp("no solutions")
    return;
  end

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
end
