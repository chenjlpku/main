function [newGeneMat,newCatag]=BalanceData(geneMat,Catag)
    N = size(geneMat,2);    
    AddMat = zeros(40,N);
    for ii = 1:4
        AddMat((ii-1)*10+1:ii*10,:)=geneMat(1:10,:);
    end
    for ii=1:40
        p=0.1*rand(1,N)-0.05;
        AddMat(ii,:)=AddMat(ii,:)+p;
    end 
    newGeneMat=[AddMat;geneMat];
    newCatag=[ones(40,1);Catag];
    
    matMean=mean(mean(newGeneMat));
    transMat=(newGeneMat-matMean).^2;
    [row,col] = size(newGeneMat);
    theta=sum(sum(transMat))/(row*col);
    newGeneMat=(newGeneMat-matMean)/theta;
end