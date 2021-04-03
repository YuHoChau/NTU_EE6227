%test_frame
clear all
% close all
global orthm best_f best_keep initial_flag
rand('state',sum(100*clock));
warning off
fhd=str2func('TEC_test_function');

me=5000;
ps=10;
Max_FES=ps*me;
D=10;
norm_flag=0;
shift_flag=0;


orthm=diag(ones(1,D));

VRmin=[-100,-100,-100,-100,-1000,-100,-100,-100,-100,-100];
VRmax=-VRmin;

VRminn=VRmin;VRmaxn=VRmax;
% funchoose=[1,2,3,4,5,6,7,8,9,10];
funchoose=[1,2,3,4,5,6,7,8,9,10];
for funnum=1
   
fun=funchoose(funnum);
initial_flag=0;
for jjj=1:30
gbias=zeros(1,D);

fun,jjj
% best_keep=[];best_f=1e+30;
[CLPSO_new_gbest,CLPSO_new_gbestval,CLPSO_new_fitcount]= CLPSO_new_func(fhd,me,Max_FES,ps,D,VRminn(fun),VRmaxn(fun),fun,VRmin(fun),VRmax(fun),gbias,norm_flag,shift_flag); 
CLPSO_new_gbestval
CLPSO_new_fitcount_res(fun,jjj)=CLPSO_new_fitcount;CLPSO_new_gbestval_res(fun,jjj)=CLPSO_new_gbestval;CLPSO_new_gbest_res(fun,jjj,:)=CLPSO_new_gbest;

end

end

median(CLPSO_new_gbestval_res')


