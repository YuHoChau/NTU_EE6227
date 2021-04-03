function val = rastrigin(x);
% function for test fw
val=0;
for i=1:size(x,2)
    val=val+x(i)^2-10*cos(2*pi*x(i))+10;
end