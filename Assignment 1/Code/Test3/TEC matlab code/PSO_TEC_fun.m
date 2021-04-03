%test_frame
clear all
% close all
global orthm best_f best_keep initial_flag
rand('state',sum(100*clock));
warning off
fhd=str2func('TEC_test_function');%fun,VRmin,VRmax,gbias,norm_flag,shift_flag

me=5000;
ps=10;
Max_FES=ps*me;
D=10;
norm_flag=0;
shift_flag=0;


orthm=diag(ones(1,D));

VRmin=[-100,-100,-100,-100,-1000,-100,-100,-100,-100,-100];
VRmax=-VRmin;
if norm_flag==1;
    VRminn=zeros(1,D);
    VRmaxn=ones(1,D)
else
    VRminn=VRmin;VRmaxn=VRmax;
end
% funchoose=[1,2,3,4,5,6,7,8,9,10];
funchoose=[1,2,3,4,5,6,7,8,9,10];
for funnum=1
    
fun=funchoose(funnum);
initial_flag=0;
for jjj=1:30

if shift_flag==1
    gbias=0.8.*(VRmin(fun)+(VRmax(fun)-VRmin(fun)).*rand(1,D));
    if fun==2
        gbias=-1+(1+1).*rand(1,D);
    end
    if fun==7
        gbias=-500+(0+500).*rand(1,D);
    end
else
    gbias=zeros(1,D);
end
fun,jjj
% best_keep=[];best_f=1e+30;
[PSO_gbest,PSO_gbestval,PSO_fitcount]= PSO_func(fhd,me,Max_FES,ps,D,VRminn(fun),VRmaxn(fun),fun,VRmin(fun),VRmax(fun),gbias,norm_flag,shift_flag); 
PSO_gbestval
PSO_fitcount_res(fun,jjj)=PSO_fitcount;PSO_gbestval_res(fun,jjj)=PSO_gbestval;PSO_gbest_res(fun,jjj,:)=PSO_gbest;

end

end

median(PSO_gbestval_res')


