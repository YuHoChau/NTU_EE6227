function val=rot_nocon_rastrigin(x)
global M;
y=M*(x.');
y=y.';
val=nocon_rastrigin(y);