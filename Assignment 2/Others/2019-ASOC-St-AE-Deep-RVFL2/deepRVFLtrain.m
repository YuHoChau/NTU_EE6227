function [model,TrainingAccuracy,Training_time] = deepRVFLtrain(trainX,trainY,option)

[Nsample,Nfea] = size(trainX);
L = option.L;
N = option.N;
C = option.C;
eps = 0.00001;
mu = {};
sigma = {};

A = trainX; %initialization for direct 
A_merge = trainX; %initialization for dense 

tic

%% Autoencoder
for i = 1:L
    
    if strcmp(option.method,'direct')
        [w,b] = AE_beta(A,Nfea,option,i);
         weights{i} = w;
         biases{i} = b;    
         A = A*w+repmat(b,Nsample,1);
    elseif strcmp(option.method,'dense') || strcmp(option.method,'denoise')
         [w,b] = AE_beta(A_merge,Nfea,option,i);
         weights{i} = w;
         biases{i} = b;   
         A = A_merge*w+repmat(b,Nsample,1);
    end        
       
    
    if strcmp(option.Act,'sigmoid')
        A = sigmoid(A); %sigmoid act. function
        %layer normalization can also be used with sigmoid act. function
        
    elseif strcmp(option.Act,'relu')  
        A = relu(A);
        %relu with layer normalization
        mu{i} = mean(A,1);
        sigma{i} = std(A);
        
        A = bsxfun(@rdivide,A-repmat(mu{i},size(A,1),1),(sigma{i}+eps)); %;layer normalization
     elseif strcmp(option.Act,'selu')  
        A = selu(A);
        %selu with layer normalization
        mu{i} = mean(A,1);
        sigma{i} = std(A);
        
        A = bsxfun(@rdivide,A-repmat(mu{i},size(A,1),1),(sigma{i}+eps)); %;layer normalization
    end   
    
    if strcmp(option.method,'dense') || strcmp(option.method,'denoise')
        A_merge = [A_merge A];
    end
   
        
end


%% RVFL Classifier
b_clf = rand(1,N);
if strcmp(option.method,'direct')
    w_clf = 2*rand(Nfea+N,N)-1;   
    H_clf = [A trainX]; %original features re-use
elseif strcmp(option.method,'dense') || strcmp(option.method,'denoise')
    w_clf = 2*rand(Nfea+L*N,N)-1;
    H_clf = A_merge; % dense features re-use
end

T_clf = H_clf * w_clf+repmat(b_clf,Nsample,1);

if strcmp(option.Act,'sigmoid')
    T_clf = sigmoid(T_clf);
elseif strcmp(option.Act,'relu')    
    T_clf = relu(T_clf);
elseif strcmp(option.Act,'selu')    
    T_clf = selu(T_clf);
end

T_clf = [T_clf H_clf]; 
T_clf = [T_clf,ones(Nsample,1)]; 

if size(T_clf,2)<Nsample
    beta_clf = (eye(size(T_clf,2))/C+T_clf'*T_clf) \ T_clf'*trainY;
else
    beta_clf = T_clf'*((eye(size(T_clf,1))/C+T_clf*T_clf') \ trainY);
end

Training_time = toc;

%% Calculate the training accuracy
trainY_temp = T_clf * beta_clf;


%softmax to generate probabilites
trainY_temp1 = bsxfun(@minus,trainY_temp,max(trainY_temp,[],2)); %for numerical stability
num = exp(trainY_temp1);
dem = sum(num,2);
prob_scores = bsxfun(@rdivide,num,dem);
[max_prob,indx] = max(prob_scores,[],2);
[~, ind_corrClass] = max(trainY,[],2);
TrainingAccuracy = mean(indx == ind_corrClass);

model.L = L;
model.w = weights;
model.b = biases;
model.beta = beta_clf;
model.w_clf = w_clf;
model.b_clf = b_clf;

model.mu = mu;
model.sigma = sigma;

end