function tpg = maxGainSonly(s11,s12,s21,s22, GammaS, GammaL)
  tpg = (1 - abs(GammaS)^2) * abs(s21)^2 * (1 - abs(GammaL)^2) / abs( (1 - s11*GammaS)*(1 - s22*GammaL) - s12*s21*GammaS*GammaL )^2;
  end