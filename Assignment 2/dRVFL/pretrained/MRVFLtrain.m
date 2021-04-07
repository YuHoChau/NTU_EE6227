function [model,TrainingAccuracy,Training_time] = MRVFLtrain(trainX,trainY,option)

[Nsample,Nfea] = size(trainX);
N = option.N;
L = option.L;
C = option.C;
s = option.scale;  %scaling factor


A = cell(L,1); %for L hidden layers
beta = cell(L,1);
weights = cell(L,1);
biases = cell(L,1);

A_input = trainX;

tic
for i = 1:L
    
    [w,b] = AE_beta(A_input,option,i,Nfea);
    weights{i} = w;
    biases{i} = b;
    
    A1 = A_input * w;
    mu{i} = mean(A1,1);
    sigma{i} = std(A1);
    A1 = bsxfun(@rdivide,A1-repmat(mu{i},size(A1,1),1),sigma{i}); %;layer normalization
    A1 = A1+repmat(b,Nsample,1);
    A1 = relu(A1);
    A1_temp1 = [A_input,A1,ones(Nsample,1)];
    %A1_temp1 = [trainX,A1,ones(Nsample,1)];
    beta1  = l2_weights(A1_temp1,trainY,C,Nsample);
    
    A{i} =  A1_temp1;
    beta{i} = beta1;
    
    %clear A1 A1_temp1 A1_temp2 beta1
    A_input = [trainX A1];
end

Training_time = toc;

%% Calculate the training accuracy

ProbScores = cell(L,1); %depends on number of hidden layer
for i = 1:L
    A_temp = A{i};
    beta_temp = beta{i};
    trainY_temp = A_temp*beta_temp;
    [max_score,indx] = max(trainY_temp,[],2);
    pred_idx(:,i) = indx;
    %softmax to generate probabilites
    %     trainY_temp1 = bsxfun(@minus,trainY_temp,max(trainY_temp,[],2)); %for numerical stability
    %     num = exp(trainY_temp1);
    %     dem = sum(num,2);
    %     prob_scores = bsxfun(@rdivide,num,dem);
    %     ProbScores{i} = prob_scores;
    
    %     [max_prob,indx] = max(prob_scores,[],2);
    %     [~, ind_corrClass] = max(trainY,[],2);
    %     TrainAccuracy = mean(indx == ind_corrClass)
end

%TrainingAccuracy = ComputeAcc(trainY,ProbScores); %averaging prob.scores
TrainingAccuracy = majorityVoting(trainY,pred_idx); %majority voting

%%
model.L = L;
model.w = weights;
model.b = biases;
model.beta = beta;
model.mu = mu;
model.sigma = sigma;

end