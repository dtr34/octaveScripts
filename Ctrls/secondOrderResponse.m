function secondOrderResponse(zeta, natFreq)
e = exp(1);
  OS = e^((-zeta*pi)/(sqrt(1-zeta^2))) * 100
  Tp = (pi)/(natFreq * sqrt(1-zeta^2))
  Ts = 4 / (zeta * natFreq)
  Tr = (1.76 * zeta^3 - 0.417 * zeta ^ 2 + 1.039 * zeta +  1) / (natFreq)
end
