function [trainCoxMat,trainCoxTime,testCoxMat,testCoxTime]=GetCoxData(geneMat,Surtime,beta)
    M=size(geneMat,1); 
%     randnum = randperm(M);
%     trainCoxMat=geneMat(randnum(1:floor(0.7*M)),:);
%     trainCoxTime=Surtime(randnum(1:floor(0.7*M)),:);
%     testCoxMat=geneMat(randnum(floor(0.7*M)+1:end),:);
%     testCoxTime=Surtime(randnum(floor(0.7*M)+1:end),:);
%     
%     geneMat = geneMat(end-152:end,:);
%     ind=find(beta~=0);
%     NetGeneMat = geneMat(:,ind);
    
    NCoxData = load('..\data\CoxTrTe.mat');
    trainCoxMat = NCoxData.trainCoxMat;
    trainCoxTime = NCoxData.trainCoxTime;
    testCoxMat = NCoxData.testCoxMat;
    testCoxTime = NCoxData.testCoxTime;
end