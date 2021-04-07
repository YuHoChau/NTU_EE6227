function [Model,TrainAcc,TestAcc,TrainingTime,TestingTime]  = deepRVFL(trainX,trainY,testX,testY,option)

ss = RandStream('mcg16807','Seed',0);
RandStream.setGlobalStream(ss);

% Train RVFL
[Model,TrainAcc,TrainingTime] = deepRVFLtrain(trainX,trainY,option);

% Using trained model, predict the testing data
[TestAcc,TestingTime] = deepRVFLpredict(testX,testY,Model,option);

end
%EOF