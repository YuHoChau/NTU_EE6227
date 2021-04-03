alpha = 1 / 8;
[X1, X2] = meshgrid(-2:0.005:2);

N = 2;
Y1 = ((sqrt(X1.^2 + X2.^2).^2 - N).^2).^alpha + 0.5;
Y2 = (1 / N) * (sqrt(X1.^2 + X2.^2).^2 + (X1 + X2));
Y = Y1 + Y2;
mesh(X1, X2, Y)