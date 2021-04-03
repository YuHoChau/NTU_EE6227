function val=sumcan(x)
val=0;
temp1=0;
n=size(x,2);
for i=1:n
    for j=1:i
        temp1=temp1+x(j);
    end
    val=val+abs(temp1);
    temp1=0;
end
val=1/(10^(-5)+val);
%x from [-0.16 0.16]