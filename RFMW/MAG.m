function maxavailablegain = MAG(s11,s12,s21,s22)
  kvals= K(s11,s12,s21,s22);
  maxavailablegain= maxTPG(s12,s21, kvals.K);
  endfunction