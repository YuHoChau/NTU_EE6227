function val=rot_griewangk(x)
global M;
y=M*(x.'); 
y=y.';
val=griewangk(y);