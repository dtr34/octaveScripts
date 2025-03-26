function plotStabilityCircle(CA, rA)
  % Set up the figure
  figure;
  hold on;
  axis equal;
  grid on;

  % Set axis limits
  xlim([-1, 1]);
  ylim([-1, 1]);

  % Plot the circle
  theta = linspace(0, 2*pi, 1000);
  x = real(CA) + rA * cos(theta);
  y = imag(CA) + rA * sin(theta);
  
  
  plot(x, y, 'b-', 'LineWidth', 2);

  % Plot the center point
  plot(real(CA), imag(CA), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');

  % Add labels and title
  xlabel('Real');
  ylabel('Imaginary');
  title('Stability Circle');


  % Plot the origin
  plot(0, 0, 'k+', 'MarkerSize', 10, 'LineWidth', 1);

  % Add legend
  legend('Stability Circle', 'Center (CA)', 'origin', 'Location', 'northeast');
  
  hold off;
endfunction