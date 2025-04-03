%Filter Examples
clear all;
clc;
options.filterType = "ButterWorthLP";
freqC = 30E6;
Zin = 50;
lintpg = 10^(-40/10);
options.HPorLPStopBandFrequency = 80e6;
K = getKfromGT(freqC, lintpg, options);

getFilterComponents(freqC,K,Zin,options);

options.filterType = "ButterWorthHP";
freqC = 30E6;
K = 5;
Zin = 50;

getFilterComponents(freqC,K,Zin,options);


options.filterType = "ButterWorthBP";
options.HPorLPStopBandFrequency = 80e6;
options.HalfPowerBandwidth = 10e6;
options.BPorBSLowFrequency = 55e6;
options.BPorBSHighFrequency =85e6;

freqC = 70E6;
K = getKfromGT(freqC, lintpg, options)
Zin = 50;

getFilterComponents(freqC,K,Zin,options);