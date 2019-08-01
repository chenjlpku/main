function [slambda,salpha] = crossV(Data, lambda, alpha, d, S,Surtime)
    % 这里的Data行代表样本，列代表基因
    % 与用Netcox函数时候相反
    % d: censor information, 1 is uncensored, 0 is censored.
    % S: normalized network information
    % Surtime是生存时间的列矩阵
    [M,N]=size(Data);
    m = floor(M/5);
    data=cell(5,1);
    SurTime = cell(5,1);
    CV_d = cell(5,1);
    
    data{1}=Data(m+1:end,:);
    SurTime{1} = Surtime(m+1:end);
     CV_d{1} = d(m+1:end);
    
    data{2}=[Data(1:m,:);Data(2*m+1:end,:)];
    SurTime{2} = [Surtime(1:m,:);Surtime(2*m+1:end)];
    CV_d{2} = [d(1:m,:);d(2*m+1:end)];
    
    data{3}=[Data(1:2*m,:);Data(3*m+1:end,:)];
    SurTime{3} = [Surtime(1:2*m,:);Surtime(3*m+1:end)];
    CV_d{3} = [d(1:2*m,:);d(3*m+1:end)];
    
    data{4}=[Data(1:3*m,:);Data(4*m+1:end,:)];
    SurTime{4} = [Surtime(1:3*m,:);Surtime(4*m+1:end)];
    CV_d{4} = [d(1:3*m,:);d(4*m+1:end)];
    
    data{5}=Data(1:4*m,:);
    SurTime{5} = Surtime(1:4*m);
    CV_d{5} = d(1:4*m);
    
    bta=cell(5,1);
    for ii = 1:5
        bta{ii}=NetCox(data{ii},lambda,alpha,CV_d{ii},S,SurTime{ii});
    end 
    lenlam=length(lambda);
    lenalp=length(alpha);
    Cvpl=zeros(lenlam,lenalp);
    valC=zeros(1,5);
    maxC=-1000000;
    for ii = 1:lenlam
        for jj = 1:lenalp
            for kk = 1:5
                Bta=bta{kk}(ii,jj,:);
                Bta=reshape(Bta,N,1);
                valC(kk) = CalPL(Bta,Data,data{kk},Surtime,d,kk);
            end
            Cvpl(ii,jj)=sum(valC);
            if Cvpl(ii,jj)>maxC
                maxC=Cvpl(ii,jj);
                rei=ii;
                rej=jj;
            end
        end
    end
    slambda=lambda(rei);
    salpha=alpha(rej);
end