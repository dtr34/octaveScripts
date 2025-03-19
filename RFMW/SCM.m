function gammaField = SCM(sparams)
  deltaTemp = del(sparams);
  B1 = 1 + abs(sparams.s11)^2 - abs(sparams.s22)^2 - abs(deltaTemp)^2;
  B2 = 1 + abs(sparams.s22)^2 -abs(sparams.s11)^2 - abs(deltaTemp)^2;
  M = sparams.s11 - conj(sparams.s22)*deltaTemp;
  N = sparams.s22 - conj(sparams.s11)*deltaTemp;
  
  gammaField.S = (B1-sqrt(B1^2-4*abs(M)^2)) / (2*M);
  gammaField.L = (B2 - sqrt(B2^2 - 4*abs(N)^2) )/ (2*N);
  fprintf("gammaS: ");
  printImag(gammaField.S);
  fprintf("gammaL: ");
  printImag(gammaField.L);
  endfunction