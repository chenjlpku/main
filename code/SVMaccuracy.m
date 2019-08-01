function y=SVMaccuracy(w,b,geneMat,catag)
    M=size(geneMat,1);
    PreC=geneMat*w+b*ones(M,1);
    posInd = find(PreC>0);
    negInd = find(PreC<=0);
    PreC(posInd)=1;
    PreC(negInd)=-1;
    err = find(catag~=PreC);
    lerr=length(err);
    y=lerr/M;
end