%% ����Ԥ����
[geneMat,genename]=preprocess('..\data\GSE26712.xlsx');
Catag=xlsread('..\data\Catag.xlsx');
[NewGeneMat,NewCatag]=BalanceData(geneMat,Catag);
[TrainMat,TrainCata,TestMat,TestCata,number]=DiviSVM(NewGeneMat,NewCatag);


%% SVM����
% �����ǻ�ȡtheta���Ͻ�
[aopt,bopt] = yalmip_SVM_norm(TrainMat,TrainCata,10^10);
% x = optiSVM_norm(10^6,TrainMat,TrainCata);
% N = size(TrainMat,2);
% maxTheta = sum(abs(x(1:N)))^2;
MaxLen = 700;
beta = findBeta(aopt, bopt,MaxLen,TrainMat,TestMat,TestCata); %�ҵ�����һ��beta,ʹ��׼ȷ�ʴ���Acc
% �൱��ѡ����һ���ֻ���

%% Net-Cox����
geneInd = find(beta~=0);
geneMat = NewGeneMat(end-152:end,:);
% geneMat = MatNRorm(geneMat);
NetGeneMat = NewgeneMat(beta,geneMat);  %ȡ����beta����0���ֶ�Ӧ��gene
GeneName = genename(geneInd);
Surtime = xlsread('..\data\Survival time.xlsx');
[trainCoxMat,trainCoxTime,testCoxMat,testCoxTime]=DiviCox(NetGeneMat,Surtime);
train_d = trainCoxTime(:,2);
train_SurTime = trainCoxTime(:,1);
test_d = testCoxTime(:,2);
test_SurTime = testCoxTime(:,1);
S = Netconstruct(trainCoxMat); % ��������֮��Ĺ��������
lambda = [1e-3,1e-2,1e-1];
alpha = [0.01,0.1,0.5,0.95];
[slambda,salpha] = crossV(trainCoxMat,lambda,alpha,train_d,S,train_SurTime);
bta = NetCox(trainCoxMat, slambda, salpha, train_d, S,train_SurTime);
% bta = load('..\data\bta.mat');
% bta = bta.bta;
% [~,~,lenBta]=size(bta);
% bta = reshape(bta,lenBta,1);
%% ��֤����
sele_bta = selectBta(bta);
figure(1)
[Group1,Group2,min_p] = DiviGroup(test_SurTime,test_d,sele_bta,testCoxMat);
% AUC=CalCuAuc(testCoxMat,sele_bta,test_SurTime);
% plot(AUC)
figure(2)
AUC_SE_SP  = CalAuc(sele_bta,testCoxMat,test_SurTime);
plot(AUC_SE_SP(1,:))




