function z = polar(magnitude, angleDeg)
  % Convert angle from degrees to radians and compute the complex number.
  z = magnitude * exp(1i * (angleDeg * pi/180));
end
