pkg load symbolic

syms s

IL = (s+2)/(s**2 + 2s + 5)

ilaplace(IL)