clc;clear;close all;

[X,Y] = meshgrid(linspace(-100,100,81));


Z=(X-X.^2).^2+(X-1).^2+(X-Y.^2).^2+(Y-1).^2;

axis([-10,10,-10,10]);

mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
