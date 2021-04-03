function val=rot_schwefel(x)
global M;
y=M*(x.'); 
y=y.';
val=schwefel(y);