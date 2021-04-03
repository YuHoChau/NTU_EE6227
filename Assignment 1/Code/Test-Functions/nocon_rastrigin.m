function val=nocon_rastrigin(x)
y=0;
n=size(x,2);
val=0;
for i=1:n
    if abs(x(i))<1/2
        y=x(i);
    else
        y=round(2*x(i))/2;
    end
    val=val+y^2-10*cos(2*pi*y)+10;
end
    