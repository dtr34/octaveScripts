function mod_angle = checkRootLocusAngle(tf_sys, s0)
    % Extract zeros and poles
    z = zero(tf_sys);
    p = pole(tf_sys);
    
    % Compute angle contributions
    angle_sum = 0;
    for i = 1:length(z)
        angle_sum = angle_sum + angle(s0 - z(i));
    end
    for i = 1:length(p)
        angle_sum = angle_sum - angle(s0 - p(i));
    end
    
    % Convert to degrees and normalize to [-180, 180]
    angle_deg = rad2deg(angle_sum);
    mod_angle = mod(angle_deg + 180, 360) - 180;
end
