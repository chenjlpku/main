function Sur_cata = Sur_PN(Surtime,t)
    % ��������tʱ��������
    % ��������tʱ����Ȼ����
    Sur_cata = zeros(1,length(Surtime));
    pos = find(Surtime<t);
    Sur_cata(pos) = 1;
end