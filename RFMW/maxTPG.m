%maxTPG is also known as MAG
function maxTPG = maxTPG(s12, s21, K)
  maxTPG = abs(s21/s12) * (K-sqrt(K**2 -1))
end
