 % cal RD
clear
clc
[GeneMat,GeneName] =  xlsread("SigExp.xlsx");
GeneNor = GeneMat(:,1:10);
GeneOva = GeneMat(:,11:end);
GeneNor_mean = mean(GeneNor,2);
GeneOva_mean = mean(GeneOva,2);

GeneNor_std = std(GeneNor,0,2);
GeneOva_std = std(GeneOva,0,2);
GeneNor_logmean = log2(GeneNor_mean);
GeneOva_logmean = log2(GeneOva_mean);

epsilon = 0:0.1:10;
RD_cv = zeros(1,length(epsilon));
for ii = 1:length(epsilon)
    RD = (GeneOva_logmean-GeneNor_logmean)./(log2(GeneNor_std)+log2(GeneOva_std) + epsilon(ii)); % resistance distance
    RD_std = std(RD);
    RD_mean = mean(RD);
    RD_cv(ii) = RD_std/RD_mean;
end 
[~,index] = min(abs(RD_cv));
RD = (GeneOva_logmean-GeneNor_logmean)./(log2(GeneNor_std)+log2(GeneOva_std) + epsilon(index)); % resistance distance
RD = roundn(RD,-2);

% start to plot
[RD_sort,index] = sort(RD);
Name_sort = GeneName(index);
bar(RD_sort);
hold on
plot(RD_sort,'g-','LineWidth',2)
ax = gca;
ax.XAxisLocation = 'origin';
set(gca,'XTickLabel',Name_sort)
h = gca;
th=rotateticklabel(h, 90);%调用下面的函数，坐标倾斜90度

