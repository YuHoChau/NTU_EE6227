function [beta,bias] = AE_beta(trainX,option,i,Nfea)
% Prepared by Rakesh (rakeshku001@e.ntu.edu.sg).
% A very simple implementation of AE initialized RVFL based on the paper
% "An Unsupervised Parameter Learning Model for RVFL Neural Network" (neural network, 2019)
% Instead of random weight initlization, the weights are computed using AE
% You can change the activation function as you like
Nsample = size(trainX,1);
N = option.N;

%weights of hidden layers of AE
if i==1
    w = 2*rand(Nfea,N)-1;
else
   w = 2*rand(Nfea+N,N)-1;
end
b = rand(1,N);

%% Autoencoder part
A1 = trainX * w + repmat(b,Nsample,1);
A1 = relu(A1);

beta  =  sparse_l1_autoencoder(A1,trainX,1e-3,500)'; %l1-regulraization
bias = sum(beta,1)./N;

end