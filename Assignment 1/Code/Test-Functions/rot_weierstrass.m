function val=rot_weierstrass(x)
global M;
y=M*(x.');
y=y.';
val=weierstrass(y);