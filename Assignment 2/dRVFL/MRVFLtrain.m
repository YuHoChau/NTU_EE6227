function [model,TrainingAccuracy,Training_time] = dRVFLtrain(trainX,trainY,option)

[Nsample,Nfea] = size(trainX);
N = option.N;
L = option.L;
C = option.C;
s = option.scale;  %scaling factor
act_fun = option.Activation;

A = cell(1,1); 
beta = cell(1,1);
weights = cell(L,1);
biases = cell(L,1);

A_input = trainX;

tic
for i = 1:L
    
    % Hidden Layer
    if i==1
        w = s*(2*rand(Nfea,N)-1);
    else
        w = s*(2*rand(N,N)-1);
    end
    b = s*rand(1,N);
    weights{i} = w; %store these for later use
    biases{i} = b;
    
    if i==1
        A1 = A_input * w;
    else
        A1 = A1 * w;
    end
    
    mu{i} = mean(A1,1);
    sigma{i} = std(A1);
    A1 = bsxfun(@rdivide,A1-repmat(mu{i},size(A1,1),1),sigma{i});
    A1 = A1+repmat(b,Nsample,1);
    
    % Activation function
    switch lower(act_fun)
        case "relu"
            A1 = relu(A1);
        case "sigmoid"
            A1 = sigmoid(A1);
        otherwise
            error("Not Implemented");
    end
    
    if i == 1
         % Output to classifier layer
         A1_temp1=[A_input,A1];
         A{1}=A1_temp1;
    else
         % Storage
         A1_temp1=A{1};
         A{1} = [A1_temp1,A1]; 
    end
    
    if i==L
        A1_temp1=A{1};
        A1_temp2=[A1_temp1,ones(Nsample,1)];
        A{1}=A1_temp2;
        beta_fin=l2_weights(A1_temp2,trainY,C,Nsample);
        beta{1}=beta_fin;
    end
end

Training_time = toc;

%% Calculate the training accuracy

ProbScores = cell(1,1); %depends on number of hidden layer
for i = 1:1
    A_temp = A{i};
    beta_temp = beta{i};
    trainY_temp = A_temp*beta_temp;
    %softmax to generate probabilites
    trainY_temp1 = bsxfun(@minus,trainY_temp,max(trainY_temp,[],2)); %for numerical stability
    num = exp(trainY_temp1);
    dem = sum(num,2);
    prob_scores = bsxfun(@rdivide,num,dem);
    ProbScores{i} = prob_scores;
end

TrainingAccuracy = ComputeAcc(trainY,ProbScores);

%%
model.L = L;
model.w = weights;
model.b = biases;
model.beta = beta;
model.mu = mu;
model.sigma = sigma;
model.Activation = act_fun;

end