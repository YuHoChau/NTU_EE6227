function [TestingAccuracy,Testing_time] = MRVFLpredict(testX,testY,model)

tic;
[Nsample,Nfea] = size(testX);


L = model.L;
w = model.w;
b= model.b;
beta = model.beta;
mu = model.mu;
sigma = model.sigma;


A = cell(L,1); %for L hidden layers
A_input = testX;

tic
%% First Layer
for i = 1:L
    A1 = A_input * w{i};
    A1 = bsxfun(@rdivide,A1-repmat(mu{i},size(A1,1),1),sigma{i});
    A1 = A1+ repmat(b{i},Nsample,1);
    A1 = relu(A1);
    A1_temp1 = [A_input,A1,ones(Nsample,1)]; 
    %A1_temp1 = [testX,A1,ones(Nsample,1)]; 
    
    %A1_temp3 = A1; 
    A{i} = A1_temp1;
    %clear A1 A1_temp1 A1_temp2 w1 b1
    A_input = [testX A1];
end

%% Calculate the testing accuracy

ProbScores = cell(L,1); %depends on number of hidden layer
for i = 1:L
    A_temp = A{i};
    beta_temp = beta{i};
    testY_temp = A_temp*beta_temp;
   [max_score,indx] = max(testY_temp,[],2);
    pred_idx(:,i) = indx;
    
%     %softmax to generate probabilites
%     trainY_temp1 = bsxfun(@minus,testY_temp,max(testY_temp,[],2)); %for numerical stability
%     num = exp(trainY_temp1);
%     dem = sum(num,2);
%     prob_scores = bsxfun(@rdivide,num,dem);
%     ProbScores{i} = prob_scores;
% 
%     [max_prob,indx] = max(prob_scores,[],2);
%     [~, ind_corrClass] = max(testY,[],2);
%     TestAccuracy = mean(indx == ind_corrClass)
end

%TestingAccuracy = ComputeAcc(testY,ProbScores);
TestingAccuracy = majorityVoting(testY,pred_idx);
%% Calculate the testing accuracy
Testing_time = toc;



end