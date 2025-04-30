% PCB Assembly Helper Robot (PAH)


% Define symbolic variables
syms d1 d2 theta3 theta4 theta5 L3 L4 L5 L6 Px Py Pz gammaZ gammaY

lfront = L6 * sin(theta5);

eq1 = Px == L3 + L4 * cos(theta3) + lfront * sin(theta3 + theta4);
eq2 = Py == L4 * sin(theta3) - lfront * cos(theta3 + theta4) - d2;
eq3 = Pz == d1 + L5 + L6 * cos(theta5);
eq4 = gammaZ == theta3 + theta4;
eq5 = gammaY == -theta5;

% Solve the equations for the unknowns; note the use of curly braces
solnvec = solve([eq1, eq2, eq3, eq4, eq5], {d1, d2, theta3, theta4, theta5});

% Define the order of fields to display
fields_order = {'d1', 'd2', 'theta3', 'theta4', 'theta5'};

% Determine the number of solutions (solnvec is a cell array)
num_solutions = numel(solnvec);

sol_struct = solnvec{2};  % Use {} to access the i-th solution structure
fprintf('Solution:\n');
for j = 1:length(fields_order)
     field = fields_order{j};
     sol_value = sol_struct.(field);·
     fprintf('  %s = %s\n', field, char(sol_value));
end
    fprintf('\n');
