function [TestingAccuracy,Testing_time] = dRVFLpredict(testX,testY,model)

tic;
[Nsample,~] = size(testX);

L = model.L;
w = model.w;
b= model.b;
beta = model.beta;
mu = model.mu;
sigma = model.sigma;
act_fun = model.Activation;

A = cell(1,1);
A_input = testX;

tic
%% First Layer
for i = 1:L
    
    % Hidden Layer
    if i==1
        A1 = A_input * w{i};
    else
        A1 = A1 * w{i};
    end
    
    A1 = bsxfun(@rdivide,A1-repmat(mu{i},size(A1,1),1),sigma{i});
    A1 = A1+ repmat(b{i},Nsample,1);
    
    % Activation function
    switch lower(act_fun)
        case "relu"
            A1 = relu(A1);
        case "sigmoid"
            A1 = sigmoid(A1);
        otherwise
            error("Not Implemented");
    end
    
    % Outputs
    
    if i==1
        A1_temp1 = [A_input,A1];
        A{1}=A1_temp1;
    else
        A1_temp1=A{1};
        A{1}=[A1_temp1,A1];
    end
    
    if i==L
        A1_temp1=A{1};
        A{1}=[A1_temp1,ones(Nsample,1)];
    end
end

%% Calculate the testing accuracy

ProbScores = cell(1,1); %depends on number of hidden layer
for i = 1:1
    A_temp = A{i};
    beta_temp = beta{i};
    testY_temp = A_temp*beta_temp;
    
    %softmax to generate probabilites
    trainY_temp1 = bsxfun(@minus,testY_temp,max(testY_temp,[],2)); %for numerical stability
    num = exp(trainY_temp1);
    dem = sum(num,2);
    prob_scores = bsxfun(@rdivide,num,dem);
    ProbScores{i} = prob_scores;
end

TestingAccuracy = ComputeAcc(testY,ProbScores);
%% Calculate the testing accuracy
Testing_time = toc;



end