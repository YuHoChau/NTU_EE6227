%%%%% Genetic Algorithm with a New Multi-Parent Crossover (GA-MPC)%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Saber Mohamed Elsayed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% a PhD Student and a Research Associate %%%%%%%%%%%%%%%%%%%%%%%%
%%%University of New South Wales at Australian Defence Force Academy%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Matlab 7.8.0(R2009a)%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Last Updated: July 2011%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

% open the file with write permission
performance = fopen('performance.txt', 'wt'); %%%% this file will contain the best fitness function in each generation
periodic = fopen('periodic.txt', 'wt');       %%%% this file will contain the periodic fitness function ( 50,000, 100,000 and 150,000 FEs) for each run
finalobj = fopen('finalob.txt', 'wt'); %%%% this file will contain the decision vector of the best solution at each run


xmax=[];        %%%% Upper boundaries
xmin=[];        %%%% Lower boundaries
fitx=[]; %%% fitness values array

PopSize = 90; %%% Population Size
max_eval = 149940;%%% Less than 150000; %%%% maximum fitness function evaluations

n=0;            %%%% Number of the decision variables
for I_fno = 21 : 22
    %% Record the best results
  outcome = []; 
  
   fprintf('\n-------------------------------------------------------\n')
  fprintf('Function = %d, \n', I_fno) 
  
