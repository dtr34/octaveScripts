pkg load symbolic;
syms s t;
iLt = ilaplace(4/(s*(5E-3*s +1E3)));
disp(iLt);

tsoln = vpasolve(iLt == 2E-3, t);
disp(tsoln);

