function val=griewangk(x)
temp1=0;
temp2=1;
for i=1:size(x,2)
    temp1=temp1+(x(i)^2)/4000;
    temp2=temp2*cos(x(i)/sqrt(i));
end
val=temp1-temp2+1;    %val=temp1+temp2+1;�����˴�����ǰ��griewangk�����Ϊ�����
%x from [-600 600]