for times=1:25 %%%% Number of runs
    
   
    current_eval=0; %%% fitness function evaluations counter
    previous_eval=0;
    
    I_fno=21;         %%%  Determin the problem number
        
    iter=0;%%%% iteration or generation number
    
    %%%% Define a random seed based on time. NOTE THAT IF YOU ARE USING DIFFERENT SEEDS
    %%%% FROM OURS, YOU MAY GET DIFFERENT VALUES. Note also that the seeds
    %%%% will depend on the PC specifications (Here, the PC specifiactions are:
    %%%% a 3 GHz Core 2 Duo processor, 3.5G RAM, and windows XP).
    %%%  i.e. for problem 1, if you set
    %%%% the PC date and time to "15 January 2011, 9:00:00 AM", NOTE AM not PM,
    %%%% you will get the same results as those are reported in the published
    %%%% paper. Unfortunately, we did not store our old seeds.
    
     RandStream.setGlobalStream (RandStream('mt19937ar','seed',sum(100*clock)));
   
    % Start initialization
    [n xmax xmin] = define_boundaries (n, xmax, xmin, I_fno); %%%% Initialize the boundaries
    
    for i=1:PopSize
        for j=1:n
            x(i,j)=xmin (j) +rand*(xmax(j)-xmin(j));
        end
    end% End initialization
    
    
    for i=1:PopSize
        
        if I_fno<=8
            fitx(i)=bench_func(x(i,:),I_fno);
            
            %%%% For ONLY problems Tersoff Potential Si(b) and  Si(c), the fitness value
            %%%% may be equal to NAN, so it is converted to zero
            if isnan(fitx(i)) ==1
                fitx(i)=0;
            end
        end
        if I_fno==9
            [fitx(i) penalty(i) rate_d(i)]= cost_fn(x(i,:));
        end
        if I_fno==10
            null = [50, 120];
            phi_desired= 180 ;
            distance= 0.5;
            [y sllreturn bwfn]= antennafunccircular(x(i,:), null, phi_desired, distance);
            fitx(i)=y;
        end
        
        if I_fno==11
            [fitx(i) Count]= MY_FUNCTION_10_1(x(i,:));
        end
        if  I_fno==12
            [fitx(i) Count]= MY_FUNCTION_10_2(x(i,:));
        end
        if  I_fno==13
            [fitx(i) Count ]= MY_FUNCTION_11_1(x(i,:));
        end
        if  I_fno==14
            [fitx(i) Count]= MY_FUNCTION_11_2(x(i,:));
        end
        if  I_fno==15
            [fitx(i) Count]= MY_FUNCTION_11_3(x(i,:));
        end
        if  I_fno==16
            [fitx(i) Count]= MY_FUNCTION_11_4(x(i,:));
        end
        if  I_fno==17
            [fitx(i) Count ]= MY_FUNCTION_11_5(x(i,:));
        end
        if  I_fno==18
            [fitx(i) Count ]= MY_FUNCTION_12_1(x(i,:));
        end
        if  I_fno==19
            [fitx(i) Count ]= MY_FUNCTION_12_2(x(i,:));
        end
        if  I_fno==20
            [fitx(i) Count ]= MY_FUNCTION_12_3(x(i,:));
        end
        if I_fno == 21
            a=load('messengerfull.mat');
            fitx(i) =messengerfull(x(i,:),a.MGADSMproblem);
        end
        if I_fno == 22
            a=load('cassini2.mat');
            fitx(i) =cassini2(x(i,:),a.MGADSMproblem);
        end
        
        
    end% end fitx calculation
    
    %%%% Sort the population based on fitx
    
    [ fitx, indecies ] = sort( fitx );
    x = x( indecies, : );
    
    %%%%%%%%%%%%%% Main Loop
       
    while (current_eval<max_eval)
        
        %%% Increase the number of fitness Evaluations by PopSize, in which at 
        %%% each generation we generate PopSize new individuals (PopSize), so set the
        %%% current_eval = current_eval + PopSize
        
        previous_eval=current_eval;
        current_eval = current_eval+ PopSize;
        iter=iter+1;
        
        %%%%% Create an archive pool = 0.5 * PopSize
        for i=1:PopSize/2
            archive (i,:) = x(i,:);
        end
        
        %%% Selection Pool Popsize * 3
        for i=1:PopSize*3
            
            TcSize =randi([2,3]); %% select the TC size 2 or 3, randomly.
            for  tc=1: TcSize %%% select the individual that follow the tournament
                randnum(tc) = randi(PopSize);
            end
            best(i) = min(randnum); %%% as we sorted the array before, the better is the one with minimum randnum
        end
        
        best_size= size(best);
        %%%% Crossover Operator
        for i=1:3:PopSize
            if I_fno > 16 && I_fno <= 20
                beta = normrnd(0.5,0.3);  %%% generate beta = Gaussian number, with mean=0.5 and standard deviation=0.3.%%%%
            else
                beta = normrnd(0.7,0.1);  %%% generate beta = Gaussian number, with mean=0.7 and standard deviation=0.1.%%%%
            end
            
            
            consecutive(1) = best(i);
            consecutive(2) = best(i+1);
            consecutive(3) = best(i+2);
            
            %%%% sort the selected three parents
            consecutive= sort(consecutive);
            
            %%% Check the similarity between all selected individuals
            if (consecutive(1)== consecutive(2))
                
                while (consecutive(2)== consecutive(1)) ||(consecutive(2)== consecutive(3))
                    consecutive(2)=randi(PopSize);
                end
                %%%% sort the selected three parents
                consecutive= sort(consecutive);
            end
            
            if (consecutive(1)== consecutive(3))
                
                while (consecutive(3)== consecutive(1)) ||(consecutive(3)== consecutive(2))
                    consecutive(3)= randi(PopSize);%
                end
                %%%% sort the selected three parents
                consecutive= sort(consecutive);
            end
            
            if (consecutive(2)== consecutive(3))
                
                while (consecutive(3)== consecutive(1)) ||(consecutive(3)== consecutive(2))
                    consecutive(3)= randi(PopSize);
                end
                %%%% sort the selected three parents
                consecutive= sort(consecutive);
            end
            
            
            if (rand<1)
                for j=1: n
                    offspring_individuals(i,j) = x(consecutive(1), j) + beta * (x(consecutive(2), j) - x(consecutive(3), j));
                    offspring_individuals(i+1,j) = x(consecutive(2), j) + beta * (x(consecutive(3), j) - x(consecutive(1), j));
                    offspring_individuals(i+2,j) = x(consecutive(3), j) + beta * (x(consecutive(1), j) - x(consecutive(2), j));
                end
            end
            
        end
        
        
        for i=1:PopSize
            [offspring_individuals n xmax xmin] = han_boun (offspring_individuals, n, xmax, xmin, I_fno,i);
        end
        
        
        %%%%%%%%%%%%% Randomized Operator
        arch_size = size(archive);
        for i=1:PopSize
            for j=1: n
                p=0.1;%%% the used randomized operator probablity
                
                %%%%%%%%%%%% In a latter study: to get better results for  SEPERABLE
                %%%%%%%%%%%% FUNCTIONS IT IS RECOMMENDED TO USE THE FOLLOWING VALUES
                %%%%%%%%%%%% 
                %% if mod(i,3)==1
                %%  p=0.01;
                %% else
                %%   p=0.1;
                %%end
                
                
                if (rand<p)
                    pos= randi(arch_size(1));%%%% select an individual from the archive pool
                    offspring_individuals(i,j)=  archive(pos,j); %%% exchange variables
                end
            end
        end
        %%%%%%%%%%%%% End ... the Randomized Operator
        
        %%%%%%%%% Group both elite and x 
        
        for i=1:arch_size(1)+PopSize
            if i<=arch_size(1)
                all_individuals (i,:) = archive(i,:);
            else
                current = i-arch_size(1);
                all_individuals (i,:)= offspring_individuals(current,:);
            end
        end
        
       
        %%%%% Calculated the fitness values for the neww offspring
        for i=1:arch_size(1)+PopSize
            if i <= arch_size(1)
                fitx_all(i)= fitx(i);
            else
                
                if I_fno <9
                    fitx_all(i)=bench_func(all_individuals(i,:),I_fno);
                end
                if I_fno == 9
                    [fitx_all(i) penalty(i) rate_d(i)]= cost_fn(all_individuals(i,:));
                end
                if I_fno == 10
                    [y sllreturn bwfn]= antennafunccircular(all_individuals(i,:), null, phi_desired, distance);
                    fitx_all(i)=y;
                end
                if I_fno==11
                    [fitx_all(i) Count]= MY_FUNCTION_10_1(all_individuals(i,:));
                end
                if I_fno==12
                    [fitx_all(i) Count]= MY_FUNCTION_10_2(all_individuals(i,:));
                end
                if I_fno==13
                    [fitx_all(i) Count ]= MY_FUNCTION_11_1(all_individuals(i,:));
                end
                if I_fno==14
                    [fitx_all(i) Count]= MY_FUNCTION_11_2(all_individuals(i,:));
                end
                if I_fno==15
                    [fitx_all(i) Count]= MY_FUNCTION_11_3(all_individuals(i,:));
                end
                if I_fno==16
                    [fitx_all(i) Count]= MY_FUNCTION_11_4(all_individuals(i,:));
                end
                if I_fno==17
                    [fitx_all(i) Count ]= MY_FUNCTION_11_5(all_individuals(i,:));
                end
                if I_fno==18
                    [fitx_all(i) Count]= MY_FUNCTION_12_1(all_individuals(i,:));
                end
                if I_fno==19
                    [fitx_all(i) Count]= MY_FUNCTION_12_2(all_individuals(i,:));
                end
                if I_fno==20
                    [fitx_all(i) Count ]= MY_FUNCTION_12_3(all_individuals(i,:));
                end
                if I_fno == 21
                    fitx_all(i) =messengerfull(all_individuals(i,:),a.MGADSMproblem);
                end
                if I_fno == 22
                    fitx_all(i) =cassini2(all_individuals(i,:),a.MGADSMproblem);
                end
            end
            
            %%%% ONLY For problems Tersoff Potential Si(b) and  Si(c), the fitness value
            %%%% may be equal to NAN, so it is converted to zero
            if isnan(fitx_all(i)) ==1
                fitx_all(i)=0;
            end
        end
        
        
        
        %%%%  From both the archive individuals and the new offspring,
        %%%%  select the best PopSize individuals for the next geneartion
        
        %%%%%%%% 1-  Sort All polulation according to objective value
        [ fitx_all, index ] = sort( fitx_all );
        all_individuals = all_individuals( index, : );
        
        %%% 2- copy the best PopSize individuals into x to start the new
        %%% generation
        for i=1:PopSize
            x(i,:) = all_individuals (i,:);
            fitx(i) = fitx_all(i);
        end
        
        
        %%%% print the number of fitness evaluations and the best values
        fprintf(performance, '%6.2i\t %12.12E\n', current_eval,fitx(1));
        
        
        %%%% Check Replicants
        for i=2:PopSize
            similar=0;
            for j=1: n
                if(x (i,j)==x (i-1,j))
                    similar = similar+1;
                end
            end
            if(similar==n)
                for j=1: n
                    g=  0.5*rand + 0.25*rand*randn;
                    x (i,j) = min(xmax(j),max(xmin(j),x (i,j)+ g));
                end
            end
        end
        %%% print the periodic fitness values
        if (current_eval>=50000) && (previous_eval <50000)
            fprintf(periodic, '%12.12E\t 0\t', fitx(1));
        else if (current_eval>=100000) && (previous_eval <100000)
                fprintf(periodic, '%12.12E\t 0\t', fitx(1));
            else if (current_eval>=max_eval) && (previous_eval <=max_eval)
                    fprintf(periodic, '%12.12E\t 0\t', fitx(1));
                end
            end
        end
        
        
    end
    fprintf(periodic, '\n');
    
    for j=1:n
        fprintf(finalobj, '%12.12f\t ', x(1,j));
    end
    fprintf(finalobj, '\n');
    
    bsf_fit_var = fitx(1);
    fprintf('%d th run, best-so-far function value = %1.8e\n', run_id , bsf_fit_var)
    outcome = [outcome bsf_fit_var]; 
end
end
fclose(performance);
fclose(periodic);
fclose(finalobj);

