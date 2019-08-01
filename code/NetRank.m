function y= NetRank(array,j)
    %作用是找到第j个元素在array中的顺序
    % 通过二分法来找
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