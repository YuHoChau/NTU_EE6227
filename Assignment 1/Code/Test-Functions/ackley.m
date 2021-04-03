function val=ackley(x)
temp1=0;
temp2=0;
n=size(x,2);
for i=1:n
    temp1=temp1+x(i)^2;
    temp2=temp2+cos(2*pi*x(i));
end
val=20+exp(1)-20*exp(-0.2*sqrt(temp1/n))-exp(temp2/n);
%x from[-32 32]