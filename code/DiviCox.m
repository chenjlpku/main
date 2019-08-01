function [trainCoxMat,trainCoxTime,testCoxMat,testCoxTime]=DiviCox(geneMat,Surtime)
    M=size(geneMat,1); 
    randnum = randperm(M);
    trainCoxMat=geneMat(randnum(1:floor(0.7*M)),:);
    trainCoxTime=Surtime(randnum(1:floor(0.7*M)),:);
    testCoxMat=geneMat(randnum(floor(0.7*M)+1:end),:);
    testCoxTime=Surtime(randnum(floor(0.7*M)+1:end),:);
    
    NCoxData = load('..\data\CoxTrTe.mat');
    trainCoxMat = NCoxData.trainCoxMat;
    trainCoxTime = NCoxData.trainCoxTime;
    testCoxMat = NCoxData.testCoxMat;
    testCoxTime = NCoxData.testCoxTime;
end