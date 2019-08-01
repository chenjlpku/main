function beta = findBeta(w,b,MaxLen,TrianMat,TestMat,TestCata)
    % ��󳤶�С��MaxLen
    % w��һ��������
    % b��һ������
    sort_abs_w = sort(abs(w),'descend');
    min_value = sort_abs_w(MaxLen);
    ind=find(abs(w)>min_value);
    tempbeta = zeros(length(w),1);
    tempbeta(ind)=w(ind);
    if SVMaccuracy(tempbeta,b,TestMat,TestCata) > 0.05
        svm_cata = TrianMat*w+b;
        posInd = find(svm_cata>0);
        negInd = find(svm_cata<=0);% ������������
        s_p = sum(svm_cata(posInd));
        s_n = sum(abs(svm_cata(negInd)));
        mu_p = 1-svm_cata(posInd)/s_p;
        mu_n = 1-svm_cata(negInd)/s_n;
        m_p = sum(mu_p.*TrianMat,1);
        m_n = sum(mu_n.*TrainMat,1);
        r = w.*(m_p-m_n)';
        
        sort_r = sort(r,'descend'); % ��ʼ����
        min_value = sort_r(MaxLen);
        ind=find(r>min_value);
        tempbeta = zeros(length(w),1);
        tempbeta(ind)=w(ind);
        if SVMaccuracy(tempbeta,b,TestMat,TestCata) > 0.05
            MaxLen = ceil(MaxLen*(1.1));
            beta = findBeta(w,b,MaxLen,TrianMat,TestMat,TestCata);
        else
            beta = tempbeta;
        end
    else 
        beta = tempbeta;
    end
%     beta = load('..\data\beta.mat');
%     beta = beta.beta;
end