function out = secondOrderFromTF(sys)
    % Ensure the system is a transfer function
    if ~isa(sys, 'tf')
        error('Input must be a transfer function object (tf).');
    end

    % Get numerator and denominator coefficients
    [num, den] = tfdata(sys, 'v');

    % Ensure it is a 2nd-order system
    if length(den) ~= 3
        error('This function expects a 2nd-order transfer function.');
    end

    % Extract coefficients
    a = den(2);
    wn = sqrt(den(3));
    zeta = a / (2 * wn);

    % Populate output
    out.wn = wn;
    out.zeta = zeta;
    poles = pole(sys)
    secondOrderResponse(zeta, wn)
end