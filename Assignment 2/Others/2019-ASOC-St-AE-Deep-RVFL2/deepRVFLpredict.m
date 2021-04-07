function [TestingAccuracy,Testing_time] = deepRVFLpredict(testX,testY,model,option)

[Nsample,Nfea] = size(testX);

L = model.L;
w = model.w;
b= model.b;
beta_clf = model.beta;
w_clf = model.w_clf;
b_clf = model.b_clf;

mu = model.mu;
sigma = model.sigma;

eps = 0.00001;

A = testX; %initialization for direct
A_merge = testX; %initialization for dense 

tic
for i = 1:L    
    
    if strcmp(option.method,'direct')
          A = A*w{i}+ repmat(b{i},Nsample,1);
    elseif strcmp(option.method,'dense') || strcmp(option.method,'denoise')
         A = A_merge*w{i}+ repmat(b{i},Nsample,1);
    end  
       
    
    if strcmp(option.Act,'sigmoid')
        A  =  sigmoid(A);
    elseif strcmp(option.Act,'relu')
        %relu with layer normalization
        A = relu(A);
        A = bsxfun(@rdivide,A-repmat(mu{i},size(A,1),1),(sigma{i}+eps));
    elseif strcmp(option.Act,'selu')
        %selu with layer normalization
        A = selu(A);
        A = bsxfun(@rdivide,A-repmat(mu{i},size(A,1),1),(sigma{i}+eps));        
    end
    
    if strcmp(option.method,'dense') || strcmp(option.method,'denoise')
        A_merge = [A_merge A];
    end
    
end


%% RVFL Classifier

if strcmp(option.method,'direct')
    HH_clf = [A testX]; %original features re-use
elseif strcmp(option.method,'dense') || strcmp(option.method,'denoise')   
    HH_clf = A_merge; % dense features re-use
end

TT_clf = HH_clf*w_clf+repmat(b_clf,Nsample,1);

if strcmp(option.Act,'sigmoid')
    TT_clf = sigmoid(TT_clf);
elseif strcmp(option.Act,'relu') 
    TT_clf = relu(TT_clf);
elseif strcmp(option.Act,'selu') 
    TT_clf = selu(TT_clf);
end


TT_clf = [TT_clf HH_clf]; %direct links for RVFL
TT_clf = [TT_clf,ones(Nsample,1)];

rawScore = TT_clf * beta_clf;

%softmax to generate probabilites
rawScore_temp1 = bsxfun(@minus,rawScore,max(rawScore,[],2));
num = exp(rawScore_temp1);
dem = sum(num,2);
prob_scores = bsxfun(@rdivide,num,dem);
[max_prob,indx] = max(prob_scores,[],2);
[~, ind_corrClass] = max(testY,[],2);
TestingAccuracy = mean(indx == ind_corrClass);

Testing_time = toc;



end