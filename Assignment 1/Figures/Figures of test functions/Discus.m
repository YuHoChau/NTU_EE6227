clc;clear;close all;


[X,Y] = meshgrid(linspace(-100,100,81));

Z=(10^4)*X.^2+Y.^2;

axis([-10,10,-10,10]);
mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图

