clc;clear;close all;

[X1,X2] = meshgrid(linspace(-100,100,81));
T = .5*1*X1+.5*2*X2;
Z = X1.^2+X2.^2+T.^2+T.^4;

mesh(X1,X2,Z);%线框图
figure();
surf(X1,X2,Z);%表面图
