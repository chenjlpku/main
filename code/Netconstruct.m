function y=Netconstruct(trainMatrix)
    % 行代表sample
    % 列代表基因
    [row,col] = size(trainMatrix);
    pierxM = ones(col,col);
%% 下面开始计算pierx矩阵
    for i = 1:col
        for j = i+1:col
            A=trainMatrix(:,i);
            B=trainMatrix(:,j);
            meanA=mean(A);
            meanB=mean(B);
            rij=sum((A-meanA).*(B-meanB))/sqrt(sum((A-meanA).^2)*sum((B-meanB).^2));
            pierxM(i,j)=rij;
            pierxM(j,i)=rij; %这是一个对称矩阵
        end   
    end
% 得到的pierxM是每个基因之间的相关系数，每一行以及每一列代表一个基因
%% 下面得到排序后的矩阵
    rankM = ones(col,col);
    d = zeros(1,col);
    for i = 1:col
        for j = i+1:col
            Rij = NetRank(pierxM(:,i),j);
            Rji = NetRank(pierxM(:,j),i);
            rankM(i,j) = 1/(Rij*Rji);
            rankM(j,i) = 1/(Rij*Rji);
        end
        d(i)=1/sqrt(sum(rankM(i,:)));
    end 
    D = diag(d);
    y=D*pierxM*D;
end






