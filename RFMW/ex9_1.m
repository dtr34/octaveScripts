%twoComponentLMatch example 9.1
clear all; 
clc;

Za = 1.2-j*450.3
RL = 50
freq = 30E6

twoComponentLMatch(Za,RL,freq);