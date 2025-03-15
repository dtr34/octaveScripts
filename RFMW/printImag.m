function printImag(z)
    % Convert angle from radians to degrees and format
    magnitude = abs(z);
    angle_deg = rad2deg(angle(z));
    
    % Create formatted string with proper symbols
    fprintf('%.2f∠%.2f°\n', magnitude, angle_deg);
end
