Some parts of the codes have been taken from:
1. Zhang, Le, and Ponnuthurai N. Suganthan. "A comprehensive evaluation of random vector functional link networks." Information sciences 367 (2016): 1094-1105.
2. Zhang, Yongshan, et al. "An unsupervised parameter learning model for RVFL neural network." Neural Networks 112 (2019): 85-97.
3. Tang, Jiexiong, Chenwei Deng, and Guang-Bin Huang. "Extreme learning machine for multilayer perceptron." IEEE transactions on neural networks and learning systems 27.4 (2015): 809-821.
4. https://github.com/tiepvupsu/FISTA

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
You need to tune/pass the values of the following parameters to the 'option' structure. 
After setting up the environment(dataset processings, tuning), you need to call the deepRVFL function.
For example:

option.N = 32; % #hidden neurons:[32,64,128,256,512,1024,2048,4096]
option.L = 3; % #hidden layers:[2:10]
option.C = -6; % regularization parameter:[-6:12]
option.sigma = 0.01; % #noise variance:[0%,1%,5%,10%,15%,25%,30%,50%,75%]
option.Act = 'selu'; % 'sigmoid','relu','selu' or any other activation function
option.method = 'direct'; % method:'direct','dense','denoise'
option.noise = 'masking'; % noise type:'masking','gaussian'
option.reg_choice = 'l1'; % regularization type:'l1','l2','el'
option.numOfiterations = 50; % #iterations for l1 and elastic reg: 50,100,200,300

[model_RVFL,train_acc,test_acc] = deepRVFL(trainX,trainY,testX,testY,option);


The codes are not optimized for efficiency. The codes have been cleaned for better readability
and documented and are not exactly the same as used in our paper. We have re-run and checked the
codes only in few datasets so if you find any bugs/issues, please write to
Rakesh (katuwalrakesh@gmail.com).


06-JUN-2020