clc;clear;close all;

[X,Y] = meshgrid(linspace(-100,100,81));


temp1=X.^2-10*cos(2*pi.*X);
temp2=Y.^2-10*cos(2*pi.*Y);
Z=temp1+temp2+20;
axis([-10,10,-10,10]);

mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
