function y= NetRank(array,j)
    %�������ҵ���j��Ԫ����array�е�˳��
    % ͨ�����ַ�����
    len=size(array);
    elej=array(j);
    sortA = sort(array,'descend');
    low =1 ;
    high = len(1);
    mid = ceil((low+high)/2);
    while elej ~= sortA(mid)
        if elej > sortA(mid)
            high=mid-1;
            mid = ceil((low+high)/2);
        else
            low =mid+1;
            mid = ceil((low+high)/2);
        end
    end
   y=mid;
end