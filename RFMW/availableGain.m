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
