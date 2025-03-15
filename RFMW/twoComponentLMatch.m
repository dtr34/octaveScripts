function M = twoComponentLMatch(Zs,RL, freq)
  
  radFreq = freq * 2*pi;
  Xs = imag(Zs);
  Rs = real(Zs);

  reactancesSeries = twoComponentLMatchSeries(Xs,Rs,RL);
  reactancesParallel = twoComponentLMatchParallel(Xs,Rs,RL);
  fprintf("\nSeries First Reactances:\n");
  componentValues(radFreq, reactances);
  fprintf("\nParallel First Reactances:\n");
  componentValues(radFreq, reactances);
  
  
endfunction

function componentValues = calculateComponents(omega, reactances)
  
    % Initialize output structure
    componentValues = struct();
    fields = fieldnames(reactances);
    
    for i = 1:length(fields)
        X = reactances.(fields{i});
        
        if X > 0
            % Inductive reactance (X = ωL)
            componentValues.(fields{i}) = struct(...
                'Type', 'Inductor', ...
                'Value', X / omega, ...
                'Unit', 'H');
        else
            % Capacitive reactance (X = -1/(ωC))
            componentValues.(fields{i}) = struct(...
                'Type', 'Capacitor', ...
                'Value', -1/(omega * X), ...
                'Unit', 'F');
        end
    end
    
    % Display results
    fprintf('\nComponent Values at ω = %.2f rad/s:\n', omega);
    fprintf('------------------------------------\n');
    
    for i = 1:length(fields)
        comp = componentValues.(fields{i});
        fprintf('%s:\n', fields{i});
        fprintf('  Type: %s\n', comp.Type);
        
        if strcmp(comp.Type, 'Inductor')
            fprintf('  Value: %.4e H\n', comp.Value);
        else
            % Convert to more readable units if needed
            if comp.Value < 1e-6
                fprintf('  Value: %.2f µF\n', comp.Value*1e6);
            elseif comp.Value < 1e-3
                fprintf('  Value: %.2f nF\n', comp.Value*1e9);
            else
                fprintf('  Value: %.4e F\n', comp.Value);
            end
        end
        fprintf('------------------------------------\n');
    end
end
