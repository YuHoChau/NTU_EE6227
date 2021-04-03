cigar
x=-5:0.01:5;
[x,y]=meshgrid(x);
z=x.^2+(10^4)*y.^2;
axis([-5,5,-5,5]);
meshc(x,y,z);