function Kfield = K(s11,s12,s21,s22)
  del = del(s11,s12,s21,s22);
  K = (1+ abs(del)**2 - abs(s11)**2 - abs(s22)**2)/ (2*abs(s12*s21));
  Kfield.del = del;
  Kfield.K = K;
  fprintf('|del| =%d\n', abs(del));
  fprintf('|K| =%d\n', abs(K));
  
end
