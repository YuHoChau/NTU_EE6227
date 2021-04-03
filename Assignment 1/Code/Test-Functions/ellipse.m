function val=ellipse(x)
val=0;
n=size(x,2);
for i=1:n
    val=val+(10^(4*(i-1)/(n-1)))*x(i)^2;
end
%x from [-5 -5] 