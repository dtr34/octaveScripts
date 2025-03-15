function gammaField = SCM(s11,s12, s21,s22)
  deltaTemp = del(s11,s12,s21,s22);
  B1 = 1 + abs(s11)^2 - abs(s22)^2 - abs(deltaTemp)^2;
  B2 = 1 + abs(s22)^2 -abs(s11)^2 - abs(deltaTemp)^2;
  M = s11 - conj(s22)*deltaTemp;
  N = s22 - conj(s11)*deltaTemp;
  
  gammaField.S = (B1-sqrt(B1^2-4*abs(M)^2)) / (2*M);
  gammaField.L = (B2 - sqrt(B2^2 - 4*abs(N)^2) )/ (2*N);
  fprintf("gammaS: ");
  printImag(gammaField.S);
  fprintf("gammaL: ");
  printImag(gammaField.L);
  endfunction