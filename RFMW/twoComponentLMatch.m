function M = twoComponentLMatch(Zs,RL, freq)
  
  radFreq = freq * 2*pi;
  Xs = imag(Zs);
  Rs = real(Zs);
if (RL < Rs)
    disp("no series solutions")
   
    M.reactancesParallel = twoComponentLMatchParallel(Xs,Rs,RL);
    fprintf("\nParallel First Reactances:\n");
    calculateComponents(radFreq, M.reactancesParallel);
else
    M.reactancesParallel = twoComponentLMatchParallel(Xs,Rs,RL);
    fprintf("\nParallel First Reactances:\n");
    M.componentsParallel = calculateComponents(radFreq, M.reactancesParallel);
    M.reactancesSeries = twoComponentLMatchSeries(Xs,Rs,RL);
    fprintf("\nSeries First Reactances:\n");
    M.componentsSeries = calculateComponents(radFreq, M.reactancesSeries);
  endif
  
  
  %when you come back to this: you will need to move the componentValues call into the individual
  %functions, so that the no solution error check works.
  
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
           if comp.Value < 1e-9
                fprintf('  Value: %.4f pH\n', comp.Value*1e12);
            elseif comp.Value < 1e-6
                fprintf('  Value: %.4f nH\n', comp.Value*1e9);
            elseif comp.Value < 1e-3
                fprintf('  Value: %.4f µH\n', comp.Value*1e6);
            elseif comp.Value < 1e-1
                fprintf('  Value: %.4f mH\n', comp.Value*1e3);
            else
                fprintf('  Value: %.4e F\n', comp.Value);
            end

        else
            % Convert to more readable units if needed
            if comp.Value < 1e-9
                fprintf('  Value: %.4f pF\n', comp.Value*1e12);
            elseif comp.Value < 1e-6
                fprintf('  Value: %.4f nF\n', comp.Value*1e9);
            elseif comp.Value < 1e-3
                fprintf('  Value: %.4f µF\n', comp.Value*1e6);
            elseif comp.Value < 1e-1
                fprintf('  Value: %.4f mF\n', comp.Value*1e3);
            else
                fprintf('  Value: %.4e F\n', comp.Value);
            end
        end
        fprintf('------------------------------------\n');
    end
end
