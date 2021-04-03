clc;clear;close all;


[X,Y] = meshgrid(linspace(-1,1,200));


Z=0;
for k=0:20
    Z=Z+0.5^k*cos(2*pi*3^k*(X+0.5))+0.5^k*cos(2*pi*3^k*(Y+0.5));
end
temp=0;
for k=0:20
    temp=temp+0.5^k*cos(2*pi*3^k*0.5);
end
Z=Z-2*temp;

axis([-10,10,-10,10]);
mesh(X,Y,Z);%线框图
figure();
surf(X,Y,Z);%表面图
