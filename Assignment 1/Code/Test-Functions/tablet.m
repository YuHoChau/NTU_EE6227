function val=tablet(x)
val=10^4*x(1)^2;
n=size(x,2);
for i=2:n
    val=val+x(i)^2;
end
%x from [-5 5]