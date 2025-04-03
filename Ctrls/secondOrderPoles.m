function [pole1, pole2] = secondOrderPoles(zeta, wn)
  pole1 = -zeta*wn + wn * sqrt(zeta^2 -1)
  pole2 = -zeta*wn - wn * sqrt(zeta^2 -1)
end