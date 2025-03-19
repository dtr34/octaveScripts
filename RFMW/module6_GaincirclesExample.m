function module6_GaincirclesExample
clear all;
clc;

%We are designing the appropriate IMN and OMN
%To get TPG=14.1dB at 1.5 GHz

sparams.s11 = polar(0.8, 120);
sparams.s12 = polar(0.02, 62);
sparams.s21 = polar(4.0, 60);
sparams.s22 = polar(0.2, -30);

Zo = 50;
freq = 1.5E6;

%first check stability
disp("First Check Stability\n");
Kvals = Kdisp(sparams);
disp("\nThen check MAG to ensure 14.1dB is possible\n");

MAG(sparams);
gaindb = 14.1;
desiredGain = 10^(gaindb/10)

gainCircle = availableGain(sparams, desiredGain)

printImag(gainCircle.CA);
plotStabilityCircle(gainCircle.CA,gainCircle.rA);


endfunction


function M = availableGain(sParams, varargin)
% Handle both parameter combinations:
% 1. availableGain(sParams, gammaS, gammaOut)
% 2. availableGain(sParams, desiredGain)

    % Common calculations
    KVals = K(sParams);
    M = struct();  % Initialize output structure
    
    if nargin == 3
        % Case 1: sParams, gammaS, gammaOut
        gammaS = varargin{1};
        gammaOut = varargin{2};
        
        M.gA = (1 - abs(gammaS)^2) / abs(1 - sParams.s11*gammaS)^2 * (1/(1 - abs(gammaOut)^2));
        M.GA = M.gA * abs(sParams.s21)^2;
        
    elseif nargin == 2
        % Case 2: sParams, desiredGain
        desiredGain = varargin{1};
        M.gA = desiredGain / abs(sParams.s21)^2;
        
    else
        error('Invalid number of arguments. Use either 2 or 3 input parameters.');
    end
    
    % Common calculations for both cases
    M.CA = (M.gA * conj(sParams.s11 - KVals.del * conj(sParams.s22))) / ...
          (1 + M.gA*(abs(sParams.s11)^2 - abs(KVals.del)^2));
    
    M.rA = sqrt(1 - 2*KVals.K*abs(sParams.s12*sParams.s21)*M.gA + ...
              (abs(sParams.s12*sParams.s21)*M.gA).^2) / ...
              abs(1 + M.gA*(abs(sParams.s11)^2 - abs(KVals.del)^2));
end


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

  