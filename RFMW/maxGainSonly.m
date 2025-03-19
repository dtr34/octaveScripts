function tpg = maxGainSonly(sparams, GammaS, GammaL)
  tpg = (1 - abs(GammaS)^2) * abs(sparams.s21)^2 * (1 - abs(GammaL)^2) / abs( (1 - sparams.s11*GammaS)*(1 - sparams.s22*GammaL) - sparams.s12*sparams.s21*GammaS*GammaL )^2;
  end