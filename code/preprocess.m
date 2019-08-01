function [geneMat,genename]=preprocess(adress)
    [num,txt] = xlsread(adress);
     Gene=txt(2:end,2); %个数为基因的个数
    [M,N]=size(num);
    postnum=zeros(M,N);
    record=zeros(1,M);
    lr=1;
    postgene=cell(M,1);
    % 首先将一对多去除
    for ii=1:length(Gene)
        gene=Gene{ii};
        if contains(gene,'/')
            record(lr)=ii;
            lr=lr+1;
        end
    end
    record(lr:end)=[];
    num(record,:)=[];
    Gene(record)=[];
    %下面将多对一进行处理
%     Gene=txt(2:end,2);
    %此时的Gene中的个数和num的行数相同
    presym=[];
    possym=Gene{1};
    pre=0;
    post=1;
    newind=0;
    while post ~=length(Gene)+1
        if ~(strcmp(possym,presym))
            postnum(newind+1,:)=num(post,:);
            postgene{newind+1}=Gene{post};
            newind = newind+1; %指向新矩阵的最后一行有值的位置
            pre = pre+1; % 指向与前一个不同的位置
            presym = Gene{pre};
            post = post+1;
            possym=Gene{post};
        else
            while strcmp(presym,possym)
                post=post+1;
                if post<=length(Gene)
                    possym=Gene{post};
                else
                    break;
                end 
            end
            post=post-1; %此时pre到post之间的所有基因都是相同的
            subnum=num(pre:post,:);
            for uu=1:N  %对每个样本
                postnum(newind,uu)=max(subnum(1:end,uu)); % 修正
            end
            pre=post;
            post=post+1;
            if post>length(Gene)
                break;
            end
            presym = Gene{pre};
            possym = Gene{post};
        end
    end
    postnum(newind+1:end,:)=[];
    postgene(newind+1:end)=[];
    gene=string(postgene);
    index=find(gene=='');
    gene(index)=[];
    postnum(index,:)=[];
    geneMat=postnum';
    genename=gene;
end