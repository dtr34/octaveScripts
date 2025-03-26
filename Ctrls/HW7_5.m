pkg load symbolic
syms s K a

G1s =K/(s*(s+2)*(s+5));
Hs = s+a

Gs= G1s/(1+G1s*Hs-G1s);
Rs = 1/s
Es =  simplify (Rs / (1+Gs))

limEs = s*Es

limEs = simplify(subs(limEs,s,0))

dE = diff(limEs, a)

Sea = (a / (limEs) ) * dE
avals = linspace(-5,5,100)
subsea = double(subs(Sea, avals))

% Plot the expression for a range of a from 0 to 100
plot(avals, subsea)

% Add labels and title
xlabel('a')
ylabel('sensitivity')
title('Sensitivity vs a')
grid on