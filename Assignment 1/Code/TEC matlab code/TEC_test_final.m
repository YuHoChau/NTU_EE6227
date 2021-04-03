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
result=[];
result_temp=[];
result_total = [];

            

orthm=diag(ones(1,D));

VRmin=[-100,-100,-100,-100,-100,-100,-100,-100,-100,-100];
VRmax=-VRmin;
if norm_flag==1
    VRminn=zeros(1,D);
    VRmaxn=ones(1,D);
else
    VRminn=VRmin;VRmaxn=VRmax;
end
% funchoose=[1,2,3,4,5,6,7,8,10];
funchoose=[1,2,3,4,5,6,7,8,9,10];
% 

for w0= 0.85:0.85
    for w1 = 0.4:0.4
        for q = 1.6:1.6
            for funnum=5:5
            fun=funchoose(funnum);
            initial_flag=0;

            
            
            for jjj=1:10
            if shift_flag==1
            	gbias=0.8.*(VRmin(fun)+(VRmax(fun)-VRmin(fun)).*rand(1,D));
%                 if fun==2
                if fun==11
                    gbias=-1+(1+1).*rand(1,D);
                end
                if fun==12
                    gbias=-500+(0+500).*rand(1,D);
                end
            else
            	gbias=zeros(1,D);
            end
            cc = [q q];
%             [gbest,gbestval,fitcount] = CLPSO_new_func(w0,w1,cc,fhd,me,Max_FES,ps,D,VRminn(fun),VRmaxn(fun),fun,VRmin(fun),VRmax(fun),gbias,norm_flag,shift_flag);
%             result_temp = gbestval;
%             result=[result;result_temp];
            
            fun,jjj,w0,w1,cc
            % best_keep=[];best_f=1e+30;
            [CLPSO_new_gbest,CLPSO_new_gbestval,CLPSO_new_fitcount]= CLPSO_new_func(w0,w1,cc,fhd,me,Max_FES,ps,D,VRminn(fun),VRmaxn(fun),fun,VRmin(fun),VRmax(fun),gbias,norm_flag,shift_flag);
            CLPSO_new_gbestval
            
            CLPSO_new_fitcount_res(fun,jjj)=CLPSO_new_fitcount;CLPSO_new_gbestval_res(fun,jjj)=CLPSO_new_gbestval;CLPSO_new_gbest_res(fun,jjj,:)=CLPSO_new_gbest;

            end
            end
            
            mean(CLPSO_new_gbestval_res')
            result_temp = [result_temp;w0]; 
            result_temp = [result_temp;w1]; 
            result_temp = [result_temp;q];
            result= [result;result_temp'];
            result_temp = [];
            result = [result,mean(CLPSO_new_gbestval_res')]
            result_total=[result_total;result];
            result = [];
            

        end
    end
end



