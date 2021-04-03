function val=rot_rastrigin(x)
global M;
y=M*(x.');
y=y.';
val=rastrigin(y);