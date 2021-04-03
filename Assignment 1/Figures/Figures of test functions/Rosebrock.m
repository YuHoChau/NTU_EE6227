clc;clear;close all;

[X,Y] = meshgrid(linspace(-100,100,81));


Z=100*(Y-X.^2).^2+(X-1).^2;

axis([-5,5,-5,5]);


axis([-10,10,-10,10]);

mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
