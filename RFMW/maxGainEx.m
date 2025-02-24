clear all;
close all;

Zo = 50

s11 = polar(0.61,165);
s12 = polar(0.05,42);
s21 = polar(3.72,59);
s22 = polar(0.45,-48);

[del, k] = K(polar(0.61,165), polar(0.05,42), polar(3.72, 59), polar(0.45,-48));

maxTPG = maxTPG(s12,s21,k); %Max TPG is also known as "MAG"

dB = 10 * log10(maxTPG)

%SCM

B1 = 1 - abs(del)**2 + abs(s11)**2 - abs(s22)**2
B2 = 1 - abs(del)**2 - abs(s11)**2 + abs(s22)**2

M = s11 - del * conj(s22)
N = s22 - del * conj(s11)

sourceReflectionMax = (B1 - sqrt(B1**2 - 4 *abs(M)**2)) / (2*M)
loadReflectionMax = (B2 - sqrt(B2**2 - 4 * abs(N)**2)) / (2*N)

%Converting back to impedance is a common difficulty
Zs = Zo * (1 + sourceReflectionMax) / (1 - sourceReflectionMax)