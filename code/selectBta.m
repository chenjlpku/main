function sele_bta = selectBta(bta)
    [~,index]=sort(abs(bta),'descend');
    sele_bta = zeros(length(bta),1);
    sele_bta(index(1:105))=bta(index(1:105));
end