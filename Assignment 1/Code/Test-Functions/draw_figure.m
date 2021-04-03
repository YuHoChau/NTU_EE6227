% global M;
% creatematrix(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­ackleyÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ackley  x from[-5 5]
x=-5:0.01:5;
[x,y]=meshgrid(x);
temp1=x.^2+y.^2;
temp2=cos(2*pi*x)+cos(2*pi*y);
z=20+exp(1)-20*exp(-0.2*sqrt(temp1/2))-exp(temp2/2);
axis([-5,5,-5,5]);
meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄackleyÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated ackley  x from[-5 5]
% x=-5:0.01:5;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%    for j=1:size(y,1)
%        p=[x(i,j),y(i,j)]';
%        x(i,j)=M(1,:)*p;
%        y(i,j)=M(2,:)*p;
%    end
% end
% temp1=x.^2+y.^2;
% temp2=cos(2*pi*x)+cos(2*pi*y);
% z=20+exp(1)-20*exp(-0.2*sqrt(temp1/2))-exp(temp2/2);
% axis([-5,5,-5,5]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­cigarÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cigar
%x=-5:0.01:5;
%[x,y]=meshgrid(x);
%z=x.^2+(10^4)*y.^2;
%axis([-5,5,-5,5]);
%meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄcigarÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rotated cigar x from [-5 5]   
% x=-7:0.01:7;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%     for j=1:size(y,1)
%         p=[x(i,j),y(i,j)]';
%         x(i,j)=M(1,:)*p;
%         y(i,j)=M(2,:)*p;
%     end
% end
% z=x.^2+(10^4)*y.^2;
% axis([-7,7,-7,7]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­ellipseÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ellipse  x from [-5 -5] 
% x=-5:0.01:5;
% [x,y]=meshgrid(x);
% z=x.^2+10.^4*(y.^2);
% axis([-5,5,-5,5]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­griewangkÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%griewangk 
% x=-600:1:600;
% [x,y]=meshgrid(x);
% temp1=(x.^2+y.^2)/4000;
% temp2=cos(x)*cos(y/sqrt(2));
% z=temp1-temp2+1;
% axis([-600,600,-600,600]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄgriewangkÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated griewangk
% x=-600:1:600;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%     for j=1:size(y,1)
%         p=[x(i,j),y(i,j)]';
%         x(i,j)=M(1,:)*p;
%         y(i,j)=M(2,:)*p;
%     end
% end
% temp1=(x.^2+y.^2)/4000;
% temp2=cos(x)*cos(y/sqrt(2));
% z=temp1-temp2+1;
% axis([-600,600,-600,600]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­nocon_rastriginÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%nocon_rastrigin
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% temp1=0;
% temp2=0;
% z=0;
% if abs(x)<1/2
%     temp1=x;
% else
%     temp1=round(2.*x)/2;
% end
% if abs(y)<1/2
%     temp2=y;
% else
%     temp2=round(2.*y)/2;
% end
% z=z+temp1.^2-10*cos(2*pi.*temp1)+temp2.^2-10*cos(2*pi.*temp2)+20;
% axis([-10,10,-10,10]);
% meshc(x,y,z);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄnocon_rastriginÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated nocon_rastrigin
% x=-15:0.05:15;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%    for j=1:size(y,1)
%        p=[x(i,j),y(i,j)]';
%        x(i,j)=M(1,:)*p;
%        y(i,j)=M(2,:)*p;
%    end
% end
% temp1=0;
% temp2=0;
% z=0;
% if abs(x)<1/2
%     temp1=x;
% else
%     temp1=round(2.*x)/2;
% end
% if abs(y)<1/2
%     temp2=y;
% else
%     temp2=round(2.*y)/2;
% end
% z=z+temp1.^2-10*cos(2*pi.*temp1)+temp2.^2-10*cos(2*pi.*temp2)+20;
% axis([-15,15,-15,15]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­rastriginÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rastrigin
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% temp1=x.^2-10*cos(2*pi.*x);
% temp2=y.^2-10*cos(2*pi.*y);
% z=temp1+temp2+20;
% axis([-10,10,-10,10]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄrastriginÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated rastrigin
% x=-15:0.05:15;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%    for j=1:size(y,1)
%        p=[x(i,j),y(i,j)]';
%        x(i,j)=M(1,:)*p;
%        y(i,j)=M(2,:)*p;
%    end
% end
% temp1=x.^2-10*cos(2*pi.*x);
% temp2=y.^2-10*cos(2*pi.*y);
% z=temp1+temp2+20;
% axis([-15,15,-15,15]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­rosenbrockÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rosenbrock 
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% z=100*(y-x.^2).^2+(x-1).^2;
% axis([-10,10,-10,10]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­schwefelÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%schwefel
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% z=(x-x.^2).^2+(x-1).^2+(x-y.^2).^2+(y-1).^2;
% axis([-10,10,-10,10]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄschwefelÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated schwefel
% x=-15:0.05:15;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%    for j=1:size(y,1)
%        p=[x(i,j),y(i,j)]';
%        x(i,j)=M(1,:)*p;
%        y(i,j)=M(2,:)*p;
%    end
% end
% z=(x-x.^2).^2+(x-1).^2+(x-y.^2).^2+(y-1).^2;
% axis([-15,15,-15,15]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­sphereÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sphere 
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% z=x.^2+y.^2;
% axis([-10,10,-10,10]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­sumcanÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sumcan
% x=-0.16:0.0005:0.16;
% [x,y]=meshgrid(x);
% z=1./(10.^(-5)+abs(x)+abs(x+y));
% z=log10(z);
% axis([-0.16,0.16,-0.16,0.16]);
% mesh(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­tabletÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tablet 
% x=-10:0.05:10;
% [x,y]=meshgrid(x);
% z=10.^4*x.^2+y.^2;
% axis([-10,10,-10,10]);
% mesh(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­WeierstrassÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Weierstrass 
% x=-1:0.005:1;
% [x,y]=meshgrid(x);
% z=0;
% for k=0:20
%     z=z+0.5^k*cos(2*pi*3^k*(x+0.5))+0.5^k*cos(2*pi*3^k*(y+0.5));
% end
% temp=0;
% for k=0:20
%     temp=temp+0.5^k*cos(2*pi*3^k*0.5);
% end
% z=z-2*temp;
% axis([-1,1,-1,1]);
% meshc(x,y,z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%»­Ðý×ªµÄWeierstrassÍ¼¡£
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Rotated Weierstrass 
% x=-1.5:0.005:1.5;
% [x,y]=meshgrid(x);
% for i=1:size(x,1)
%    for j=1:size(y,1)
%        p=[x(i,j),y(i,j)]';
%        x(i,j)=M(1,:)*p;
%        y(i,j)=M(2,:)*p;
%    end
% end
% z=0;
% for k=0:20
%     z=z+0.5^k*cos(2*pi*3^k*(x+0.5))+0.5^k*cos(2*pi*3^k*(y+0.5));
% end
% temp=0;
% for k=0:20
%     temp=temp+0.5^k*cos(2*pi*3^k*0.5);
% end
% z=z-2*temp;
% axis([-1.5,1.5,-1.5,1.5]);
% meshc(x,y,z);