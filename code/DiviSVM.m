function [trainMat,trainCata,testMat,testCata,number]=DiviSVM(geneMat,Catag)
%     load SVM_data1.mat
%     trainMat = TrainMat;
%     trainCata = TrainCata;
%     testMat = TestMat;
%     testCata = TestCata;
    M=size(geneMat,1);
    randnum=randperm(M);
    trainMat=geneMat(randnum(1:floor(0.7*M)),:);
    trainCata=Catag(randnum(1:floor(0.7*M)));
    testMat=geneMat(randnum(floor(0.7*M)+1:end),:);
    testCata=Catag(randnum(floor(0.7*M)+1:end));
    number = randnum;
    
    Ndata = load('..\data\TrTe.mat');
    TrainMat = Ndata.TrainMat;
    TrainCata = Ndata.TrainCata;
    TestMat = Ndata.TestMat;
    TestCata = Ndata.TestCata;
end