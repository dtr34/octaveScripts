function maxavailablegain = MAG(sparams)
  kvals= K(sparams);
  maxavailablegain= maxTPG(sparams.s12,sparams.s21, kvals.K);
  fprintf("MAG: %d \t or\t%d dB\n", maxavailablegain, 10*log10(maxavailablegain));
  
  endfunction