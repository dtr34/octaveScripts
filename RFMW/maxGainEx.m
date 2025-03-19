clear all;
close all;

Zo = 50

sparams.s11 = polar(0.61,165);
sparams.s12 = polar(0.05,42);
sparams.s21 = polar(3.72,59);
sparams.s22 = polar(0.45,-48);

Kvals = K(sparams);

maxTPG = MAG(sparams); %Max TPG is also known as "MAG"

dB = 10 * log10(maxTPG)

%SCM

B1 = 1 - abs(Kvals.del)**2 + abs(sparams.s11)**2 - abs(sparams.s22)**2
B2 = 1 - abs(Kvals.del)**2 - abs(sparams.s11)**2 + abs(sparams.s22)**2

M = sparams.s11 - Kvals.del * conj(sparams.s22)
N = sparams.s22 - Kvals.del * conj(sparams.s11)

sourceReflectionMax = (B1 - sqrt(B1**2 - 4 *abs(M)**2)) / (2*M)
loadReflectionMax = (B2 - sqrt(B2**2 - 4 * abs(N)**2)) / (2*N)

%Converting back to impedance is a common difficulty
Zs = Zo * (1 + sourceReflectionMax) / (1 - sourceReflectionMax)