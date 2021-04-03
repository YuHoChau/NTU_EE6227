clc;clear;close all;


[X,Y] = meshgrid(-6:0.01:6);


temp1=(X.^2+Y.^2)/4000;
temp2=cos(X).*cos(Y/sqrt(2));
Z=temp1-temp2+1;

% axis([-600,600,-600,600]);

mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
