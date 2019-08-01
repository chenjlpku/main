function y=Netconstruct(trainMatrix)
    % �д���sample
    % �д������
    [row,col] = size(trainMatrix);
    pierxM = ones(col,col);
%% ���濪ʼ����pierx����
    for i = 1:col
        for j = i+1:col
            A=trainMatrix(:,i);
            B=trainMatrix(:,j);
            meanA=mean(A);
            meanB=mean(B);
            rij=sum((A-meanA).*(B-meanB))/sqrt(sum((A-meanA).^2)*sum((B-meanB).^2));
            pierxM(i,j)=rij;
            pierxM(j,i)=rij; %����һ���Գƾ���
        end   
    end
% �õ���pierxM��ÿ������֮������ϵ����ÿһ���Լ�ÿһ�д���һ������
%% ����õ������ľ���
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






