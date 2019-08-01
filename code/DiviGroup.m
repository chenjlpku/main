function [Group1,Group2,min_p] = DiviGroup(Surtime,d, beta,geneMat)
    d=1-d; % 0代表uncensored,1代表censored
    %Surtime 是列向量, d是列向量
    PI = geneMat*beta;
    [~,index]=sort(PI);
    min_ind = floor(0.3*length(PI));
    max_ind = ceil(0.7*length(PI));
    min_p = 1;
    for ii =min_ind:max_ind
        group1=Surtime(index(1:ii),:);
        mark1 = d(index(1:ii),:);
        group2=Surtime(index(ii+1:end),:);
        mark2 = d(index(ii+1:end),:);
        group1 = [group1,mark1];
        group2 = [group2,mark2];
        P_value = logrank(group1,group2);
        if P_value<min_p
            min_p =  P_value;
            Group1 = group1;
            Group2 = group2;
            PI_th = PI(index(ii));
        end
    end
end