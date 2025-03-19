function [gammaIn, gammaOut] = IntrinsicReflectionCoeff(sparams, gammaL, gammaS)
  gammaIn  = sparams.s11 + (sparams.s12 * sparams.s21 * gammaL) / (1 - sparams.s22 * gammaL);
  gammaOut = sparams.s22 + (sparams.s12 * sparams.s21 * gammaS) / (1 - sparams.s11 * gammaS);
end
