clc;clear;close all;


[X,Y] = meshgrid(linspace(-10,10,100));


temp1=X.^2+Y.^2;
temp2=cos(2*pi*X)+cos(2*pi*Y);
Z=20+exp(1)-20*exp(-0.2*sqrt(temp1/2))-exp(temp2/2);

axis([-10,10,-10,10]);
mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
