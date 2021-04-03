%%%%%%%%%%%%%%%%%%%
%% This package is a MATLAB/Octave source code of L-SHADE which is an improved version of SHADE 1.1.
%% Note that this source code is transferred from the C++ source code version.
%% About L-SHADE, please see following papers:
%%
%% * Ryoji Tanabe and Alex Fukunaga: Improving the Search Performance of SHADE Using Linear Population Size Reduction,  Proc. IEEE Congress on Evolutionary Computation (CEC-2014), Beijing, July, 2014.
%%
%% For this package, we downloaded JADE's source code from Dr. Q. Zhang's website (http://dces.essex.ac.uk/staff/qzhang) and modified it.
%%
%% Update
%% 9/Oct/2014: incompatibilities-fix between Octave and Matlab and bug-fix of population size reduction procedure (thanks to Dr. Elsayed)
%%%%%%%%%%%%%%%%%%% 

clc;
clear all;

format long;
format compact;

n = 0;
max_nfes = 150000;

rand('seed', sum(100 * clock));

xmax = [];
xmin = [];
pb = 0.4;
ps = .5;

for func =  3: 10
  if func == 7 || func == 9  
      continue;
  end
     
  I_fno = func;
  %% Record the best results
  outcome = []; 

  xmax = [];
  xmin = [];
  n = 0;
  %% Define the bounds 
  [n xmax xmin] = define_boundaries (n, xmax, xmin, func); %%%% Initialize the boundaries
  lu = [xmin ; xmax];
  pop_size_gl = 18 * n;
  dim = n;
  
  fprintf('\n-------------------------------------------------------\n')
  fprintf('Running LSHADE (with cov crx and E-neighborhood)Function = %d, Dimension size = %d\n', func, n) 

  for run_id = 1 : 25
    
    %%  parameter settings for L-SHADE
    fitness = [];
    p_best_rate = 0.11;
    arc_rate = 1.4;
    memory_size = 5;
    pop_size = pop_size_gl;
    n = dim; 
    
    SEL = round(ps*pop_size);
    
    max_pop_size = pop_size;
    min_pop_size = 4.0;

    %% Initialize the main population
    popold = repmat(lu(1, :), pop_size, 1) + rand(pop_size, n) .* (repmat(lu(2, :) - lu(1, :), pop_size, 1));
    pop = popold; % the old population becomes the current population
    
    %% Call cec 2011
    for i=1:pop_size
%         x(i,:) = pop(i,:);
        if I_fno<=8
            fitness(i)=bench_func(pop(i,:),I_fno);

            %%%% For ONLY problems Tersoff Potential Si(b) and  Si(c), the fitness value
            %%%% may be equal to NAN, so it is converted to zero
            if isnan(fitness(i)) ==1
                fitness(i)=0;
            end
        end
        if I_fno==9
            [fitness(i) penalty(i) rate_d(i)]= cost_fn(pop(i,:));
        end
        if I_fno==10
            null = [50, 120];
            phi_desired= 180 ;
            distance= 0.5;
            [y sllreturn bwfn]= antennafunccircular(pop(i,:), null, phi_desired, distance);
            fitness(i)=y;
        end

        if I_fno==11
            [fitness(i) Count]= MY_FUNCTION_10_1(pop(i,:));
        end
        if  I_fno==12
            [fitness(i) Count]= MY_FUNCTION_10_2(pop(i,:));
        end
        if  I_fno==13
            [fitness(i) Count ]= MY_FUNCTION_11_1(pop(i,:));
        end
        if  I_fno==14
            [fitness(i) Count]= MY_FUNCTION_11_2(pop(i,:));
        end
        if  I_fno==15
            [fitness(i) Count]= MY_FUNCTION_11_3(pop(i,:));
        end
        if  I_fno==16
            [fitness(i) Count]= MY_FUNCTION_11_4(pop(i,:));
        end
        if  I_fno==17
            [fitness(i) Count ]= MY_FUNCTION_11_5(pop(i,:));
        end
        if  I_fno==18
            [fitness(i) Count ]= MY_FUNCTION_12_1(pop(i,:));
        end
        if  I_fno==19
            [fitness(i) Count ]= MY_FUNCTION_12_2(pop(i,:));
        end
        if  I_fno==20
            [fitness(i) Count ]= MY_FUNCTION_12_3(pop(i,:));
        end
        if I_fno == 21
            a=load('messengerfull.mat');
            fitness(i) =messengerfull(pop(i,:),a.MGADSMproblem);
        end
        if I_fno == 22
            a=load('cassini2.mat');
            fitness(i) =cassini2(pop(i,:),a.MGADSMproblem);
        end


    end% end fitx calculation
    
    fitness = fitness';

    nfes = 0;
    bsf_fit_var = 1e+30;
    bsf_solution = zeros(1, n);

    %%%%%%%%%%%%%%%%%%%%%%%% for out
    for i = 1 : pop_size
        nfes = nfes + 1;
        
        if fitness(i) < bsf_fit_var
            bsf_fit_var = fitness(i);
            bsf_solution = pop(i, :);
        end
        
        %% if mod(nfes, 1000) == 0
        %% bsf_error_var = bsf_fit_var  - optimum;
        %% if bsf_error_var < val_2_reach; bsf_error_var = 0; end;
        %%	fprintf(sprintf('%1.16e \n', bsf_error_var));
        %%    fprintf(sprintf('%d %1.16e \n', nfes, bsf_error_var));
        %% end
        
        %%      if nfes > max_nfes; exit(1); end
        if nfes > max_nfes; break; end
    end
    %%%%%%%%%%%%%%%%%%%%%%%% for out

    memory_sf = 0.5 .* ones(memory_size, 1);
    memory_cr = 0.5 .* ones(memory_size, 1);
    memory_pos = 1;

    archive.NP = floor(arc_rate * pop_size); % the maximum size of the archive
    archive.pop = zeros(0, n); % the solutions stored in te archive
    archive.funvalues = zeros(0, 1); % the function value of the archived solutions

    %% main loop
    while nfes < max_nfes
      children_fitness = [];
      pop = popold; % the old population becomes the current population
      [temp_fit, sorted_index] = sort(fitness, 'ascend');

      mem_rand_index = ceil(memory_size * rand(pop_size, 1));
      mu_sf = memory_sf(mem_rand_index);
      mu_cr = memory_cr(mem_rand_index);

      %% for generating crossover rate
      cr = normrnd(mu_cr, 0.1);
      term_pos = find(mu_cr == -1);
      cr(term_pos) = 0;
      cr = min(cr, 1);
      cr = max(cr, 0);

      %% for generating scaling factor
      sf = mu_sf + 0.1 * tan(pi * (rand(pop_size, 1) - 0.5));
      pos = find(sf <= 0);

      while ~ isempty(pos)
          sf(pos) = mu_sf(pos) + 0.1 * tan(pi * (rand(length(pos), 1) - 0.5));
          pos = find(sf <= 0);
      end

      sf = min(sf, 1); 
      
      r0 = [1 : pop_size];
      popAll = [pop; archive.pop];
      [r1, r2] = gnR1R2(pop_size, size(popAll, 1), r0);
      
      pNP = max(round(p_best_rate * pop_size), 2); %% choose at least two best solutions
      randindex = ceil(rand(1, pop_size) .* pNP); %% select from [1, 2, 3, ..., pNP]
      randindex = max(1, randindex); %% to avoid the problem that rand = 0 and thus ceil(rand) = 0
      pbest = pop(sorted_index(randindex), :); %% randomly choose one of the top 100p% solutions

      vi = pop + sf(:, ones(1, n)) .* (pbest - pop + pop(r1, :) - popAll(r2, :));
      
      %% Check bounds
      for i=1:pop_size
          [vi n xmax xmin] = han_boun (vi, n, xmax, xmin, I_fno,i);
      end

%       mask = rand(pop_size, n) > cr(:, ones(1, n)); % mask is used to indicate which elements of ui comes from the parent
%       rows = (1 : pop_size)'; cols = floor(rand(pop_size, 1) * n)+1; % choose one position where the element of ui doesn't come from the parent
%       jrand = sub2ind([pop_size n], rows, cols); mask(jrand) = false;
%       ui = vi; ui(mask) = pop(mask);

     %% crossover according to the Eigen coordinate system
      J_= mod(floor(rand(pop_size, 1)*n), n) + 1;
      J = (J_-1)*pop_size + (1:pop_size)';
      crs = rand(pop_size, n) < cr(:, ones(1, n));
      if rand<pb
          %% coordinate ratation

          %%%%% Choose neighbourhood region to the best individual 
          best = pop(sorted_index(1), :);
          Dis = pdist2(pop,best,'euclidean'); % euclidean distance
          %D2 = sqrt(sum((pop(1,:) - best).^2, 2));
          
          %%%% Sort
           [Dis_ordered idx_ordered] = sort(Dis, 'ascend');
           Neighbour_best_pool = pop(idx_ordered(1:SEL), :); %%% including best also so start from 1 
           Xsel = Neighbour_best_pool;  
%            sizz = size(Xsel)
          %%%%%%%%%%%%%%%%%%%%%%%%%%% 
          
          
          %Xsel = pop(sorted_index(1:SEL), :);
          xmean = mean(Xsel);
          % covariance matrix calculation
          C =  1/(SEL-1)*(Xsel - xmean(ones(SEL,1), :))'*(Xsel - xmean(ones(SEL,1), :));
          C = triu(C) + transpose(triu(C,1)); % enforce symmetry
          [R,D] = eig(C);
          % limit condition of C to 1e20 + 1
          if max(diag(D)) > 1e20*min(diag(D))
              tmp = max(diag(D))/1e20 - min(diag(D));
              C = C + tmp*eye(n);
              [R, D] = eig(C);
          end
          TM = R;
          TM_=R';
          Xr = pop*TM;
          vi = vi*TM;
          %% crossover according to the Eigen coordinate system
          Ur = Xr;
          Ur(J) = vi(J);
          Ur(crs) = vi(crs);
          %%
          ui = Ur*TM_;
          
      else
          
          ui = pop;
          ui(J) = vi(J);
          ui(crs) = vi(crs);
          
      end
      
%       ui
%       xmax
%       xmin
%       return;
      %% Check bounds
      for i=1:pop_size
          [ui n xmax xmin] = han_boun (ui, n, xmax, xmin, I_fno,i);
      end
      
      
      %%%%%%%%
      
      

      %% Call cec 2011
      for i=1:pop_size
%           x(i,:) = ui(i,:);
          if I_fno<=8
              children_fitness(i)=bench_func(ui(i,:),I_fno);
              
              %%%% For ONLY problems Tersoff Potential Si(b) and  Si(c), the fitness value
              %%%% may be equal to NAN, so it is converted to zero
              if isnan(children_fitness(i)) ==1
                  children_fitness(i)=0;
              end
          end
          if I_fno==9
              [children_fitness(i) penalty(i) rate_d(i)]= cost_fn(ui(i,:));
          end
          if I_fno==10
              null = [50, 120];
              phi_desired= 180 ;
              distance= 0.5;
              [y sllreturn bwfn]= antennafunccircular(ui(i,:), null, phi_desired, distance);
              children_fitness(i)=y;
          end
          
          if I_fno==11
              [children_fitness(i) Count]= MY_FUNCTION_10_1(ui(i,:));
          end
          if  I_fno==12
              [children_fitness(i) Count]= MY_FUNCTION_10_2(ui(i,:));
          end
          if  I_fno==13
              [children_fitness(i) Count ]= MY_FUNCTION_11_1(ui(i,:));
          end
          if  I_fno==14
              [children_fitness(i) Count]= MY_FUNCTION_11_2(ui(i,:));
          end
          if  I_fno==15
              [children_fitness(i) Count]= MY_FUNCTION_11_3(ui(i,:));
          end
          if  I_fno==16
              [children_fitness(i) Count]= MY_FUNCTION_11_4(ui(i,:));
          end
          if  I_fno==17
              [children_fitness(i) Count ]= MY_FUNCTION_11_5(ui(i,:));
          end
          if  I_fno==18
              [children_fitness(i) Count ]= MY_FUNCTION_12_1(ui(i,:));
          end
          if  I_fno==19
              [children_fitness(i) Count ]= MY_FUNCTION_12_2(ui(i,:));
          end
          if  I_fno==20
              [children_fitness(i) Count ]= MY_FUNCTION_12_3(ui(i,:));
          end
          if I_fno == 21
              a=load('messengerfull.mat');
              children_fitness(i) =messengerfull(ui(i,:),a.MGADSMproblem);
          end
          if I_fno == 22
              a=load('cassini2.mat');
              children_fitness(i) =cassini2(ui(i,:),a.MGADSMproblem);
          end
          
          
      end% end fitx calculation

      children_fitness = children_fitness';

      %%%%%%%%%%%%%%%%%%%%%%%% for out
      for i = 1 : pop_size
          nfes = nfes + 1;
          
          if children_fitness(i) < bsf_fit_var
              bsf_fit_var = children_fitness(i);
              bsf_solution = ui(i, :);
          end
          
          %% if mod(nfes, 1000) == 0
          %% bsf_error_var = bsf_fit_var  - optimum;
          %% if bsf_error_var < val_2_reach; bsf_error_var = 0; end;
          %%       fprintf(sprintf('%1.16e \n', bsf_error_var));
          %%       fprintf(sprintf('%d %1.16e \n', nfes, bsf_error_var));
          %%end
          
          %%	if nfes > max_nfes; exit(1); end
          if nfes > max_nfes; break; end
      end
      %%%%%%%%%%%%%%%%%%%%%%%% for out

      dif = abs(fitness - children_fitness);


      %% I == 1: the parent is better; I == 2: the offspring is better
      I = (fitness > children_fitness);
      goodCR = cr(I == 1);  
      goodF = sf(I == 1);
      dif_val = dif(I == 1);

%      isempty(popold(I == 1, :))   
      archive = updateArchive(archive, popold(I == 1, :), fitness(I == 1));

      [fitness, I] = min([fitness, children_fitness], [], 2);
      
      popold = pop;
      popold(I == 2, :) = ui(I == 2, :);

      num_success_params = numel(goodCR);

      if num_success_params > 0
          sum_dif = sum(dif_val);
          dif_val = dif_val / sum_dif;

          %% for updating the memory of scaling factor
          memory_sf(memory_pos) = (dif_val' * (goodF .^ 2)) / (dif_val' * goodF);

          %% for updating the memory of crossover rate
          if max(goodCR) == 0 || memory_cr(memory_pos)  == -1
              memory_cr(memory_pos)  = -1;
          else
              memory_cr(memory_pos) = (dif_val' * (goodCR .^ 2)) / (dif_val' * goodCR);
          end

          memory_pos = memory_pos + 1;
          if memory_pos > memory_size;  memory_pos = 1; end
      end

      %% for resizing the population size
      plan_pop_size = round((((min_pop_size - max_pop_size) / max_nfes) * nfes) + max_pop_size);

      if pop_size > plan_pop_size
          reduction_ind_num = pop_size - plan_pop_size;
          if pop_size - reduction_ind_num <  min_pop_size; reduction_ind_num = pop_size - min_pop_size;end
          
          pop_size = pop_size - reduction_ind_num;
          SEL = round(ps*pop_size);
          
          for r = 1 : reduction_ind_num
              [valBest indBest] = sort(fitness, 'ascend');
              worst_ind = indBest(end);
              popold(worst_ind,:) = [];
              pop(worst_ind,:) = [];
              fitness(worst_ind,:) = [];
          end
          
          archive.NP = round(arc_rate * pop_size);
          
          if size(archive.pop, 1) > archive.NP
              rndpos = randperm(size(archive.pop, 1));
              rndpos = rndpos(1 : archive.NP);
              archive.pop = archive.pop(rndpos, :);
          end
      end
      
      
    end

%     bsf_error_val = bsf_fit_var - optimum;
%     if bsf_error_val < val_2_reach
%         bsf_error_val = 0;
%      end

    fprintf('%d th run, best-so-far func value = %1.8e\n', run_id , bsf_fit_var)
    outcome = [outcome bsf_fit_var];    
  end %% end 1 run
  
  fprintf('\n')
  fprintf('mean error value = %1.8e, std = %1.8e\n', mean(outcome), std(outcome))
end %% end 1 function run
