function [beta,bias] = AE_beta(trainX,Nfea,option,i)

Nsample = size(trainX,1);
N = option.N;
s = 1;
sigma = option.sigma;

%weights of hidden layers of AE
if i==1
    w = s*(2*rand(Nfea,N)-1);
else
   if strcmp(option.method,'direct')
        w = s*(2*rand(N,N)-1);
   elseif strcmp(option.method,'dense') || strcmp(option.method,'denoise') 
        w = s*(2*rand(Nfea+(i-1)*N,N)-1);
   end
end
b = rand(1,N);

%% Autoencoder part
if strcmp(option.method,'denoise')
     Nfea = size(trainX,2);
    if strcmp(option.noise,'gaussian')       
        trainX_corr = trainX + normrnd(0,sigma,Nsample,Nfea); %corrupted by gaussian noise
    elseif strcmp(option.noise,'masking')           
        numOfzeros = ceil(sigma*size(trainX,2));
        zero_ind = randi(size(trainX,2),size(trainX,1),numOfzeros);
        mask_input = ones(size(trainX,1),size(trainX,2));
        mask_input(sub2ind(size(mask_input),repmat((1:size(zero_ind))',[1,size(zero_ind,2)]),zero_ind)) = 0;
        
        trainX_corr = mask_input .* trainX ;
    end
    A1 = trainX_corr * w + repmat(b,Nsample,1);
else
    A1 = trainX * w + repmat(b,Nsample,1);
end


if strcmp(option.Act,'sigmoid')
    A1 = sigmoid(A1);
elseif strcmp(option.Act,'relu')
    A1 = relu(A1);
elseif strcmp(option.Act,'selu')
    A1 = selu(A1);
end

beta = weight_comp(A1,trainX,option);
bias = sum(beta,1)./N;

end