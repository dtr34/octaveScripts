clear all;
clc;
options.filterType = "ButterWorthLP";
freqC = 250E6;
Zin = 50;
lintpg = 10^(-15/10);
options.HPorLPStopBandFrequency = 300e6;
K = getKfromGT(freqC, lintpg, options)

getFilterComponents(freqC,K,Zin,options);