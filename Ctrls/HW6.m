%RouthHurwitz
clear;close all; clc;

%{
%Question 1
coefficientVec = [1,0,6,5,8,20]

RouthHurwitz(coefficientVec)

coefficientVecRev = [20, 8, 5, 6, 0, 1]
RouthHurwitz(coefficientVecRev)

RouthHurwitz([4,8,1,0])

roots(coefficientVec) 
%}
%Question 2
coefficientVec = [1, -2, 4, -3, 2, -3]
RouthHurwitz(coefficientVec)

roots(coefficientVec)

