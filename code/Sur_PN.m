function Sur_cata = Sur_PN(Surtime,t)
    % 正例是在t时刻死亡的
    % 反例是在t时刻仍然存活的
    Sur_cata = zeros(1,length(Surtime));
    pos = find(Surtime<t);
    Sur_cata(pos) = 1;
end