function [geneMat,genename]=preprocess(adress)
    [num,txt] = xlsread(adress);
     Gene=txt(2:end,2); %����Ϊ����ĸ���
    [M,N]=size(num);
    postnum=zeros(M,N);
    record=zeros(1,M);
    lr=1;
    postgene=cell(M,1);
    % ���Ƚ�һ�Զ�ȥ��
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
    %���潫���һ���д���
%     Gene=txt(2:end,2);
    %��ʱ��Gene�еĸ�����num��������ͬ
    presym=[];
    possym=Gene{1};
    pre=0;
    post=1;
    newind=0;
    while post ~=length(Gene)+1
        if ~(strcmp(possym,presym))
            postnum(newind+1,:)=num(post,:);
            postgene{newind+1}=Gene{post};
            newind = newind+1; %ָ���¾�������һ����ֵ��λ��
            pre = pre+1; % ָ����ǰһ����ͬ��λ��
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
            post=post-1; %��ʱpre��post֮������л�������ͬ��
            subnum=num(pre:post,:);
            for uu=1:N  %��ÿ������
                postnum(newind,uu)=max(subnum(1:end,uu)); % ����
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