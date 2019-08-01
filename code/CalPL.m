function y=CalPL(Bta,Data,data,Surtime,d,kk)
    M=size(Data,1);
    m=floor(M/5);
    S1=0;
    for ii = 1:M
        t=Surtime(ii);
        R=find(Surtime>t);
        lenR=length(R);
        RiskS=0;
        for jj =1:lenR
            X=Data(R(jj),:);
            PI=X*Bta;
            RiskS=RiskS+exp(PI);
        end
        if RiskS ~= 0
             RiskS=log2(RiskS);
        end
        X=Data(ii,:);
        PI=X*Bta;
        S1=S1+d(ii)*(PI-RiskS);
    end
    if kk==1
        Surt=Surtime(m+1:end,:);
        CV_d = d(m+1:end,:);
    elseif kk==5
        Surt=Surtime(1:4*m,:);
        CV_d = d(1:4*m,:);
    else
        Surt=[Surtime(1:(kk-1)*m);Surtime(kk*m+1:end)];
        CV_d=[d(1:(kk-1)*m);d(kk*m+1:end)];
    end
    lenM=length(Surt);
    S2=0;
    for ii = 1:lenM
        t=Surt(ii);
        R=find(Surt>t);
        lenR=length(R);
        RiskS=0;
        for jj =1:lenR
            X=data(R(jj),:);
            PI=X*Bta;
            RiskS=RiskS+exp(PI);
        end
        if RiskS ~= 0
            RiskS=log2(RiskS);
        end
        X=data(ii,:);
        PI=X*Bta;
        S2=S2+CV_d(ii)*(PI-RiskS);
    end
    y=S1-S2;
end