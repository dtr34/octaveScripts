function Kfield = Kdisp(sparams)
  del = del(sparams);
  K = (1+ abs(del)**2 - abs(sparams.s11)**2 - abs(sparams.s22)**2)/ (2*abs(sparams.s12*sparams.s21));
  Kfield.del = del;
  Kfield.K = K;
  fprintf('|del| =%d\n', abs(del));
  fprintf('|K| =%d\n', abs(K));
  
end