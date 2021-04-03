function val=schwefel(x)
val=0;
n=size(x,2);
for i=1:n
    val=val+(x(1)-x(i)^2)^2+(x(i)-1)^2;
end
%x from [-10 10]