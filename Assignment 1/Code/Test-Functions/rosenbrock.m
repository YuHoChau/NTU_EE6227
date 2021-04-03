function val = rosenbrock(x);
val=0;
for i=1:(size(x,2)-1)
    val=val+100*(x(i+1)-(x(i))^2)^2+(x(i)-1)^2;
end
%x from[-10 10]