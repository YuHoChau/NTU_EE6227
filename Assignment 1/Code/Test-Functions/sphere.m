function val = sphere(x)
n = size(x,2);
val = 0;
for i = 1:n
    val = val + x(i).^2;
end
% each xi is between [-5, 5], you can modify n