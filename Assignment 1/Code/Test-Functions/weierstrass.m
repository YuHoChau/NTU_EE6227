function val=weierstrass(x)
val=0;
n=size(x,2);
for i=1:n
    for k=0:20
        val=val+0.5^k*cos(2*pi*3^k*(x(i)+0.5));
    end
end
temp=0;
for k=0:20
    temp=temp+0.5^k*cos(2*pi*3^k*0.5);
end
val=val-n*temp;