function result = selu(x)
%implement selu function

alpha = 1.6732632423543772848170429916717;
scale = 1.0507009873554804934193349852946;

y = @(x) (scale*x) .* (x>0) + (scale*alpha*(exp(x)-1)) .* (x<=0);

result = y(x);

end

