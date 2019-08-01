function y=CalAuc(sele_bta,geneMat,Surtime)
    PI = geneMat*sele_bta;
    mid_pi = (max(PI)+min(PI))/2;
    sortime=sort(Surtime);
    maxtime=(sortime(end)+sortime(end-1))/2;
    mintime=(sortime(1)+sortime(2))/2;
    deltat=(maxtime-mintime)/100;
    timelist=mintime:deltat:maxtime;
    lentime=length(timelist);
    % 开始遍历timelist,并计算每个点处的AUC
    AUC=zeros(1,lentime);
    SE = zeros(1,lentime);
    SP = zeros(1,lentime);
    for ii = 1:lentime
        label = Sur_PN(Surtime,timelist(ii));
        AUC(ii) = ROC(PI,label,1,0);
        SE(ii) = length(find((label == 1) & (PI > mid_pi)'))/length(find(label==1));
        SP(ii) = length(find((label == 0) & (PI <= mid_pi)'))/length(find(label==0));
    end 
    y = [AUC;SE;SP];
end