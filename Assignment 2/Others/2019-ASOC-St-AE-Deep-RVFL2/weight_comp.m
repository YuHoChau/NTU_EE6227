function beta = weight_comp(A,B,option)

C = option.C;
Nsample = size(A,1);
numOfiterations = option.numOfiterations;

if strcmp(option.reg_choice,'l1') 
    beta = sparse_l1_autoencoder(A,B,1e-3,numOfiterations)';
elseif strcmp(option.reg_choice,'l2')
    beta = l2_autoencoder(A,B,C,Nsample)';    
elseif strcmp(option.reg_choice,'el')
    opts.lambda = 0.5; 
    opts.lambda2 = 0.5;
    opts.max_iter = numOfiterations; 
    beta = fista_enet(B,A,0,opts)';
end


end