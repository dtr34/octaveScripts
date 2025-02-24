function [gammaIn, gammaOut] = IntrinsicReflectionCoeff(s11, s12, s21, s22, gammaL, gammaS)
  gammaIn  = s11 + (s12 * s21 * gammaL) / (1 - s22 * gammaL);
  gammaOut = s22 + (s12 * s21 * gammaS) / (1 - s11 * gammaS);
end
